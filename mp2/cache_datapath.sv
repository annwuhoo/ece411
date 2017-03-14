import lc3b_types::*;

module cache_datapath
(
    input clk,
	 
	 /* Controller */
	 input load_data_valid_dirty, load_tag,
	 input [1:0] loadlrumux_sel,
	 input lru_or_way,
	 input dirty_val,
	 input datainmux_sel,
	 output cache_hit, dirty, valid,
	 
	 /* CPU */
    output lc3b_word mem_rdata,
    input  lc3b_mem_wmask mem_byte_enable,
    input  lc3b_word mem_address,
    input  lc3b_word mem_wdata,
	 
	 /* Main memory */
	 input  pmem_write,
	 output lc3b_word pmem_address,
	 input  lc3b_line pmem_rdata,
	 output lc3b_line pmem_wdata
);

/* Internal signals */
// Array signals
logic load_data_valid_dirty0, load_data_valid_dirty1, load_tag0, load_tag1;
logic valid0_out, valid1_out, dirty0_out, dirty1_out, lru_out;
lc3b_tag tag0_out, tag1_out;
lc3b_line data0_out, data1_out;

// Logic signals
lc3b_line datainmux_out, dataoutmux_out, lineoverwrite_out;
logic comp0_out, comp1_out, way_sel;
logic checklruway_out, loadlrumux_out;
lc3b_word pmemconstruct_out;
logic load0, load1;


/* pmem_address construction: arbitrate between pmem_read and pmem_write */
pmemconstruct pmc0
(
	.tag0(tag0_out), 
	.tag1(tag1_out),
	.index(mem_address[6:4]),
	.offset(mem_address[3:0]),
	.lru_bit(lru_out),
	.outaddress(pmemconstruct_out)
);

mux2 #(.width(16)) pmemaddrmux
(
	.sel(pmem_write), // choose b if pmem_write = 1 (i.e. we want to write back)
	.a({mem_address[15:4], 4'h0}),
	.b({pmemconstruct_out[15:4], 4'h0}),
	.f(pmem_address)
);

//assign pmem_address = mem_address; // no virtual memory at the moment

/* Data arrays */
// Valid bit arrays
array8 #(.width(1)) valid0
(
	 .clk,
    .in(1),
	 .index(mem_address[6:4]),
	 .load(load_data_valid_dirty0),
    .out(valid0_out)
);

array8 #(.width(1)) valid1
(
	 .clk,
    .in(1),
	 .index(mem_address[6:4]),
	 .load(load_data_valid_dirty1),
    .out(valid1_out)
);

// Dirty bit arrays
array8 #(.width(1)) dirty0
(
	 .clk,
    .in(dirty_val),
	 .index(mem_address[6:4]),
	 .load(load_data_valid_dirty0),
    .out(dirty0_out)
);

array8 #(.width(1)) dirty1
(
	 .clk,
    .in(dirty_val),
	 .index(mem_address[6:4]),
	 .load(load_data_valid_dirty1),
    .out(dirty1_out)
);

// Tag arrays
array8 #(.width(9)) tag0
(
	 .clk,
    .in(mem_address[15:7]),
	 .index(mem_address[6:4]),
	 .load(load_tag0),
    .out(tag0_out)
);

array8 #(.width(9)) tag1
(
	 .clk,
    .in(mem_address[15:7]),
	 .index(mem_address[6:4]),
	 .load(load_tag1),
    .out(tag1_out)
);

// Data arrays
array8 #(.width(128)) data0
(
	 .clk,
    .in(datainmux_out),
	 .index(mem_address[6:4]),
	 .load(load_data_valid_dirty0),
    .out(data0_out)
);

array8 #(.width(128)) data1
(
	 .clk,
    .in(datainmux_out),
	 .index(mem_address[6:4]),
	 .load(load_data_valid_dirty1),
    .out(data1_out)
);

// LRU bit array
array8 #(.width(1)) lru0
(
	 .clk,
    .in(~lru_out),
	 .index(mem_address[6:4]),
	 .load(loadlrumux_out),
    .out(lru_out)
);


/* All other logic */
// LRU load mux
mux4 #(.width(1)) loadlrumux
(
	.sel(loadlrumux_sel),
	.a(1'b0),
	.b(1'b1), 
	.c(checklruway_out),
	.d(),
	.f(loadlrumux_out)
);

checklruway clw0
(
	.lru_bit(lru_out),
	.way_sel,
	.cache_hit,
	.out(checklruway_out)
);

// DataInMux (input to data arrays)
mux2 #(.width(128)) datainmux
(
	.sel(datainmux_sel),
	.a(pmem_rdata), 
	.b(lineoverwrite_out),
	.f(datainmux_out)
);

// larbs for data (and valid), tag, and dirty arrays
// this is repetitive and should be improved.. i.e. demux the output of a single larb
/*loadarbitrator larb_data
(
    .lru_bit(lru_out),
	 .way_sel,
	 .lru_or_way,
	 .load(load_data),
	 .out0(load_way0), 
	 .out1(load_way1)
);

loadarbitrator larb_tag
(
    .lru_bit(lru_out),
	 .way_sel,
	 .lru_or_way,
	 .load(load_tag),
	 .out0(load_tag0), 
	 .out1(load_tag1)
);

loadarbitrator larb_dirty
(
    .lru_bit(lru_out),
	 .way_sel,
	 .lru_or_way,
	 .load(load_dirty),
	 .out0(load_dirty0), 
	 .out1(load_dirty1)
);*/

lru_way_arbitrator lwarb0
(
    .lru_bit(lru_out),
	 .way_sel,
	 .lru_or_way,
	 .load0, 
	 .load1
);

loadarbitrator_demux larb_demux
(
	.load0,
	.load1,
	.load_data_valid_dirty,
	.load_tag,
	// the correct arrays to output loads to is arbitrated by larb and control signals
	.load_data_valid_dirty0,
	.load_data_valid_dirty1,
	.load_tag0,
	.load_tag1
);


// comp0, comp1 to compare cache tags with mem_address
comparator_v #(.width(9)) comp0
(
	.in0(mem_address[15:7]), 
	.in1(tag0_out),
	.valid(valid0_out),
	.out(comp0_out)
);

comparator_v #(.width(9)) comp1
(
	.in0(mem_address[15:7]), 
	.in1(tag1_out),
	.valid(valid1_out),
	.out(comp1_out)
);

// cachehit_decoder
cachehit_decoder ch_dec
(
	.in0(comp0_out), 
	.in1(comp1_out),
	.cache_hit,
	.way_sel
);

// DataOutMux: output from data arrays
mux2 #(.width(128)) dataoutmux
(
	.sel(way_sel),
	.a(data0_out), 
	.b(data1_out),
	.f(dataoutmux_out)
);

// trunc
linetruncate lt0
(
	.offset(mem_address[3:1]), // ignore the last offset bit (due to 16-bit granularity)
	.data(dataoutmux_out),
	.mem_rdata
);

// memwrite
lineoverwrite lw0
(
	.offset(mem_address[3:1]), // ignore the last offset bit (due to 16-bit granularity)
	.datain(dataoutmux_out),
	.mem_wdata,
	.mem_byte_enable,
	.dataout(lineoverwrite_out)
);

// Output muxes: dirty, valid, to create control signals; pmem_wdata to main memory
mux2 #(.width(1)) dirtymux
(
	.sel(lru_out),
	.a(dirty0_out), 
	.b(dirty1_out),
	.f(dirty)
);

mux2 #(.width(1)) validmux
(
	.sel(lru_out),
	.a(valid0_out), 
	.b(valid1_out),
	.f(valid)
);

mux2 #(.width(128)) pmem_wmux
(
	.sel(lru_out),
	.a(data0_out), 
	.b(data1_out),
	.f(pmem_wdata)
);

endmodule : cache_datapath