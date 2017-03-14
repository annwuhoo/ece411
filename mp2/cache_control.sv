import lc3b_types::*;

module cache_control
(
    input clk,

	 /* Datapath */
	 input logic cache_hit, dirty, valid,
	 output logic lru_or_way,
	 output logic load_data_valid_dirty, load_tag,
	 output logic [1:0] loadlrumux_sel,
	 output logic dirty_val,
	 output logic datainmux_sel,
	 
	 /* CPU */
	 input  logic mem_read,
    input  logic mem_write,
    output logic mem_resp,
	 
	 /* Main memory */
	 output logic pmem_read, 
	 output logic pmem_write,
	 input  logic pmem_resp
);

enum int unsigned { /* list of states */
	s_hitmiss,
	s_writeback,
	s_loadline,
	s_writeline
} state, next_state;

always_comb
begin : state_actions /* Output assignments */
	 load_data_valid_dirty = 0;
	 load_tag = 0;
	 loadlrumux_sel = 2'b00; // load_lru = 0
	 lru_or_way = 0;
	 dirty_val = 0;
	 datainmux_sel = 0;
	 mem_resp = 0;
	 pmem_read = 0;
	 pmem_write = 0;

	case(state)
		s_hitmiss: begin
			mem_resp = cache_hit;
			loadlrumux_sel = 2'b10;
			lru_or_way = 1; // choose the way_sel as the arbitrator for the load signals in cache hit state
			if (cache_hit) begin // only allow writes if there is a write hit - not on write misses
				datainmux_sel = 1;
				dirty_val = 1;
				load_data_valid_dirty = mem_write;
			end
		end
		
		s_writeback: begin
			pmem_write = 1;
		end
		
		s_loadline: begin
			pmem_read = 1;
			lru_or_way = 0; // choose lru as arbitrator for load signals in cache miss states
			load_tag = 1;
			datainmux_sel = 0;
			dirty_val = 0;
			load_data_valid_dirty = 1;
		end
		
		s_writeline: begin
			lru_or_way = 0; // choose lru as arbitrator for load signals in cache miss states
			datainmux_sel = 1;
			dirty_val = 1;
			load_data_valid_dirty = 1;
			mem_resp = 1;
			loadlrumux_sel = 2'b01; // i.e. load_lru = 1
		end
		
		default: /* Do nothing */;
	endcase
end		

always_comb
begin : next_state_logic
	next_state = state;

	case(state)
		s_hitmiss: begin
			if (~cache_hit & dirty & valid & (mem_write | mem_read)) begin next_state = s_writeback; end
			else if (~cache_hit & ~dirty & (mem_write | mem_read)) begin next_state = s_loadline; end
			else begin next_state = s_hitmiss; end
		end
		
		s_writeback: begin 
			if (~pmem_resp) begin next_state = s_writeback; end
			else begin next_state = s_loadline; end
		end
		
		s_loadline: begin
			if (~pmem_resp) begin next_state = s_loadline; end
			else begin
				if (mem_write) begin next_state = s_writeline; end
				else begin next_state = s_hitmiss; end // mem_read
			end
		end
		
		s_writeline: next_state = s_hitmiss;
		
		default: $display("Next_state_logic: unknown state");
	
	endcase
end	
	
always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_state;
end

endmodule : cache_control