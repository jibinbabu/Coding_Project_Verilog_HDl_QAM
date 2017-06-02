transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Jibin/Desktop/Semester_2/Digital\ System\ Design/QAM {C:/Users/Jibin/Desktop/Semester_2/Digital System Design/QAM/Signal_Generator.v}
vlog -vlog01compat -work work +incdir+C:/Users/Jibin/Desktop/Semester_2/Digital\ System\ Design/QAM {C:/Users/Jibin/Desktop/Semester_2/Digital System Design/QAM/VGA_Controller.v}
vlog -vlog01compat -work work +incdir+C:/Users/Jibin/Desktop/Semester_2/Digital\ System\ Design/QAM {C:/Users/Jibin/Desktop/Semester_2/Digital System Design/QAM/OScilloscope.v}
vlog -vlog01compat -work work +incdir+C:/Users/Jibin/Desktop/Semester_2/Digital\ System\ Design/QAM {C:/Users/Jibin/Desktop/Semester_2/Digital System Design/QAM/qam_top.v}

