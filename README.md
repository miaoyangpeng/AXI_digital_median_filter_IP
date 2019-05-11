# AXI_digital_median_filter_IP

it is a 3x3 median filter IP core based on Xilinx ZYNQ SOC

a possible usage diagram can be as following, and this design is the "Digital Image Filter" model in the following diagram

![](image/32.PNG)

for establishing a environment for this IP code,first of all, we can use “AXI4-Stream Data FIFO” IP (provided by Vivado) to replace this IP, to check DMA channels. we must make sure DMA channels (read and write) can run properly first, then replace the “AXI4-Stream Data FIFO” IP into this median filter IP.

