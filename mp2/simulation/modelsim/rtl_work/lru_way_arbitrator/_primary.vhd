library verilog;
use verilog.vl_types.all;
entity lru_way_arbitrator is
    port(
        lru_bit         : in     vl_logic;
        way_sel         : in     vl_logic;
        lru_or_way      : in     vl_logic;
        load0           : out    vl_logic;
        load1           : out    vl_logic
    );
end lru_way_arbitrator;
