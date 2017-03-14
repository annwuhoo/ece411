library verilog;
use verilog.vl_types.all;
entity cache_control is
    port(
        clk             : in     vl_logic;
        cache_hit       : in     vl_logic;
        dirty           : in     vl_logic;
        valid           : in     vl_logic;
        lru_or_way      : out    vl_logic;
        load_data_valid_dirty: out    vl_logic;
        load_tag        : out    vl_logic;
        loadlrumux_sel  : out    vl_logic_vector(1 downto 0);
        dirty_val       : out    vl_logic;
        datainmux_sel   : out    vl_logic;
        mem_read        : in     vl_logic;
        mem_write       : in     vl_logic;
        mem_resp        : out    vl_logic;
        pmem_read       : out    vl_logic;
        pmem_write      : out    vl_logic;
        pmem_resp       : in     vl_logic
    );
end cache_control;
