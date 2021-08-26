transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -sv -work work +incdir+. {ARM_v8.svo}

vlog -sv -work work +incdir+F:/TFG/ISA_indep_decode_sys/test_processor {F:/TFG/ISA_indep_decode_sys/test_processor/testbench.sv}

vsim -t 1ps -L altera_ver -L altera_lnsim_ver -L cyclonev_ver -L lpm_ver -L sgate_ver -L cyclonev_hssi_ver -L altera_mf_ver -L cyclonev_pcie_hip_ver -L gate_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
