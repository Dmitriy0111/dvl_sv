#
# File          : run_i2c_test.tcl
# Autor         : Vlasov D.V.
# Data          : 15.12.2020
# Language      : tcl
# Description   : This is script for running simulation process
# Copyright(c)  : 2019 - 2021 Vlasov D.V.
#

# compile design rtl
vlog     ../examples/verilog-i2c/verilog-i2c/rtl/*.*v

# compile dvl_sv classes
vlog -sv ../dvl_sv/*.*v
# compile verification components
vlog -sv ../interfaces/*.*v
vlog -sv ../examples/verilog-i2c/tb/if/*.*v
vlog -sv ../examples/verilog-i2c/tb/verilog-i2c/i2c_test_pkg.sv 
# compile testbench
vlog -sv ../examples/verilog-i2c/tb/verilog-i2c/i2c_ctb.*v ../examples/verilog-i2c/tb/verilog-i2c/i2c_pin.*v

vsim -novopt work.i2c_ctb +DVL_TEST_NAME=i2c_test

add wave -divider  "testbench signals"
add wave -position insertpoint sim:/i2c_ctb/*
add wave -divider  "dut signals"
add wave -position insertpoint sim:/i2c_ctb/dut/*
add wave -divider  "wishbone signals"
add wave -position insertpoint sim:/i2c_ctb/wb_if_0/*
add wave -divider  "i2c signals"
add wave -position insertpoint sim:/i2c_ctb/i2c_if_0/*

run -all

#coverage report -detail -cvg -directive -config -comments -file fcover_report.txt -noa /i2c_test_pkg/wb_cov/cov_presc

wave zoom full

#quit
