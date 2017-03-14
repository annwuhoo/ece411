import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module cpu_control
(
	input clk,
	
	/* datapath to control */
	input lc3b_opcode opcode,
	input branch_enable,
	input lc3b_bit bit5, bit11,

    /* control to datapath */
	output logic [1:0] pcmux_sel, // PC
	output logic pcaddermux_sel, load_pc,
	output logic load_ir, storemux_sel, destmux_sel, load_regfile, // IR and REGFILE
	output logic [2:0] regfilemux_sel,
	output logic [1:0] alumux_sel, // ALU
	output lc3b_aluop aluop,
	output logic load_cc, // BRANCH
	output logic load_mar, load_mdr, // MAR and MDR
	output logic [1:0] marmux_sel, mdrmux_sel,

	/* Memory signals */
	input mem_resp, mem_addr0,
	output logic mem_read,
	output logic mem_write,
	output lc3b_mem_wmask mem_byte_enable
);

enum int unsigned { /* list of states */
	fetch1, fetch2, fetch3,
	decode,
	s_add,
	s_add_imm,
	s_and,
	s_and_imm,
	s_not,
	br, br_taken,
	calc_addr, s_ldr1, s_ldr2,
	s_str1, s_str2,
	s_jmp_jsrr,
	s_lea,
	s_storepc, s_jsr,
	calc_addr2, s_ldb2,
	s_ldi1, s_ldi2,
	s_shf,
	s_stb1, s_stb2_lower, s_stb2_higher,
	s_trap1, s_trap3
} state, next_state;

always_comb
begin : state_actions /* Output assignments */
	// to datapath
	pcmux_sel = 2'b00;
	pcaddermux_sel = 1'b0;
	load_pc = 1'b0;
	load_ir = 1'b0;
	storemux_sel = 1'b0;
	destmux_sel = 1'b0;
	load_regfile = 1'b0;
	regfilemux_sel = 3'b00;
	alumux_sel = 2'b00;
	aluop = alu_add;
	load_cc = 1'b0;
	load_mar = 1'b0;
	load_mdr = 1'b0;
	marmux_sel = 2'b00;
	mdrmux_sel = 2'b00;
	// to memory
	mem_read = 1'b0;
	mem_write = 1'b0;
	mem_byte_enable = 2'b11;

	case(state)
		fetch1: begin
			/* MAR <= PC */
			marmux_sel = 2'b01;
			load_mar = 1;
			
			/* PC <= PC + 2 */
			pcmux_sel = 2'b00;
			load_pc = 1;
		end
		
		fetch2: begin
			/* Read memory */
			mem_read = 1;
			mdrmux_sel = 2'b01;
			load_mdr = 1;
		end
	
		fetch3: begin
			/* Load IR */
			load_ir = 1;
		end
		
		decode: /* Do nothing */;
	
		s_add: begin
			/* DR <= SRA + SRB */
			aluop = alu_add;
			alumux_sel = 2'b00;
			regfilemux_sel = 3'b00;
			load_regfile = 1;
			load_cc = 1;
		end
		
		s_add_imm: begin
			/* DR <= SRA + IMM5 */
			aluop = alu_add;
			alumux_sel = 2'b10;
			regfilemux_sel = 3'b00;
			load_regfile = 1;
			load_cc = 1;
		end
		
		s_and: begin
			/* DR <= SRA & SRB */
			aluop = alu_and;
			alumux_sel = 2'b00;
			regfilemux_sel = 3'b00;
			load_regfile = 1;
			load_cc = 1;
		end
		
		s_and_imm: begin
			/* DR <= SRA & IMM5 */
			aluop = alu_and;
			alumux_sel = 2'b10;
			regfilemux_sel = 3'b00;
			load_regfile = 1;
			load_cc = 1;
		end
		
		s_not: begin
			/* DR <= ~A */
			aluop = alu_not;
			load_regfile = 1;
			regfilemux_sel = 3'b00;
			load_cc = 1;
		end
		
		br: /* Do nothing */ begin
			pcmux_sel = 2'b00;
			load_pc = 0;
		end
		
		br_taken: begin
			/* PC <= PC + SEXT(IR[8:0] << 1) */
			pcaddermux_sel = 0; // choose adj9
			pcmux_sel = 2'b01;
			load_pc = 1;
		end
		
		calc_addr: begin
			/* MAR <= A + SEXT(ir[5:0] << 1) */
			alumux_sel = 2'b01;
			aluop = alu_add;
			load_mar = 1;
		end
		
		s_ldr1: begin
			/* MDR <= M[MAR] */
			mdrmux_sel = 2'b01;
			load_mdr = 1;
			mem_read = 1;
		end
		
		s_ldr2: begin
			/* DR <= MDR */
			regfilemux_sel = 3'b001;
			load_regfile = 1;
			load_cc = 1;
		end
		
		s_str1: begin
			/* MDR <= SR */
			storemux_sel = 1;
			aluop = alu_pass;
			load_mdr = 1;
		end
		
		s_str2: begin
			/* M[MAR] <= MDR */
			mem_write = 1;
		end
		
		s_jmp_jsrr: begin
			/* PC <= BaseR */
			storemux_sel = 0;
			pcmux_sel = 2'b10;
			load_pc = 1;
		end
		
		s_lea: begin
			/* DR <= PC + (SEXT(PCoffset9) << 1) */
			pcaddermux_sel = 0;
			regfilemux_sel = 3'b010;
			load_regfile = 1;
			load_cc = 1;
		end
		
		s_storepc: begin
			/* R7 <= PC */
			regfilemux_sel = 3'b011;
			destmux_sel = 1;
			load_regfile = 1;
		end
		
		s_jsr: begin
			/* PC <= PC + (SEXT(PCoffset11) << 1) */
			pcaddermux_sel = 1;
			pcmux_sel = 2'b01;
			load_pc = 1;
		end
		
		calc_addr2: begin
			/* MAR <= BaseR + SEXT(offset6) */
			alumux_sel = 2'b11;
			aluop = alu_add;
			load_mar = 1;
		end
		
		s_ldb2: begin
			/* DR <= ZEXT(one byte of MDR) */
			regfilemux_sel = 3'b100;
			load_regfile = 1;
			load_cc = 1;
		end
		
		s_ldi1: begin
			/* MAR <= MDR */
			marmux_sel = 2'b10;
			load_mar = 1;
		end
		
		s_ldi2: begin // same as s_ldr1
			/* MDR <= M[MAR] */
			mdrmux_sel = 2'b01;
			load_mdr = 1;
			mem_read = 1;
		end
		
		s_shf: begin
			/* DR <= a shifting operation on SR */
			regfilemux_sel = 3'b101;
			load_regfile = 1;
			load_cc = 1;
		end
		
		s_stb1: begin
			/* MDR <= {SR[7:0], SR[7:0]} */
			storemux_sel = 1;
			mdrmux_sel = 2'b10;
			load_mdr = 1;
		end
		
		s_stb2_lower: begin
			/* M[lower byte of MAR] <= MDR */
			mem_byte_enable = 2'b01;
			mem_write = 1;
		end
		
		s_stb2_higher: begin
			/* M[higher byte of MAR] <= MDR */
			mem_byte_enable = 2'b10;
			mem_write = 1;
		end
		
		s_trap1: begin
			/* MAR <= ZEXT(trapvect8) << 1 */
			marmux_sel = 2'b11;
			load_mar = 1;
		end
		
		s_trap3: begin
			/* PC <= MDR */
			pcmux_sel = 2'b11;
			load_pc = 1;
		end
		
		default: /* Do nothing */;
	
	endcase

end

always_comb
begin : next_state_logic
	/* Next state information and conditions (if any)
	 * for transitioning between states */
	next_state = state;

	case(state)
		fetch1: next_state = fetch2;
		fetch2: begin
			if (mem_resp == 1'b0) begin next_state = fetch2; end
			else begin next_state = fetch3; end
		end
		fetch3: next_state = decode;
		decode: begin
			case(opcode)
				op_add: begin
					if (bit5) begin next_state = s_add_imm; end
					else begin next_state = s_add; end
				end 
				op_and: begin
					if (bit5) begin next_state = s_and_imm; end
					else begin next_state = s_and; end
				end 
				op_not: next_state = s_not;
				op_ldr: next_state = calc_addr;
				op_str: next_state = calc_addr;
				op_br: next_state = br;
				op_jmp: next_state = s_jmp_jsrr;
				op_lea: next_state = s_lea;
				op_jsr: next_state = s_storepc;
				op_ldb: next_state = calc_addr2;
				op_ldi: next_state = calc_addr;
				op_shf: next_state = s_shf;
				op_stb: next_state = calc_addr2;
				op_sti: next_state = calc_addr;
				op_trap: next_state = s_storepc;
				default: $display("Decode: unknown opcode");
			endcase
		end
		s_add: next_state = fetch1;
		s_add_imm: next_state = fetch1;
		s_and: next_state = fetch1;
		s_and_imm: next_state = fetch1;
		s_not: next_state = fetch1;
		calc_addr: begin
			case(opcode)
				op_ldr: next_state = s_ldr1;
				op_str: next_state = s_str1;
				op_ldi: next_state = s_ldr1;
				op_sti: next_state = s_ldr1;
				default: $display("Calc_addr: unknown opcode");
			endcase
		end
		s_ldr1: begin
			if (mem_resp == 1'b0) begin next_state = s_ldr1; end
			else begin 
				case(opcode)
					op_ldr: next_state = s_ldr2;
					op_ldi: next_state = s_ldi1;
					op_ldb: next_state = s_ldb2;
					op_sti: next_state = s_ldi1;
					op_trap: next_state = s_trap3;
					default: $display("Error in ldr1");
				endcase
			end
		end
		s_ldr2: next_state = fetch1;
		s_str1: begin
			case(opcode)
				op_str: next_state = s_str2;
				op_sti: next_state = s_str2; // don't really need this specification, just for redundancy for now
				default: $display("Error in s_str1");
			endcase
		end
		s_str2: begin // used for both op_str and op_sti
			if (mem_resp == 1'b0) begin next_state = s_str2; end
			else begin next_state = fetch1; end
		end
		br: begin
			if (branch_enable) begin next_state = br_taken; end
			else begin next_state = fetch1; end
		end
		br_taken: next_state = fetch1;
		s_jmp_jsrr: next_state = fetch1;
		s_lea: next_state = fetch1;
		s_storepc: begin
			if (bit11) begin next_state = s_jsr; end
			else begin 
				case(opcode)
					op_jsr: next_state = s_jmp_jsrr; 
					op_trap: next_state = s_trap1; // bit11 is always 0 for TRAP
					default: $display("Error in storepc");
				endcase
			end
		end
		s_jsr: next_state = fetch1;
		calc_addr2: begin
			case(opcode)
				op_ldb: next_state = s_ldr1;
				op_stb: next_state = s_stb1;
				default: $display("Error in calc_addr2");
			endcase
		end
		s_ldb2: next_state = fetch1;
		s_ldi1: begin
			case(opcode)
				op_ldi: next_state = s_ldi2;
				op_sti: next_state = s_str1;
				default: $display("Error in s_ldi1");
			endcase
		end
		s_ldi2: begin
			if (mem_resp == 1'b0) begin next_state = s_ldi2; end
			else begin next_state = s_ldr2; end
		end
		s_shf: next_state = fetch1;
		s_stb1: begin
			if (mem_addr0 == 1'b0) begin next_state = s_stb2_lower; end
			else begin next_state = s_stb2_higher; end
		end
		s_stb2_lower: begin
			if (mem_resp == 1'b0) begin next_state = s_stb2_lower; end
			else begin next_state = fetch1; end
		end
		s_stb2_higher: begin
			if (mem_resp == 1'b0) begin next_state = s_stb2_higher; end
			else begin next_state = fetch1; end
		end
		s_trap1: next_state = s_ldr1;
		s_trap3: next_state = fetch1;
		
		default: $display("Next_state_logic: unknown state");
	
	endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_state;
end

endmodule : cpu_control
