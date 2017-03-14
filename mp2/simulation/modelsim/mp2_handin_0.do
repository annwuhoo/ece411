onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label data0 -expand /mp2_tb/dut/cache0/cache_dp0/data0/data
add wave -noupdate -label tag0 -expand /mp2_tb/dut/cache0/cache_dp0/tag0/data
add wave -noupdate /mp2_tb/dut/cpu0/cpu_dp/pc_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {25922395 ps} 0}
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
WaveRestoreZoom {26391746 ps} {26505698 ps}
