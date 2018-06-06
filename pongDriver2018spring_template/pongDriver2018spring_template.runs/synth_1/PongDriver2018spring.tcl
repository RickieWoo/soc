# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7z010clg400-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Administrator/Documents/soc/pongDriver2018spring_template/pongDriver2018spring_template.cache/wt [current_project]
set_property parent.project_path C:/Users/Administrator/Documents/soc/pongDriver2018spring_template/pongDriver2018spring_template.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:zybo:part0:1.0 [current_project]
read_verilog -library xil_defaultlib {
  C:/Users/Administrator/Documents/soc/pongDriver2018spring_template/UniversalCounter10bits.v
  C:/Users/Administrator/Documents/soc/pongDriver2018spring_template/ClockedNegativeOneShot.v
  C:/Users/Administrator/Documents/soc/pongDriver2018spring_template/vsyncModule2018spring_template.v
  C:/Users/Administrator/Documents/soc/pongDriver2018spring_template/hsyncModule2018spring.v
  C:/Users/Administrator/Documents/soc/pongDriver2018spring_template/pongDriver2018spring_template.srcs/sources_1/imports/pongDriver2018spring_template/CRTClock2018spring_template.v
  C:/Users/Administrator/Documents/soc/pongDriver2018spring_template/pongDriver2018spring_template.srcs/sources_1/imports/pongDriver2018spring_template/GameZybo.v
  C:/Users/Administrator/Documents/soc/pongDriver2018spring_template/pongDriver2018spring_template.srcs/sources_1/imports/pongDriver2018spring_template/CRTcontroller2018spring.v
  C:/Users/Administrator/Documents/soc/pongDriver2018spring_template/pongDriver2018spring_template.srcs/sources_1/imports/pongDriver2018spring_template/PongDriver2018spring.v
}
read_xdc C:/Users/Administrator/Documents/soc/pongDriver2018spring_template/pongDriver2018spring_template.srcs/constrs_1/imports/pongDriver2018spring_template/PongDriver2018spring.xdc
set_property used_in_implementation false [get_files C:/Users/Administrator/Documents/soc/pongDriver2018spring_template/pongDriver2018spring_template.srcs/constrs_1/imports/pongDriver2018spring_template/PongDriver2018spring.xdc]

synth_design -top PongDriver2018spring -part xc7z010clg400-1
write_checkpoint -noxdef PongDriver2018spring.dcp
catch { report_utilization -file PongDriver2018spring_utilization_synth.rpt -pb PongDriver2018spring_utilization_synth.pb }
