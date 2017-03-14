onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp2_tb/clk
add wave -noupdate /mp2_tb/pmem_resp
add wave -noupdate /mp2_tb/pmem_read
add wave -noupdate /mp2_tb/pmem_write
add wave -noupdate /mp2_tb/pmem_address
add wave -noupdate /mp2_tb/pmem_rdata
add wave -noupdate /mp2_tb/pmem_wdata
add wave -noupdate -divider Datapath/Regfile
add wave -noupdate -expand /mp2_tb/dut/cpu0/cpu_dp/regfile0/data
add wave -noupdate -divider {CPU control}
add wave -noupdate /mp2_tb/dut/cpu0/cpu_ctrl/opcode
add wave -noupdate /mp2_tb/dut/cpu0/cpu_ctrl/state
add wave -noupdate -divider {Cache control}
add wave -noupdate /mp2_tb/dut/cache0/cache_ctrl0/state
add wave -noupdate /mp2_tb/dut/cache0/mem_read
add wave -noupdate /mp2_tb/dut/cache0/mem_resp
add wave -noupdate -divider Cache/way0
add wave -noupdate -expand /mp2_tb/dut/cache0/cache_dp0/data0/data
add wave -noupdate -divider Cache/way1
add wave -noupdate -expand /mp2_tb/dut/cache0/cache_dp0/data1/data
add wave -noupdate -divider {LRU Array}
add wave -noupdate -expand /mp2_tb/dut/cache0/cache_dp0/lru0/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {993084 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 220
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {630 ns} {1155 ns}
