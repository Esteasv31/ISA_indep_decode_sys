transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/adder.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/adder_carry.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/alu.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/arm.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/mux2.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/flopr.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/flopenclr.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/regfile.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/extend.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/decoder.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/flopclr.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/flopenr.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/condcheck.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/condlogic.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/flopmem.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/flopwb.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/hazarU.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/dmem.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/imem.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/top.sv}

vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
