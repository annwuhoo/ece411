import lc3b_types::*;

module pmemconstruct
(
	input lc3b_tag tag0, tag1,
	input lc3b_c_index index,
	input lc3b_c_offset offset,
	input logic lru_bit,
	output lc3b_word outaddress
);

lc3b_tag tagmux_out;

mux2 #(.width(9)) tagmux
(
	.sel(lru_bit),
	.a(tag0),
	.b(tag1),
	.f(tagmux_out)
);

assign outaddress = {tagmux_out, index, offset};

endmodule : pmemconstruct