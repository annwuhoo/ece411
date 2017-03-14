import lc3b_types::*;

/* 
 * Truncates the cache line to the correct word based on the offset
 * Granularity = 16 bit
 */
module linetruncate
(
	input [2:0] offset,
	input lc3b_line data,
	output lc3b_word mem_rdata
);

// Mux each 16-bit offset
mux8 #(.width(16)) mux0
(
	.sel(offset),
	.a(data[15:0]),
	.b(data[31:16]), 
	.c(data[47:32]), 
	.d(data[63:48]), 
	.e(data[79:64]), 
	.f(data[95:80]),
	.g(data[111:96]),
	.h(data[127:112]),
	.z(mem_rdata)
);

endmodule : linetruncate