onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp2_tb/clk
add wave -noupdate /mp2_tb/dut/dp/pc_out
add wave -noupdate /mp2_tb/mem_address
add wave -noupdate /mp2_tb/mem_read
add wave -noupdate /mp2_tb/mem_rdata
add wave -noupdate /mp2_tb/mem_write
add wave -noupdate /mp2_tb/mem_byte_enable
add wave -noupdate /mp2_tb/mem_wdata
add wave -noupdate -expand /mp2_tb/dut/dp/regfile0/data
add wave -noupdate -divider Datapath/Regfile
add wave -noupdate -color {Medium Orchid} /mp2_tb/dut/dp/regfile0/load
add wave -noupdate -color {Medium Orchid} /mp2_tb/dut/dp/regfile0/in
add wave -noupdate -color {Medium Orchid} /mp2_tb/dut/dp/regfile0/src_a
add wave -noupdate -color {Medium Orchid} /mp2_tb/dut/dp/regfile0/src_b
add wave -noupdate -color {Medium Orchid} /mp2_tb/dut/dp/regfile0/dest
add wave -noupdate -color {Medium Orchid} /mp2_tb/dut/dp/regfile0/reg_a
add wave -noupdate -color {Medium Orchid} /mp2_tb/dut/dp/regfile0/reg_b
add wave -noupdate -divider Controller
add wave -noupdate /mp2_tb/dut/opcode
add wave -noupdate /mp2_tb/dut/ctrl/state
add wave -noupdate /mp2_tb/dut/ctrl/bit5
add wave -noupdate -divider PC
add wave -noupdate /mp2_tb/dut/dp/pc/load
add wave -noupdate /mp2_tb/dut/dp/pc/in
add wave -noupdate /mp2_tb/dut/dp/pc/out
add wave -noupdate -divider SHF
add wave -noupdate -color Violet /mp2_tb/dut/dp/shf0/rshfl0/in
add wave -noupdate -color Violet /mp2_tb/dut/dp/shf0/rshfl0/shfval
add wave -noupdate -color Violet /mp2_tb/dut/dp/shf0/rshfl0/out
add wave -noupdate -color {Cornflower Blue} /mp2_tb/dut/dp/shf0/rshfa0/in
add wave -noupdate -color {Cornflower Blue} /mp2_tb/dut/dp/shf0/rshfa0/shfval
add wave -noupdate -color {Cornflower Blue} /mp2_tb/dut/dp/shf0/rshfa0/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {598730 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {277500 ps} {1327500 ps}
