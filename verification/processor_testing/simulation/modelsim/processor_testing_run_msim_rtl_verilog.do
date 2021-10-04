transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/regfile.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/mux2.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/imem.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/hazarU.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/flopwb.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/flopr.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/flopmem.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/flopenr.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/flopenclr.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/flopclr.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/extend.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/dmem.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/decoder.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/condlogic.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/condcheck.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/arm.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/alu.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/adder_carry.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/adder.sv}
vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/top.sv}

