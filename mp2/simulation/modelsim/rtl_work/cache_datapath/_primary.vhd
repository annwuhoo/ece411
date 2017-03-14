library verilog;
use verilog.vl_types.all;
entity cache_datapath is
    port(
        clk             : in     vl_logic;
        load_data_valid_dirty: in     vl_logic;
        load_tag        : in     vl_logic;
        loadlrumux_sel  : in     vl_logic_vector(1 downto 0);
        lru_or_way      : in     vl_logic;
        dirty_val       : in     vl_logic;
        datainmux_sel   : in     vl_logic;
        cache_hit       : out    vl_logic;
        dirty           : out    vl_logic;
        valid           : out    vl_logic;
        mem_rdata       : out    vl_logic_vector(15 downto 0);
        mem_byte_enable : in     vl_logic_vector(1 downto 0);
        mem_address     : in     vl_logic_vector(15 downto 0);
        mem_wdata       : in     vl_logic_vector(15 downto 0);
        pmem_write      : in     vl_logic;
        pmem_address    : out    vl_logic_vector(15 downto 0);
        pmem_rdata      : in     vl_logic_vector(127 downto 0);
        pmem_wdata      : out    vl_logic_vector(127 downto 0)
    );
end cache_datapath;
