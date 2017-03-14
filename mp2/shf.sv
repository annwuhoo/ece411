import lc3b_types::*;

// This is a module supporting the SHF instruction
module shf
(
    input lc3b_word in,
	 input lc3b_imm4 imm4,
	 input lc3b_bit dbit, abit,
    output lc3b_word out
);

// internal logic
lc3b_word rshfl_out, rshfa_out, smallmux_out, lshf_out;

// modules

rshfl rshfl0
(
	.in,
	.shfval(imm4),
	.out(rshfl_out)
);

rshfa rshfa0
(
	.in,
	.shfval(imm4),
	.out(rshfa_out)
);

mux2 #(.width(16)) smallmux
(
	.sel(abit),
	.a(rshfl_out),
	.b(rshfa_out),
	.f(smallmux_out)
);

lshf lshf0
(
	.in,
	.shfval(imm4),
	.out(lshf_out)
);

mux2 #(.width(16)) bigmux
(
	.sel(dbit),
	.a(lshf_out),
	.b(smallmux_out),
	.f(out)
);

endmodule : shf
