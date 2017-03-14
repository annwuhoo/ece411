library verilog;
use verilog.vl_types.all;
entity pmemconstruct is
    port(
        tag0            : in     vl_logic_vector(8 downto 0);
        tag1            : in     vl_logic_vector(8 downto 0);
        index           : in     vl_logic_vector(2 downto 0);
        offset          : in     vl_logic_vector(3 downto 0);
        lru_bit         : in     vl_logic;
        outaddress      : out    vl_logic_vector(15 downto 0)
    );
end pmemconstruct;
