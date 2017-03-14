transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/lc3b_types.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/plus2.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/register.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/mux2.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/br_add.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/mux4.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/mux8.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/cache_control.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/comparator_v.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/cachehit_decoder.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/checklruway.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/loadarbitrator_demux.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/lru_way_arbitrator.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/adj.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/alu.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/gencc.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/ir.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/regfile.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/cccomp.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/sext.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/zext.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/lshf.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/rshfl.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/rshfa.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/clonelowbyte.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/cpu_control.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/linetruncate.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/lineoverwrite.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/array8.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/pmemconstruct.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/shf.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/cache_datapath.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/cpu_datapath.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/cache.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/cpu.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/mp2.sv}

vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/mp2_tb.sv}
vlog -sv -work work +incdir+/home/ywu77/ece411/mp2 {/home/ywu77/ece411/mp2/physical_memory.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiii_ver -L rtl_work -L work -voptargs="+acc"  mp2_tb

add wave *
view structure
view signals
run 200 ns