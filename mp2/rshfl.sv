import lc3b_types::*;

module rshfl
(
	input lc3b_word in,
	input lc3b_imm4 shfval,
	output lc3b_word out
);

assign out = in >> shfval;

endmodule : rshfl