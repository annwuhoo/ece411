library verilog;
use verilog.vl_types.all;
entity cachehit_decoder is
    port(
        in0             : in     vl_logic;
        in1             : in     vl_logic;
        cache_hit       : out    vl_logic;
        way_sel         : out    vl_logic
    );
end cachehit_decoder;
