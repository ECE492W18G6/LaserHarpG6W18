/*
 * Header file for Laser Harp App File
 *  Created on: March 22, 2018
 *  Authors: Adam Narten, Randi Derbyshire, Oliver Rarog
 */
#ifndef APP_H_
#define APP_H_

#define FPGA_TO_HPS_LW_ADDR(base)  ((void *) (((char *)  (ALT_LWFPGASLVS_ADDR))+ (base)))

#define APP_TASK_PRIO 5
#define AUDIO_TASK_PRIO 6
#define TASK_STACK_SIZE 4096

/*
*********************************************************************************************************
*                                      DEFINITIONS FOR BASE ADDRESSES
* Compute absolute address of any slave component attached to lightweight bridge
* base is address of component in QSYS window
* This computation only works for slave components attached to the lightweight bridge
* base should be ranged checked from 0x0 - 0x1fffff
*********************************************************************************************************
*/
#define SWITCH_ADD 0x300
#define SWITCH_BASE FPGA_TO_HPS_LW_ADDR(SWITCH_ADD)
#define SYNTH_ADD 0x1000
#define SYNTH_BASE FPGA_TO_HPS_LW_ADDR(SYNTH_ADD)
#define ENVELOPE_ADD 0x1800
#define ENVELOPE_BASE FPGA_TO_HPS_LW_ADDR(ENVELOPE_ADD)
#define PHOTODIODE_ADD 0x2000
#define PHOTODIODE_BASE FPGA_TO_HPS_LW_ADDR(PHOTODIODE_ADD)

#define DIODE_0_MASK 64
#define DIODE_1_MASK 128
#define DIODE_2_MASK 1
#define DIODE_3_MASK 2
#define DIODE_4_MASK 4
#define DIODE_5_MASK 8
#define DIODE_6_MASK 16
#define DIODE_7_MASK 32

/*
*********************************************************************************************************
*                                      LOCAL FUNCTION PROTOTYPES
*********************************************************************************************************
*/

static  void  AppTask             (void        *p_arg);
static  void  AudioTask           	 (void        *p_arg);

#endif /* APP_H_ */
