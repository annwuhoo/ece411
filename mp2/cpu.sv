import lc3b_types::*;

// Contains CPU datapath and CPU controller
module cpu
(
    input clk,

    /* Memory signals */
    input mem_resp,
    input lc3b_word mem_rdata,
    output mem_read,
    output mem_write,
    output lc3b_mem_wmask mem_byte_enable,
    output lc3b_word mem_address,
    output lc3b_word mem_wdata
);

/* Internal signals */
logic load_pc, pcaddermux_sel, load_ir, storemux_sel, destmux_sel, load_regfile, load_cc, load_mar, load_mdr;
logic [1:0] pcmux_sel, alumux_sel, marmux_sel, mdrmux_sel;
logic [2:0] regfilemux_sel;
lc3b_aluop aluop;
lc3b_opcode opcode;
logic branch_enable;
lc3b_bit bit5, bit11;

/* Instantiate MP 0 top level blocks here */
cpu_datapath cpu_dp
(
	.clk,
	
    /* control to datapath */
	.pcmux_sel,
	.pcaddermux_sel,
	.load_pc,
	.load_ir,
	.storemux_sel,
	.destmux_sel,
   .load_regfile,
	.regfilemux_sel,
	.alumux_sel,
	.aluop,
	.load_cc,
	.load_mar,
	.load_mdr,
	.marmux_sel,
	.mdrmux_sel,
	
	/* memory to datapath */
	.mem_rdata,
	
	/* datapath to control */
	.opcode,
	.branch_enable,
	.bit5,
	.bit11,
	
	/* datapath to memory */
	.mem_wdata,
	.mem_address
);

cpu_control cpu_ctrl
(
	.clk,
	
	/* datapath to control */
	.opcode,
	.branch_enable,
	.bit5,
	.bit11,

    /* control to datapath */
	.pcmux_sel,
	.pcaddermux_sel,
	.load_pc,
	.load_ir,
	.storemux_sel,
	.destmux_sel,
	.load_regfile,
	.regfilemux_sel,
	.alumux_sel,
	.aluop,
	.load_cc,
	.load_mar,
	.load_mdr,
	.marmux_sel,
	.mdrmux_sel,

	/* Memory signals */
	.mem_resp,
	.mem_addr0(mem_address[0]),
	.mem_read,
	.mem_write,
	.mem_byte_enable
);

endmodule : cpu
