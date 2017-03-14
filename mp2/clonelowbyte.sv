import lc3b_types::*;

module clonelowbyte
(
	input lc3b_word in,
	output lc3b_word out
);

assign out = {in[7:0], in[7:0]};

endmodule : clonelowbyte