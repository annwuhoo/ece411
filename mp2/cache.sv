import lc3b_types::*;

// contains the cache datapath and cache controller
module cache
(
    input clk,

    /* Signals between cache and cpu */
    output mem_resp,
    output lc3b_word mem_rdata,
    input  mem_read,
    input  mem_write,
    input  lc3b_mem_wmask mem_byte_enable,
    input  lc3b_word mem_address,
    input  lc3b_word mem_wdata,
	 
	 /* Signals between cache and main memory */
	 output lc3b_word pmem_address,
	 input  lc3b_line pmem_rdata,
	 output lc3b_line pmem_wdata,
	 output pmem_read, pmem_write,
	 input  pmem_resp
);

/* Internal Signals */
logic load_data_valid_dirty, load_tag, lru_or_way, dirty_val, datainmux_sel, cache_hit, dirty, valid;
logic [1:0] loadlrumux_sel;

/* Modules */
cache_datapath cache_dp0
(
	 .clk,
	 
	 /* Controller */
	 .load_data_valid_dirty,
	 .load_tag,
	 .loadlrumux_sel,
	 .lru_or_way,
	 .dirty_val,
	 .datainmux_sel,
	 .cache_hit,
	 .dirty,
	 .valid,
	 
	 /* CPU */
    .mem_rdata,
    .mem_byte_enable,
    .mem_address,
    .mem_wdata,
	 
	 /* Main memory */
	 .pmem_write,
	 .pmem_address,
	 .pmem_rdata,
	 .pmem_wdata
);

cache_control cache_ctrl0
(
    .clk,

	 /* Datapath */
	 .cache_hit, 
	 .dirty, 
	 .valid,
	 .load_data_valid_dirty,
	 .load_tag,
	 .loadlrumux_sel,
	 .lru_or_way,
	 .dirty_val,
	 .datainmux_sel,
	 
	 /* CPU */
	 .mem_read,
    .mem_write,
    .mem_resp,
	 
	 /* Main memory */
	 .pmem_read, 
	 .pmem_write,
	 .pmem_resp
);

endmodule : cache

