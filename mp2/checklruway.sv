import lc3b_types::*;

/* Determines in a cache_hit state whether or not to output a load_lru */
module checklruway
(
	input logic lru_bit,
	input logic way_sel,
	input logic cache_hit,
	output logic out
);

always_comb begin
	out = 0;
	
	if (cache_hit & (lru_bit == way_sel)) begin
		out = 1;
	end
end

endmodule : checklruway