library verilog;
use verilog.vl_types.all;
library work;
entity cpu_datapath is
    port(
        clk             : in     vl_logic;
        pcmux_sel       : in     vl_logic_vector(1 downto 0);
        load_pc         : in     vl_logic;
        pcaddermux_sel  : in     vl_logic;
        load_ir         : in     vl_logic;
        storemux_sel    : in     vl_logic;
        destmux_sel     : in     vl_logic;
        load_regfile    : in     vl_logic;
        regfilemux_sel  : in     vl_logic_vector(2 downto 0);
        alumux_sel      : in     vl_logic_vector(1 downto 0);
        aluop           : in     work.lc3b_types.lc3b_aluop;
        load_cc         : in     vl_logic;
        load_mar        : in     vl_logic;
        load_mdr        : in     vl_logic;
        marmux_sel      : in     vl_logic_vector(1 downto 0);
        mdrmux_sel      : in     vl_logic_vector(1 downto 0);
        mem_rdata       : in     vl_logic_vector(15 downto 0);
        opcode          : out    work.lc3b_types.lc3b_opcode;
        branch_enable   : out    vl_logic;
        bit5            : out    vl_logic;
        bit11           : out    vl_logic;
        mem_wdata       : out    vl_logic_vector(15 downto 0);
        mem_address     : out    vl_logic_vector(15 downto 0)
    );
end cpu_datapath;
