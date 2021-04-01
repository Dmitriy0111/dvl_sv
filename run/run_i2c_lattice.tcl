#
# File          : run_i2c_lattice.tcl
# Autor         : Vlasov D.V.
# Data          : 12.03.2021
# Language      : tcl
# Description   : This is script for running simulation process
# Copyright(c)  : 2019 - 2021 Vlasov D.V.
#

# compile design rtl
vlog    ../examples/i2c_lattice/FPGA-RD-02201-1-0-Generic-Soft-I2C-Master-Controller/Generic_Soft_I2C_Master/Source/*.*v

# compile dvv_vm classes pkg
vlog -sv ../dvv_vm/*.*v
# compile verification components
vlog -sv ../interfaces/*.*v
vlog -sv ../examples/i2c_lattice/tb/if/*.*v
vlog -sv ../examples/i2c_lattice/tb/i2c_lattice/i2c_test_pkg.sv 
# compile testbench
vlog -sv ../examples/i2c_lattice/tb/i2c_lattice/i2c_lattice_ctb.sv

vsim -novopt work.i2c_lattice_ctb +DVV_TEST=i2c_test

add wave -divider  "testbench signals"
add wave -position insertpoint sim:/i2c_lattice_ctb/*
add wave -divider  "lattice interface signals"
add wave -position insertpoint sim:/i2c_lattice_ctb/lat_if_0/*
add wave -divider  "i2c interface signals"
add wave -position insertpoint sim:/i2c_lattice_ctb/i2c_if_0/*
add wave -divider  "dut signals"
add wave -position insertpoint sim:/i2c_lattice_ctb/dut/*

run -all

wave zoom full

quit
