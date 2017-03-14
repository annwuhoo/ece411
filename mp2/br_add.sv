module br_add #(parameter width = 16)
(
	input [width-1:0] pc_addr_in,
	input [width-1:0] offset_in,
	output logic [width-1:0] pc_addr_out
);

assign pc_addr_out = pc_addr_in + offset_in;

endmodule : br_add