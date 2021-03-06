import lc3b_types::*;

/* 
 * If the two inputs are the same and valid is high, then out = 1. Else, out = 0.
 */
module comparator_v #(parameter width = 9)
(
	input [width-1:0] in0, in1,
	input valid,
	output out
);

assign out = (valid & (in0 == in1));

endmodule : comparator_v