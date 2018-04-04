/*
 * Header file for changing Laser Harp Options
 *  Created on: March 9, 2018
 *  Authors: Adam Narten & Randi Derbyshire
 */
#include <hps.h>

#ifndef OPTIONS_H_
#define OPTIONS_H_

#define FPGA_TO_HPS_LW_ADDR(base)  ((void *) (((char *)  (ALT_LWFPGASLVS_ADDR))+ (base)))
#define PEDAL_ADD 0x2100
#define PEDAL_BASE FPGA_TO_HPS_LW_ADDR(PEDAL_ADD)

#define C2_FREQUENCY 6.075
#define NUM_STRINGS 8

#define MAJOR 0
#define NATURAL_MINOR 1
#define HARMONIC_MINOR 2
#define MELODIC_MINOR 3
#define BLUES 4
#define DORIAN 5
#define NUM_SCALES 6

#define HARP 0
#define PIANO 1
#define CLARINET 2
#define VIOLIN 3
#define NUM_INSTRUMENTS 4

#define MIN_OCTAVE 2
#define OCTAVE_2 2
#define OCTAVE_3 3
#define OCTAVE_4 4
#define OCTAVE_5 5
#define OCTAVE_6 6
#define MAX_OCTAVE 6

#define C 0
#define C_SHARP 1
#define D 2
#define D_SHARP 3
#define E 4
#define F 5
#define F_SHARP 6
#define G 7
#define G_SHARP 8
#define A 9
#define A_SHARP 10
#define B 11
#define NUM_KEYS 12

void change_scale (void);
void change_instrument (void);
void change_octave (void);
void change_key (void);
int sustain_enabled(void);
void update_LCD_string(void);
int get_octave(void);
void get_frequencies(int* integers, float* fractions);

#endif /* OPTIONS_H_ */
