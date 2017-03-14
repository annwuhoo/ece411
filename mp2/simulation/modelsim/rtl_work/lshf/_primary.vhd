library verilog;
use verilog.vl_types.all;
entity lshf is
    port(
        \in\            : in     vl_logic_vector(15 downto 0);
        shfval          : in     vl_logic_vector(3 downto 0);
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end lshf;
