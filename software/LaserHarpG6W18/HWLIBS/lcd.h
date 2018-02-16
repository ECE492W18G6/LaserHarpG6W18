/* Nancy Minderman
 * nancy.minderman@ualberta.ca
 *
 * Brendan Bruner bbruner@ualberta.ca
 * December 2017
 */

#ifndef _LCD_H_
#define _LCD_H_


#define LCD_COLS		20
#define LCD_ORIGIN		0
#define LCD_DDRAM_LINE1 0
#define LCD_DDRAM_LINE2 0x40


#define LSBIT			0x01
#define HIGH 			1
#define LOW				0

/* List of available commands */
/* Use the bitwise or command to build a compound command
 * to send to the LCD
 */
#define CMD_CLEAR		0x01
#define CMD_HOME		0x02
#define CMD_ENTRY_MODE	0x04
#define CMD_DISPLAY		0x08
#define CMD_SHIFT		0x10
#define CMD_FUNCTION	0x20
#define CMD_CGRAM_ADR	0x40
#define CMD_DDRAM_ADR	0x80

/* CMD_ENTRY_MODE constants
 */
#define ENTRY_CURSOR_INC	0x02 // increment cursor position
#define ENTRY_CURSOR_DEC	0x00 // decrement cursor position
#define ENTRY_SHIFT			0x01 // shift entire display
#define ENTRY_NOSHIFT		0x00 // don't shift display

/* CMD_DISPLAY constants
 */
#define DISPLAY_ON			0x04	// display on
#define DISPLAY_OFF			0x00	// display off
#define DISPLAY_CURSOR		0x02	// cursor on
#define DISPLAY_NOCURSOR	0x00	// cursor off
#define DISPLAY_BLINK		0x01	// cursor blink on
#define DISPLAY_NOBLINK		0x00	// cursor blink off

// CMD_FUNCTION constants to initialize LCD hardware

#define FUNCTION_8BIT	0x10 // enable 8 pin mode
#define FUNCTION_4BIT	0x00 // enable 4 pin mode (not supported)
#define FUNCTION_2LINE	0x08 // LCD has two lines, line two starts at addr 0x40
#define FUNCTION_1LINE	0x00 // LCD has one continuous line
#define FUNCTION_5x10	0x04 // use 5x10 custom characters
#define FUNCTION_5x8	0x00 // use 5x8 custom characters

/* CMD_SHIFT constants
 */
#define SHIFT_SCREEN	0x08 // shift display
#define SHIFT_CURSOR	0x00 // shift cursor
#define SHIFT_RIGHT		0x04 // to the right
#define SHIFT_LEFT		0x00 // to the left

#ifndef WAIT_FOREVER
#define WAIT_FOREVER	0
#endif



//*********************** Use these functions only in your code*********************************************


	/* Initialise LCD hardware*/
	void InitLCD(void );

	/* Clear the display */
	void ClearLCD(void);

	/* Move cursor to home position (top/left) */
	void HomeLCD(void);

	/* Moves the cursor to a position  */
	void MoveCursorLCD( unsigned char pos);

	/* Print a single ASCII character to the LCD screen at the current cursor position. */
	void PrintCharLCD(char c);

	/*Print a c-style string to the LCD screen at the current cursor position */
	void PrintStringLCD(const char * str);

#endif

