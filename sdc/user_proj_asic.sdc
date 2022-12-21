###############################################################################
# Created by write_sdc
# Wed Dec 21 10:36:39 2022
###############################################################################
current_design user_proj_asic
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name wb_clk_i -period 10.0000 [get_ports {wb_clk_i}]
set_clock_transition 0.1500 [get_clocks {wb_clk_i}]
set_clock_uncertainty 0.2500 wb_clk_i
set_propagated_clock [get_clocks {wb_clk_i}]
set_input_delay 2.0000 -clock [get_clocks {wb_clk_i}] -add_delay [get_ports {A_PAD}]
set_input_delay 2.0000 -clock [get_clocks {wb_clk_i}] -add_delay [get_ports {B_PAD}]
set_input_delay 2.0000 -clock [get_clocks {wb_clk_i}] -add_delay [get_ports {sel}]
set_input_delay 2.0000 -clock [get_clocks {wb_clk_i}] -add_delay [get_ports {user_clock2}]
set_input_delay 2.0000 -clock [get_clocks {wb_clk_i}] -add_delay [get_ports {wb_rst_i}]
set_output_delay 2.0000 -clock [get_clocks {wb_clk_i}] -add_delay [get_ports {OUT_1}]
set_output_delay 2.0000 -clock [get_clocks {wb_clk_i}] -add_delay [get_ports {OUT_2}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {OUT_1}]
set_load -pin_load 0.0334 [get_ports {OUT_2}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {A_PAD}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {B_PAD}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {sel}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {user_clock2}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wb_clk_i}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wb_rst_i}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_fanout 10.0000 [current_design]
