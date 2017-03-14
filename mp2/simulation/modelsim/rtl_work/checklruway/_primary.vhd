library verilog;
use verilog.vl_types.all;
entity checklruway is
    port(
        lru_bit         : in     vl_logic;
        way_sel         : in     vl_logic;
        cache_hit       : in     vl_logic;
        \out\           : out    vl_logic
    );
end checklruway;
