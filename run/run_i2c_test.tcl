#
# File          :   run_i2c_test.tcl
# Autor         :   Vlasov D.V.
# Data          :   2020.12.15
# Language      :   tcl
# Description   :   This is script for running simulation process
# Copyright(c)  :   2019 - 2020 Vlasov D.V.
#

# compile design rtl
vlog     ../examples/verilog-i2c/verilog-i2c_rtl/rtl/*.*v

# compile dvv_vm classes
vlog -sv ../dvv_vm/*.*v
# compile verification components
vlog -sv ../examples/verilog-i2c/tb/if/*.*v
vlog -sv ../examples/verilog-i2c/tb/verilog-i2c/i2c_test_pkg.sv 
# compile testbench
vlog -sv ../examples/verilog-i2c/tb/verilog-i2c/i2c_ctb.*v

vsim -novopt work.i2c_ctb +DVV_TEST=i2c_test

add wave -divider  "testbench signals"
add wave -position insertpoint sim:/i2c_ctb/*
add wave -divider  "dut signals"
add wave -position insertpoint sim:/i2c_ctb/dut/*
add wave -divider  "wishbone signals"
add wave -position insertpoint sim:/i2c_ctb/wb_if_0/*

run -all

coverage report -detail -cvg -directive -config -comments -file fcover_report.txt -noa /i2c_test_pkg/wb_cov/cov_presc

wave zoom full

#quit
