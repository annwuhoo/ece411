import lc3b_types::*;

/*
 * Arbitrates the load signals to the cache memory arrays based on state:
 * s_hitmiss needs to arbitrate according to way_sel, and s_writeline needs to arbitrate according to lru_bit.
 * We then choose between these using lru_or_way.
 */
module lru_way_arbitrator
(
    input  lru_bit,
	 input  way_sel,
	 input  lru_or_way,
	 output load0, load1
);

logic lru_out0, lru_out1, way_out0, way_out1;

// Arbitrate way signals: way_sel indicates the way that we want to write into (in s_hitmiss, for a cache write hit).
// So if way_sel = 1, then we want to write into way 1 (i.e. way_out1 = 1).
always_comb begin
	way_out0 = 0;
	way_out1 = 0;
	
	if (way_sel) way_out1 = 1;
	else way_out0 = 1;
end

// Arbitrate LRU signals: LRU also indicates the way we want to wite into (in a cache miss), since that is the least recently used way.
// So if lru_bit = 1, then we want to write into way 1 (i.e. lru_out1 = 1). Thus we have identical behavior to way_sel.
always_comb begin
	lru_out0 = 0;
	lru_out1 = 0;
	
	if (lru_bit) lru_out1 = 1;
	else lru_out0 = 1;
end

// However, lru_bit and way_sel may not indicate the same way! Thus we need to differentiate between the two behaviors.
// We want to use way_sel in s_hitmiss, and lru_bit in the cache miss states; thus we mux the two choices to produce the correct out0 and out1.
mux2 #(.width(1)) larbmux0
(
	.sel(lru_or_way),
	.a(lru_out0),
	.b(way_out0),
	.f(load0)
);

mux2 #(.width(1)) larbmux1
(
	.sel(lru_or_way),
	.a(lru_out1),
	.b(way_out1),
	.f(load1)
);

endmodule : lru_way_arbitrator