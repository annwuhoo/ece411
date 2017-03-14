library verilog;
use verilog.vl_types.all;
entity array8 is
    generic(
        width           : integer := 128
    );
    port(
        clk             : in     vl_logic;
        \in\            : in     vl_logic_vector;
        index           : in     vl_logic_vector(2 downto 0);
        load            : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end array8;
