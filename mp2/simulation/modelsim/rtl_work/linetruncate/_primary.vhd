library verilog;
use verilog.vl_types.all;
entity linetruncate is
    port(
        offset          : in     vl_logic_vector(2 downto 0);
        data            : in     vl_logic_vector(127 downto 0);
        mem_rdata       : out    vl_logic_vector(15 downto 0)
    );
end linetruncate;
