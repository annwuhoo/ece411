onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp2_tb/clk
add wave -noupdate /mp2_tb/dut/cpu0/cpu_dp/pc_out
add wave -noupdate /mp2_tb/dut/cpu0/mem_address
add wave -noupdate /mp2_tb/dut/cpu0/mem_read
add wave -noupdate /mp2_tb/dut/cpu0/mem_rdata
add wave -noupdate /mp2_tb/dut/cpu0/mem_write
add wave -noupdate /mp2_tb/dut/cpu0/mem_byte_enable
add wave -noupdate /mp2_tb/dut/cpu0/mem_wdata
add wave -noupdate -expand /mp2_tb/dut/cpu0/cpu_dp/regfile0/data
add wave -noupdate /mp2_tb/dut/cpu0/cpu_ctrl/state
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
WaveRestoreZoom {630 ns} {1541607 ps}
