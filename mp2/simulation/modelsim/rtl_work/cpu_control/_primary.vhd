library verilog;
use verilog.vl_types.all;
library work;
entity cpu_control is
    port(
        clk             : in     vl_logic;
        opcode          : in     work.lc3b_types.lc3b_opcode;
        branch_enable   : in     vl_logic;
        bit5            : in     vl_logic;
        bit11           : in     vl_logic;
        pcmux_sel       : out    vl_logic_vector(1 downto 0);
        pcaddermux_sel  : out    vl_logic;
        load_pc         : out    vl_logic;
        load_ir         : out    vl_logic;
        storemux_sel    : out    vl_logic;
        destmux_sel     : out    vl_logic;
        load_regfile    : out    vl_logic;
        regfilemux_sel  : out    vl_logic_vector(2 downto 0);
        alumux_sel      : out    vl_logic_vector(1 downto 0);
        aluop           : out    work.lc3b_types.lc3b_aluop;
        load_cc         : out    vl_logic;
        load_mar        : out    vl_logic;
        load_mdr        : out    vl_logic;
        marmux_sel      : out    vl_logic_vector(1 downto 0);
        mdrmux_sel      : out    vl_logic_vector(1 downto 0);
        mem_resp        : in     vl_logic;
        mem_addr0       : in     vl_logic;
        mem_read        : out    vl_logic;
        mem_write       : out    vl_logic;
        mem_byte_enable : out    vl_logic_vector(1 downto 0)
    );
end cpu_control;
