onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /synthesizer_tb/clk_SIG
add wave -noupdate /synthesizer_tb/reset_SIG
add wave -noupdate /synthesizer_tb/write_SIG
add wave -noupdate -radix hexadecimal /synthesizer_tb/frequency
add wave -noupdate -radix hexadecimal /synthesizer_tb/data
add wave -noupdate -radix hexadecimal /synthesizer_tb/Synth/phase_acc1
add wave -noupdate -radix hexadecimal /synthesizer_tb/Synth/phase_reg1
add wave -noupdate -radix hexadecimal /synthesizer_tb/Synth/lut/address_reg1
add wave -noupdate -radix hexadecimal /synthesizer_tb/Synth/lut/sin_out1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 223
configure wave -valuecolwidth 71
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {325357 ps}
