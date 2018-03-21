/*
 * timer.h
 *
 *  Created on: Nov 1, 2017
 *      Author: nemtech
 */

#ifndef TIMER_H_
#define TIMER_H_

// ARM Timer OSCLTimer 0 BASE address == 0xFFD00000
// Important registers at offset 0x0, 0x8, 0xc
// Use this example
// #define  ARM_PTMR_REG_PTLR     (*((CPU_REG32 *)(ARM_PRIV_PERIPH_BASE + 0x0600))) /* Private timer load register.            */
#define		ARM_SP_TIMER_0_BASE				0xFFC08000

// OSCL Timer 0 Register Space and Options
#define  	ARM_OSCL_TIMER_0_BASE 			0xFFD00000
#define 	ARM_OSCL_TIMER_0_REG_LOADCOUNT	(*(( CPU_REG32 *) (ARM_OSCL_TIMER_0_BASE + 0x0)))

#define 	ARM_OSCL_TIMER_0_REG_CONTROL	(*(( CPU_REG32 *) (ARM_OSCL_TIMER_0_BASE + 0x8)))
#define 	ARM_OSCL_TIMER_0_ENABLE			DEF_BIT_00  	// or this
#define		ARM_OSCL_TIMER_0_DISABLE		~DEF_BIT_00		// and this
#define		ARM_OSCL_TIMER_0_USER_MODE		DEF_BIT_01		// or this
#define		ARM_OSCL_TIMER_0_FREE_RUN_MODE	~DEF_BIT_01		// and this
#define		ARM_OSCL_TIMER_0_INT_MASKED		DEF_BIT_02		// or this
#define		ARM_OSCL_TIMER_0_INT_UNMASKED	~DEF_BIT_02		// and this

#define		ARM_OSCL_TIMER_0_REG_EOI		(*((volatile CPU_REG32 *) (ARM_OSCL_TIMER_0_BASE + 0xC)))

#define		ARM_OSCL_TIMER_1_BASE			0xFFD01000

/*    QSYS Interval Timer Memory Map and Features*/

#define 	TIMER_0_BASE 	0x00000600

#define 	QSYS_TIMER_BASE ( ALT_LWFPGASLVS_ADDR  + TIMER_0_BASE)
#define 	QSYS_TIMER_REG_STATUS		(*(( CPU_REG32 *) (QSYS_TIMER_BASE + 0x0)))
#define		QSYS_TIMER_REG_CONTROL		(*(( CPU_REG32 *) (QSYS_TIMER_BASE + 0x4)))
#define		QSYS_TIMER_IRQ_ENABLE		DEF_BIT_00
#define		QSYS_TIMER_IRQ_DISABLE		~DEF_BIT_00
#define		QSYS_TIMER_CONT_ENABLE		DEF_BIT_01
#define		QSYS_TIMER_CONT_DISABLE		~DEF_BIT_01
#define		QSYS_TIMER_START			DEF_BIT_02
#define		QSYS_TIMER_STOP				DEF_BIT_03

void InitHPSTimerInterrupt (void);
void InitFPGATimerInterrupt(void);
void HPS_TimerISR_Handler(CPU_INT32U cpu_id);
void FPGA_TimerISR_Handler(CPU_INT32U cpu_id);

extern void FPGA_LEDS_Off(void);
extern void FPGA_LEDS_On(void);



#endif /* TIMER_H_ */
