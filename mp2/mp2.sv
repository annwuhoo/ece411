import lc3b_types::*;

// contains the CPU and the cache
module mp2
(
    input clk,

    /* Physical memory signals */
	 output lc3b_word pmem_address,
	 input  lc3b_line pmem_rdata,
	 output lc3b_line pmem_wdata,
	 output pmem_read, pmem_write,
	 input  pmem_resp
);

/* Internal signals */
//idk yet
logic mem_resp, mem_read, mem_write;
lc3b_mem_wmask mem_byte_enable;
lc3b_word mem_rdata, mem_wdata, mem_address;


cpu cpu0
(
    .clk,

    /* Signals between cpu and cache */
    .mem_resp,
    .mem_rdata,
    .mem_read,
    .mem_write,
    .mem_byte_enable,
    .mem_address,
    .mem_wdata
);

cache cache0
(
    .clk,

    /* Signals between cache and cpu */
    .mem_resp,
    .mem_rdata,
    .mem_read,
    .mem_write,
    .mem_byte_enable,
    .mem_address,
    .mem_wdata,
	 
	 /* Signals between cache and main memory */
	 .pmem_address,
	 .pmem_rdata,
	 .pmem_wdata,
	 .pmem_read,
	 .pmem_write,
	 .pmem_resp
);

endmodule : mp2
