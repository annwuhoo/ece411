import lc3b_types::*;

/*
 * Arbitrates the load signals to the cache memory arrays based on the LRU bit
 */
module lruarb
(
    input  lru_bit,
	 input  load,
	 output out0, out1
);

always_comb begin
	out0 = 0;
	out1 = 0;
	
	if (load) begin
		if (~lru_bit) out0 = 1;
		else out1 = 1;
	end

end

endmodule : lruarb
