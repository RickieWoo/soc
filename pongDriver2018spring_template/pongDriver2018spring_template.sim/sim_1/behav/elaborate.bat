@echo off
set xv_path=E:\\APP\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xelab  -wto 2c2eccde2e7c4544be63a10ebadaacd0 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot vsyncModule2018spring_tb_behav xil_defaultlib.vsyncModule2018spring_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
