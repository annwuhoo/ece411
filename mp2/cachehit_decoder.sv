import lc3b_types::*;

/* 
 * Determines if there is a cache_hit, and simultaneously selects the correct way.
 * (Note: there should be no circumstance where in0 and in1 are both high!)
 */
module cachehit_decoder
(
	input in0, in1,
	output cache_hit, way_sel
);

assign cache_hit = in0 | in1;
assign way_sel = in1; // Since way_sel = 0 if in0 = 1, and way_sel = 1 if in1 = 1.

endmodule : cachehit_decoder