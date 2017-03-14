library verilog;
use verilog.vl_types.all;
entity br_add is
    generic(
        width           : integer := 16
    );
    port(
        pc_addr_in      : in     vl_logic_vector;
        offset_in       : in     vl_logic_vector;
        pc_addr_out     : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end br_add;
