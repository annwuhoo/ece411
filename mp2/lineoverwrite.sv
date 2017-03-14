import lc3b_types::*;

/* 
 * Overwrites the cache line to the correct word based on the offset and mem_byte_enable
 * Granularity = 16 bit
 */
module lineoverwrite
(
	input [2:0] offset,
	input lc3b_line datain,
	input lc3b_word mem_wdata,
	input  lc3b_mem_wmask mem_byte_enable,
	output lc3b_line dataout
);

// Construct the three possible rewritten cache lines (based on offset), i.e. mem_byte_enable = 11, 01 or 10
lc3b_word d0_all, d1_all, d2_all, d3_all, d4_all, d5_all, d6_all, d7_all;
lc3b_word d0_high, d1_high, d2_high, d3_high, d4_high, d5_high, d6_high, d7_high;
lc3b_word d0_low, d1_low, d2_low, d3_low, d4_low, d5_low, d6_low, d7_low;

lc3b_line out_all, out_high, out_low;

always_comb begin
	d0_all = datain[15:0];
	d1_all = datain[31:16];
	d2_all = datain[47:32];
	d3_all = datain[63:48];
	d4_all = datain[79:64];
	d5_all = datain[95:80];
	d6_all = datain[111:96];
	d7_all = datain[127:112];
	
	d0_high = datain[15:0];
	d1_high = datain[31:16];
	d2_high = datain[47:32];
	d3_high = datain[63:48];
	d4_high = datain[79:64];
	d5_high = datain[95:80];
	d6_high = datain[111:96];
	d7_high = datain[127:112];
	
	d0_low = datain[15:0];
	d1_low = datain[31:16];
	d2_low = datain[47:32];
	d3_low = datain[63:48];
	d4_low = datain[79:64];
	d5_low = datain[95:80];
	d6_low = datain[111:96];
	d7_low = datain[127:112];
	
	case(offset)
		3'b000: begin
			d0_all = mem_wdata;
			d0_high = {mem_wdata[15:8], d0_high[7:0]};
			d0_low = {d0_low[15:8], mem_wdata[7:0]};
		end
		3'b001: begin
			d1_all = mem_wdata;
			d1_high = {mem_wdata[15:8], d1_high[7:0]};
			d1_low = {d1_low[15:8], mem_wdata[7:0]};
		end
		3'b010: begin
			d2_all = mem_wdata;
			d2_high = {mem_wdata[15:8], d2_high[7:0]};
			d2_low = {d2_low[15:8], mem_wdata[7:0]};
		end
		3'b011: begin
			d3_all = mem_wdata;
			d3_high = {mem_wdata[15:8], d3_high[7:0]};
			d3_low = {d3_low[15:8], mem_wdata[7:0]};
		end
		3'b100: begin
			d4_all = mem_wdata;
			d4_high = {mem_wdata[15:8], d4_high[7:0]};
			d4_low = {d4_low[15:8], mem_wdata[7:0]};
		end
		3'b101: begin
			d5_all = mem_wdata;
			d5_high = {mem_wdata[15:8], d5_high[7:0]};
			d5_low = {d5_low[15:8], mem_wdata[7:0]};
		end
		3'b110: begin
			d6_all = mem_wdata;
			d6_high = {mem_wdata[15:8], d6_high[7:0]};
			d6_low = {d6_low[15:8], mem_wdata[7:0]};
		end
		3'b111: begin
			d7_all = mem_wdata;
			d7_high = {mem_wdata[15:8], d7_high[7:0]};
			d7_low = {d7_low[15:8], mem_wdata[7:0]};
		end
	endcase
end

// Concatenate those words together into cache lines
assign out_all = {d7_all, d6_all, d5_all, d4_all, d3_all, d2_all, d1_all, d0_all};
assign out_high = {d7_high, d6_high, d5_high, d4_high, d3_high, d2_high, d1_high, d0_high};
assign out_low = {d7_low, d6_low, d5_low, d4_low, d3_low, d2_low, d1_low, d0_low};

//assign out_all = {d0_all, d1_all, d2_all, d3_all, d4_all, d5_all, d6_all, d7_all};
//assign out_high = {d0_high, d1_high, d2_high, d3_high, d4_high, d5_high, d6_high, d7_high};
//assign out_low = {d0_low, d1_low, d2_low, d3_low, d4_low, d5_low, d6_low, d7_low};


// Choose the right replacement line (based on mem_byte_enable)
mux4 #(.width(128)) outmux
(
	.sel(mem_byte_enable),
	.a(),
	.b(out_low),
	.c(out_high),
	.d(out_all),
	.f(dataout)
);

endmodule : lineoverwrite