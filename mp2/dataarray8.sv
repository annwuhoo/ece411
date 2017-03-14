import lc3b_types::*;

/*
 * A data array of 8 elements and parametrized width of the data elements (default = 8).
 * if load is asserted, then the data at the input index is overwritten with in.
 * Output always matches the data at the input index.
 */
module dataarray8 #(parameter width = 8)
(
	 input  clk,
    input  [width-1:0] in,
	 input  [2:0] index,
	 input  load,
    output [width-1:0] out
);

/* Internal signals */
logic load0, load1, load2, load3, load4, load5, load6, load7;
[width-1:0] data0, data1, data2, data3, data4, data5, data6, data7;

/* Array control logic */
// Determining output: a mux that uses the index to choose the correct output of the eight registers as the dataarray8 output.
mux8 #(.width(width)) outmux
(
	.sel(index),
	.a(data0), 
	.b(data1),
	.c(data2),
	.d(data3), 
	.e(data4), 
	.f(data5), 
	.g(data6), 
	.h(data7),
	.z(out)
);

// Determining input: a decoder that uses the index to choose the right load# to propagate the dataarray8's load.
dataarray8_decoder dadec0
(
	.index,
	.load,
	.load0,
	.load1,
	.load2,
	.load3,
	.load4,
	.load5,
	.load6,
	.load7
);


/* The 8 data registers */
register #(.width(width)) reg0
(
    .clk,
    .load0,
    .in,
    .data0
);

register #(.width(width)) reg1
(
    .clk,
    .load1,
    .in,
    .data1
);

register #(.width(width)) reg2
(
    .clk,
    .load2,
    .in,
    .data2
);

register #(.width(width)) reg3
(
    .clk,
    .load3,
    .in,
    .data3
);

register #(.width(width)) reg4
(
    .clk,
    .load4,
    .in,
    .data4
);

register #(.width(width)) reg5
(
    .clk,
    .load5,
    .in,
    .data5
);

register #(.width(width)) reg6
(
    .clk,
    .load6,
    .in,
    .data6
);

register #(.width(width)) reg7
(
    .clk,
    .load7,
    .in,
    .data7
);

endmodule : dataarray8
