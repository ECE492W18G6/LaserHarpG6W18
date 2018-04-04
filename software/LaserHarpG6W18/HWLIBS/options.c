#include "options.h"
#include "lcd.h"

#include  <app_cfg.h>
#include  <lib_mem.h>

#include  <bsp.h>
#include  <bsp_int.h>
#include  <bsp_os.h>
#include  <cpu_cache.h>

#include  <cpu.h>
#include  <cpu_core.h>

#include  <os.h>
#include  <hps.h>
#include  <socal.h>
#include  <hwlib.h>
#include  <math.h>

int SCALE = 0;
int INSTRUMENT = 0;
int OCTAVE = 2;
int KEY = 0;
int REVERB;
int SUSTAIN;

char scale[20];
char instrument[10];
char octave[10];
char key[2];

float frequencies[NUM_STRINGS+1];

void change_scale() {
	SCALE = (SCALE + 1) % NUM_SCALES;
}

int get_octave() {
	return OCTAVE;
}

void change_instrument() {
	INSTRUMENT = (INSTRUMENT + 1) % NUM_INSTRUMENTS;
}

void change_octave() {
	OCTAVE = OCTAVE + 1;
	if (OCTAVE > MAX_OCTAVE) {
		OCTAVE = MIN_OCTAVE;
	}
}

void change_key() {
	KEY = (KEY+1) % NUM_KEYS;
}

int sustain_enabled() {
	return alt_read_word(PEDAL_BASE);
}

void get_frequencies(int* integers, float* fractions) {
	int i;
	for (i = 0; i < NUM_STRINGS; i++) {
		integers[i] = (int) floor(frequencies[i+1]);
		fractions[i] = frequencies[i+1] - integers[i];
	}
}

void update_LCD_string() {

	switch (SCALE) {
		case MAJOR: // TONE TONE SEMITONE TONE TONE TONE SEMITONE
			sprintf(scale, "Major Scale      ");
			frequencies[1] = ( C2_FREQUENCY * pow(2,(double)KEY/12)   * pow(2,OCTAVE-2) );
			frequencies[2] = ( C2_FREQUENCY * pow(2,(double)(KEY+2)/12) * pow(2,OCTAVE-2) );
			frequencies[3] = ( C2_FREQUENCY * pow(2,(double)(KEY+4)/12) * pow(2,OCTAVE-2) );
			frequencies[4] = ( C2_FREQUENCY * pow(2,(double)(KEY+5)/12) * pow(2,OCTAVE-2) );
			frequencies[5] = ( C2_FREQUENCY * pow(2,(double)(KEY+7)/12) * pow(2,OCTAVE-2) );
			frequencies[6] = ( C2_FREQUENCY * pow(2,(double)(KEY+9)/12) * pow(2,OCTAVE-2) );
			frequencies[7] = ( C2_FREQUENCY * pow(2,(double)(KEY+11)/12) * pow(2,OCTAVE-2) );
			frequencies[8] = ( C2_FREQUENCY * pow(2,(double)(KEY+12)/12) * pow(2,OCTAVE-2) );
			break;
		case NATURAL_MINOR: // TONE SEMITONE TONE TONE SEMITONE TONE TONE
			sprintf(scale, "Nat. Minor Scale ");
			frequencies[1] = ( C2_FREQUENCY * pow(2,(double)KEY/12) * pow(2,OCTAVE-2) );
			frequencies[2] = ( C2_FREQUENCY * pow(2,(double)(KEY+2)/12) * pow(2,OCTAVE-2) );
			frequencies[3] = ( C2_FREQUENCY * pow(2,(double)(KEY+3)/12) * pow(2,OCTAVE-2) );
			frequencies[4] = ( C2_FREQUENCY * pow(2,(double)(KEY+5)/12) * pow(2,OCTAVE-2) );
			frequencies[5] = ( C2_FREQUENCY * pow(2,(double)(KEY+7)/12) * pow(2,OCTAVE-2) );
			frequencies[6] = ( C2_FREQUENCY * pow(2,(double)(KEY+8)/12) * pow(2,OCTAVE-2) );
			frequencies[7] = ( C2_FREQUENCY * pow(2,(double)(KEY+10)/12) * pow(2,OCTAVE-2) );
			frequencies[8] = ( C2_FREQUENCY * pow(2,(double)(KEY+12)/12) * pow(2,OCTAVE-2) );
			break;
		case HARMONIC_MINOR: // TONE SEMITONE TONE TONE SEMITONE TONE TONE
			sprintf(scale, "Har. Minor Scale ");
			frequencies[1] = ( C2_FREQUENCY * pow(2,(double)KEY/12) * pow(2,OCTAVE-2) );
			frequencies[2] = ( C2_FREQUENCY * pow(2,(double)(KEY+2)/12) * pow(2,OCTAVE-2) );
			frequencies[3] = ( C2_FREQUENCY * pow(2,(double)(KEY+3)/12) * pow(2,OCTAVE-2) );
			frequencies[4] = ( C2_FREQUENCY * pow(2,(double)(KEY+5)/12) * pow(2,OCTAVE-2) );
			frequencies[5] = ( C2_FREQUENCY * pow(2,(double)(KEY+7)/12) * pow(2,OCTAVE-2) );
			frequencies[6] = ( C2_FREQUENCY * pow(2,(double)(KEY+8)/12) * pow(2,OCTAVE-2) );
			frequencies[7] = ( C2_FREQUENCY * pow(2,(double)(KEY+11)/12) * pow(2,OCTAVE-2) );
			frequencies[8] = ( C2_FREQUENCY * pow(2,(double)(KEY+12)/12) * pow(2,OCTAVE-2) );
			break;
		case MELODIC_MINOR: // TONE SEMITONE TONE TONE SEMITONE TONE TONE
			sprintf(scale, "Mel. Minor Scale ");
			frequencies[1] = ( C2_FREQUENCY * pow(2,(double)KEY/12) * pow(2,OCTAVE-2) );
			frequencies[2] = ( C2_FREQUENCY * pow(2,(double)(KEY+2)/12) * pow(2,OCTAVE-2) );
			frequencies[3] = ( C2_FREQUENCY * pow(2,(double)(KEY+3)/12) * pow(2,OCTAVE-2) );
			frequencies[4] = ( C2_FREQUENCY * pow(2,(double)(KEY+5)/12) * pow(2,OCTAVE-2) );
			frequencies[5] = ( C2_FREQUENCY * pow(2,(double)(KEY+7)/12) * pow(2,OCTAVE-2) );
			frequencies[6] = ( C2_FREQUENCY * pow(2,(double)(KEY+9)/12) * pow(2,OCTAVE-2) );
			frequencies[7] = ( C2_FREQUENCY * pow(2,(double)(KEY+11)/12) * pow(2,OCTAVE-2) );
			frequencies[8] = ( C2_FREQUENCY * pow(2,(double)(KEY+12)/12) * pow(2,OCTAVE-2) );
			break;
		case BLUES: // 3 | TONE | SEMITONE | SEMITONE | 3
			sprintf(scale, "Blues Scale      ");
			frequencies[1] = ( C2_FREQUENCY * pow(2,(double)KEY/12) * pow(2,OCTAVE-2) );
			frequencies[2] = ( C2_FREQUENCY * pow(2,(double)(KEY+3)/12) * pow(2,OCTAVE-2) );
			frequencies[3] = ( C2_FREQUENCY * pow(2,(double)(KEY+5)/12) * pow(2,OCTAVE-2) );
			frequencies[4] = ( C2_FREQUENCY * pow(2,(double)(KEY+6)/12) * pow(2,OCTAVE-2) );
			frequencies[5] = ( C2_FREQUENCY * pow(2,(double)(KEY+7)/12) * pow(2,OCTAVE-2) );
			frequencies[6] = ( C2_FREQUENCY * pow(2,(double)(KEY+10)/12) * pow(2,OCTAVE-2) );
			frequencies[7] = ( C2_FREQUENCY * pow(2,(double)(KEY+12)/12) * pow(2,OCTAVE-2) );
			frequencies[8] = ( C2_FREQUENCY * pow(2,(double)(KEY+15)/12) * pow(2,OCTAVE-2) );
			break;
		case DORIAN: // TONE SEMITONE TONE TONE TONE SEMITONE TONE
			sprintf(scale, "Dorian Scale     ");
			frequencies[1] = ( C2_FREQUENCY * pow(2,(double)KEY/12) * pow(2,OCTAVE-2) );
			frequencies[2] = ( C2_FREQUENCY * pow(2,(double)(KEY+2)/12) * pow(2,OCTAVE-2) );
			frequencies[3] = ( C2_FREQUENCY * pow(2,(double)(KEY+3)/12) * pow(2,OCTAVE-2) );
			frequencies[4] = ( C2_FREQUENCY * pow(2,(double)(KEY+5)/12) * pow(2,OCTAVE-2) );
			frequencies[5] = ( C2_FREQUENCY * pow(2,(double)(KEY+7)/12) * pow(2,OCTAVE-2) );
			frequencies[6] = ( C2_FREQUENCY * pow(2,(double)(KEY+9)/12) * pow(2,OCTAVE-2) );
			frequencies[7] = ( C2_FREQUENCY * pow(2,(double)(KEY+10)/12) * pow(2,OCTAVE-2) );
			frequencies[8] = ( C2_FREQUENCY * pow(2,(double)(KEY+12)/12) * pow(2,OCTAVE-2) );
			break;
		default:
			sprintf(scale, "Major Scale  ");
			frequencies[1] = ( C2_FREQUENCY * pow(2,(double)KEY/12)   * pow(2,OCTAVE-2) );
			frequencies[2] = ( C2_FREQUENCY * pow(2,(double)(KEY+2)/12) * pow(2,OCTAVE-2) );
			frequencies[3] = ( C2_FREQUENCY * pow(2,(double)(KEY+4)/12) * pow(2,OCTAVE-2) );
			frequencies[4] = ( C2_FREQUENCY * pow(2,(double)(KEY+5)/12) * pow(2,OCTAVE-2) );
			frequencies[5] = ( C2_FREQUENCY * pow(2,(double)(KEY+7)/12) * pow(2,OCTAVE-2) );
			frequencies[6] = ( C2_FREQUENCY * pow(2,(double)(KEY+9)/12) * pow(2,OCTAVE-2) );
			frequencies[7] = ( C2_FREQUENCY * pow(2,(double)(KEY+11)/12) * pow(2,OCTAVE-2) );
			frequencies[8] = ( C2_FREQUENCY * pow(2,(double)(KEY+12)/12) * pow(2,OCTAVE-2) );
	}
	switch (INSTRUMENT) {
		case HARP:
			sprintf(instrument, "Harp ");
			break;
		case PIANO:
			sprintf(instrument, "Piano ");
			break;
		case CLARINET:
			sprintf(instrument, "Clarinet ");
			break;
		case VIOLIN:
			sprintf(instrument, "Violin ");
			break;
		default:
			sprintf(instrument, "Harp ");
	}
	switch (OCTAVE) {
		case OCTAVE_2:
			sprintf(octave, "Octave 2     ");
			break;
		case OCTAVE_3:
			sprintf(octave, "Octave 3     ");
			break;
		case OCTAVE_4:
			sprintf(octave, "Octave 4     ");
			break;
		case OCTAVE_5:
			sprintf(octave, "Octave 5     ");
			break;
		case OCTAVE_6:
			sprintf(octave, "Octave 6     ");
			break;
		default:
			sprintf(octave, "Octave 2     ");
	}
	switch (KEY) {
		case C:
			sprintf(key, "C ");
			break;
		case C_SHARP:
			sprintf(key, "C# ");
			break;
		case D:
			sprintf(key, "D ");
			break;
		case D_SHARP:
			sprintf(key, "D# ");
			break;
		case E:
			sprintf(key, "E ");
			break;
		case F:
			sprintf(key, "F ");
			break;
		case F_SHARP:
			sprintf(key, "F# ");
			break;
		case G:
			sprintf(key, "G ");
			break;
		case G_SHARP:
			sprintf(key, "G# ");
			break;
		case A:
			sprintf(key, "A ");
			break;
		case A_SHARP:
			sprintf(key, "A# ");
			break;
		case B:
			sprintf(key, "B ");
			break;
		default:
			sprintf(key, "C ");
	}

	MoveCursorLCD(20);
	PrintStringLCD(instrument);
	PrintStringLCD(octave);
	MoveCursorLCD(0);
	PrintStringLCD(key);
	PrintStringLCD(scale);
	MoveCursorLCD(20);
	PrintStringLCD(instrument);
}
