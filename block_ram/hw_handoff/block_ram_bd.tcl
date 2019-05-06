
################################################################
# This is a generated script based on design: block_ram
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2018.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source block_ram_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z020clg484-1
   set_property BOARD_PART xilinx.com:zc702:part0:1.4 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name block_ram

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set almost_empty_0 [ create_bd_port -dir O almost_empty_0 ]
  set almost_empty_1 [ create_bd_port -dir O almost_empty_1 ]
  set almost_empty_2 [ create_bd_port -dir O almost_empty_2 ]
  set almost_empty_3 [ create_bd_port -dir O almost_empty_3 ]
  set clk [ create_bd_port -dir I -type clk clk ]
  set din_0 [ create_bd_port -dir I -from 7 -to 0 din_0 ]
  set din_1 [ create_bd_port -dir I -from 7 -to 0 din_1 ]
  set din_2 [ create_bd_port -dir I -from 7 -to 0 din_2 ]
  set din_3 [ create_bd_port -dir I -from 7 -to 0 din_3 ]
  set dout_0 [ create_bd_port -dir O -from 7 -to 0 dout_0 ]
  set dout_1 [ create_bd_port -dir O -from 7 -to 0 dout_1 ]
  set dout_2 [ create_bd_port -dir O -from 7 -to 0 dout_2 ]
  set dout_3 [ create_bd_port -dir O -from 7 -to 0 dout_3 ]
  set empty_0 [ create_bd_port -dir O empty_0 ]
  set empty_1 [ create_bd_port -dir O empty_1 ]
  set empty_2 [ create_bd_port -dir O empty_2 ]
  set empty_3 [ create_bd_port -dir O empty_3 ]
  set full_0 [ create_bd_port -dir O full_0 ]
  set full_1 [ create_bd_port -dir O full_1 ]
  set full_2 [ create_bd_port -dir O full_2 ]
  set full_3 [ create_bd_port -dir O full_3 ]
  set rd_en_0 [ create_bd_port -dir I rd_en_0 ]
  set rd_en_1 [ create_bd_port -dir I rd_en_1 ]
  set rd_en_2 [ create_bd_port -dir I rd_en_2 ]
  set rd_en_3 [ create_bd_port -dir I rd_en_3 ]
  set srst [ create_bd_port -dir I -type rst srst ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $srst
  set wr_en_0 [ create_bd_port -dir I wr_en_0 ]
  set wr_en_1 [ create_bd_port -dir I wr_en_1 ]
  set wr_en_2 [ create_bd_port -dir I wr_en_2 ]
  set wr_en_3 [ create_bd_port -dir I wr_en_3 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Almost_Empty_Flag {true} \
   CONFIG.Input_Data_Width {8} \
   CONFIG.Output_Data_Width {8} \
   CONFIG.Reset_Pin {true} \
   CONFIG.Reset_Type {Synchronous_Reset} \
   CONFIG.Use_Dout_Reset {true} \
   CONFIG.Use_Embedded_Registers {false} \
 ] $fifo_generator_0

  # Create instance: fifo_generator_1, and set properties
  set fifo_generator_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_1 ]
  set_property -dict [ list \
   CONFIG.Almost_Empty_Flag {true} \
   CONFIG.Input_Data_Width {8} \
   CONFIG.Output_Data_Width {8} \
   CONFIG.Reset_Pin {true} \
   CONFIG.Reset_Type {Synchronous_Reset} \
   CONFIG.Use_Dout_Reset {true} \
   CONFIG.Use_Embedded_Registers {false} \
 ] $fifo_generator_1

  # Create instance: fifo_generator_2, and set properties
  set fifo_generator_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_2 ]
  set_property -dict [ list \
   CONFIG.Almost_Empty_Flag {true} \
   CONFIG.Input_Data_Width {8} \
   CONFIG.Output_Data_Width {8} \
   CONFIG.Reset_Pin {true} \
   CONFIG.Reset_Type {Synchronous_Reset} \
   CONFIG.Use_Dout_Reset {true} \
   CONFIG.Use_Embedded_Registers {false} \
 ] $fifo_generator_2

  # Create instance: fifo_generator_3, and set properties
  set fifo_generator_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_3 ]
  set_property -dict [ list \
   CONFIG.Almost_Empty_Flag {true} \
   CONFIG.Input_Data_Width {8} \
   CONFIG.Output_Data_Width {8} \
   CONFIG.Reset_Pin {true} \
   CONFIG.Reset_Type {Synchronous_Reset} \
   CONFIG.Use_Dout_Reset {true} \
   CONFIG.Use_Embedded_Registers {false} \
 ] $fifo_generator_3

  # Create port connections
  connect_bd_net -net Net [get_bd_ports clk] [get_bd_pins fifo_generator_0/clk] [get_bd_pins fifo_generator_1/clk] [get_bd_pins fifo_generator_2/clk] [get_bd_pins fifo_generator_3/clk]
  connect_bd_net -net din_0_1 [get_bd_ports din_0] [get_bd_pins fifo_generator_0/din]
  connect_bd_net -net din_1_1 [get_bd_ports din_1] [get_bd_pins fifo_generator_1/din]
  connect_bd_net -net din_2_1 [get_bd_ports din_2] [get_bd_pins fifo_generator_2/din]
  connect_bd_net -net din_3_1 [get_bd_ports din_3] [get_bd_pins fifo_generator_3/din]
  connect_bd_net -net fifo_generator_0_almost_empty [get_bd_ports almost_empty_0] [get_bd_pins fifo_generator_0/almost_empty]
  connect_bd_net -net fifo_generator_0_dout [get_bd_ports dout_0] [get_bd_pins fifo_generator_0/dout]
  connect_bd_net -net fifo_generator_0_empty [get_bd_ports empty_0] [get_bd_pins fifo_generator_0/empty]
  connect_bd_net -net fifo_generator_0_full [get_bd_ports full_0] [get_bd_pins fifo_generator_0/full]
  connect_bd_net -net fifo_generator_1_almost_empty [get_bd_ports almost_empty_1] [get_bd_pins fifo_generator_1/almost_empty]
  connect_bd_net -net fifo_generator_1_dout [get_bd_ports dout_1] [get_bd_pins fifo_generator_1/dout]
  connect_bd_net -net fifo_generator_1_empty [get_bd_ports empty_1] [get_bd_pins fifo_generator_1/empty]
  connect_bd_net -net fifo_generator_1_full [get_bd_ports full_1] [get_bd_pins fifo_generator_1/full]
  connect_bd_net -net fifo_generator_2_almost_empty [get_bd_ports almost_empty_2] [get_bd_pins fifo_generator_2/almost_empty]
  connect_bd_net -net fifo_generator_2_dout [get_bd_ports dout_2] [get_bd_pins fifo_generator_2/dout]
  connect_bd_net -net fifo_generator_2_empty [get_bd_ports empty_2] [get_bd_pins fifo_generator_2/empty]
  connect_bd_net -net fifo_generator_2_full [get_bd_ports full_2] [get_bd_pins fifo_generator_2/full]
  connect_bd_net -net fifo_generator_3_almost_empty [get_bd_ports almost_empty_3] [get_bd_pins fifo_generator_3/almost_empty]
  connect_bd_net -net fifo_generator_3_dout [get_bd_ports dout_3] [get_bd_pins fifo_generator_3/dout]
  connect_bd_net -net fifo_generator_3_empty [get_bd_ports empty_3] [get_bd_pins fifo_generator_3/empty]
  connect_bd_net -net fifo_generator_3_full [get_bd_ports full_3] [get_bd_pins fifo_generator_3/full]
  connect_bd_net -net rd_en_0_1 [get_bd_ports rd_en_0] [get_bd_pins fifo_generator_0/rd_en]
  connect_bd_net -net rd_en_1_1 [get_bd_ports rd_en_1] [get_bd_pins fifo_generator_1/rd_en]
  connect_bd_net -net rd_en_2_1 [get_bd_ports rd_en_2] [get_bd_pins fifo_generator_2/rd_en]
  connect_bd_net -net rd_en_3_1 [get_bd_ports rd_en_3] [get_bd_pins fifo_generator_3/rd_en]
  connect_bd_net -net srst_1 [get_bd_ports srst] [get_bd_pins fifo_generator_0/srst] [get_bd_pins fifo_generator_1/srst] [get_bd_pins fifo_generator_2/srst] [get_bd_pins fifo_generator_3/srst]
  connect_bd_net -net wr_en_0_1 [get_bd_ports wr_en_0] [get_bd_pins fifo_generator_0/wr_en]
  connect_bd_net -net wr_en_1_1 [get_bd_ports wr_en_1] [get_bd_pins fifo_generator_1/wr_en]
  connect_bd_net -net wr_en_2_1 [get_bd_ports wr_en_2] [get_bd_pins fifo_generator_2/wr_en]
  connect_bd_net -net wr_en_3_1 [get_bd_ports wr_en_3] [get_bd_pins fifo_generator_3/wr_en]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


