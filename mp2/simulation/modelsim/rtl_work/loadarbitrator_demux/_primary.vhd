library verilog;
use verilog.vl_types.all;
entity loadarbitrator_demux is
    port(
        load0           : in     vl_logic;
        load1           : in     vl_logic;
        load_data_valid_dirty: in     vl_logic;
        load_tag        : in     vl_logic;
        load_data_valid_dirty0: out    vl_logic;
        load_data_valid_dirty1: out    vl_logic;
        load_tag0       : out    vl_logic;
        load_tag1       : out    vl_logic
    );
end loadarbitrator_demux;
