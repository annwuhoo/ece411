library verilog;
use verilog.vl_types.all;
entity comparator_v is
    generic(
        width           : integer := 9
    );
    port(
        in0             : in     vl_logic_vector;
        in1             : in     vl_logic_vector;
        valid           : in     vl_logic;
        \out\           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end comparator_v;
