library verilog;
use verilog.vl_types.all;
entity lineoverwrite is
    port(
        offset          : in     vl_logic_vector(2 downto 0);
        datain          : in     vl_logic_vector(127 downto 0);
        mem_wdata       : in     vl_logic_vector(15 downto 0);
        mem_byte_enable : in     vl_logic_vector(1 downto 0);
        dataout         : out    vl_logic_vector(127 downto 0)
    );
end lineoverwrite;
