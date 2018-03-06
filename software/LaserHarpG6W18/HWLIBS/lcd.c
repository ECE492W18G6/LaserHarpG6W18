/* Original Authors: Nancy Minderman (nancy.minderman@ualberta.ca), Brendan Bruner (bbruner@ualberta.ca)
 * Date created: December 2017
 */

#include <os.h>
#include <hps.h>
#include <socal.h>
#include <hwlib.h>
#include "lcd.h"



#define FPGA_TO_HPS_LW_ADDR(base)  ((void *) (((char *)  (ALT_LWFPGASLVS_ADDR))+ (base)))


// Address is hard-coded to deal with create-sopc-header-files privilege issue
// when using Windows
#define CHARACTER_LCD_0_BASE 0x00000200
#define LCD_BASE FPGA_TO_HPS_LW_ADDR(CHARACTER_LCD_0_BASE)


	/* print a character to the LCD at the current position
	 * of the cursor on the screen */
static	void print_char(char data);


	/* Move the cursor to a position.
	 * position can be from 0-39
	 */
static void move(unsigned char pos);


	/* Sends a command to the LCD over data lines
	 * See lcd.h for full list*/
static void send_cmd( unsigned char cmd);


	/* Sends data to the LCD to display.
	 * This data must be printable ASCII characters
	 * for the data to display correctly
	 */
static void send_data( unsigned char data);


static unsigned char  position; 		// position on screen should be 0 - 39

static OS_EVENT *			sem;		// internal semaphore to guarantee atomicity of each LCD instruction
										// and manage shared resource



/* Name:  send_cmd
 * Description: Send a command to the LCD at base address 0.
 * RS line is set by the VHDL component to access correct byte
 * Inputs:  unsigned char cmd
 * Outputs: none
 */
static void send_cmd(unsigned char cmd)
{
	alt_write_byte(LCD_BASE, cmd);
}

/* Name: send_data
 * Description: Send a single character to the LCD at base address + 1 byte
 * RS line is set by the VHDL component to access correct byte
 * Inputs: unsigned char data must be a printable ASCII character.
 * Outputs: none
 */
static void send_data(unsigned char data)
{

	alt_write_byte(LCD_BASE+1, data);
}

/* Name: print_char
 * Description: Prints a single character to the LCD to
 * the current cursor position and increments the position.
 * Decrementing is currently unimplemented.
 * Inputs:
 * char c must be a printable ASCII character, a carriage return
 * or a newline character. Anything else will look like garbage.
 * Outputs: none
 */
static void print_char( char c)
{
			if (c =='\n') {
				if (position < LCD_COLS){
					move(LCD_COLS);
				} else if (position < (LCD_COLS*2)) {
					move( LCD_ORIGIN);
				}
			} else if (c == '\r') {
				if (position < LCD_COLS) {
					move( LCD_ORIGIN);
				} else if ( position < (LCD_COLS*2) ) {
					move( LCD_COLS);
				}
			} else {
				send_data( c);
				position++; // by default we go forward
				if(position == LCD_COLS){
					move(LCD_COLS);
				}
				else if (position == (LCD_COLS*2) ) {
					move(LCD_ORIGIN);
				}
			}
	}

/* Name: move
 * Description: Moves the current cursor position but does not make
 * any change to data currently being displayed.
 * Inputs:
 * unsigned char position should be between 0 and 39
 * Output: void
 */
static void move( unsigned char pos)
{
	unsigned char line_adj = 0;
	if( pos >= (LCD_COLS * 2)) {
		printf("Lcd::move bad position\n");
		return;
	} else if ( (pos >= LCD_COLS) && (pos < LCD_COLS*2)) {
		line_adj = LCD_DDRAM_LINE2 - LCD_COLS;
	} else {
		line_adj = LCD_DDRAM_LINE1;
	}
	send_cmd( (CMD_DDRAM_ADR + pos + line_adj ));
	position = pos;
}

/* Name: Init
 * Description: Initializes the hardware and the internal semaphore
 * to a known good state. The semaphores guarantee atomic instructions.
 * Inputs: base
 * Outputs: none
 */
void InitLCD(void)
{
	INT8U err = OS_ERR_NONE;
	static unsigned char   sem_inited;		// Calling Init method more than once should not reinitialize the semaphore
	if (sem_inited == false) {
		sem = OSSemCreate(1);
		if (sem != 0)
			sem_inited = true;
		else {
			printf("LCD::Init sem not valid\n");
		}
	}
	OSSemPend(sem,WAIT_FOREVER, &err);
		if( err == OS_ERR_NONE)
		{
			send_cmd(CMD_DISPLAY|DISPLAY_ON|DISPLAY_NOCURSOR|DISPLAY_NOBLINK);
			send_cmd(CMD_CLEAR);
			err = OSSemPost(sem);
			if (err != OS_ERR_NONE) printf("Lcd::Init Error: %i \n", err);
		} else {
			printf("Lcd::Init Error: %i \n", err);
		}



}


/* Name:Clear
 * Description: Clears screen and resets the hardware and position
 * variable to 0 (upper left position),
 * The semaphore guarantees atomic instructions.
 * Inputs: none
 * Outputs: none
 */
void ClearLCD(void)
{
	INT8U err = OS_ERR_NONE;

	OSSemPend(sem,WAIT_FOREVER, &err);
	if (err == OS_ERR_NONE)
	{
			position = 0;
			send_cmd(CMD_CLEAR);
		OSTimeDly(OS_TICKS_PER_SEC/10);
		err = OSSemPost(sem);
		if (err != OS_ERR_NONE) printf("Lcd::Clear Error: %i", err);
	} else {
		printf("Lcd::Clear Error: %i", err);
	}
}

/* Name: Home
 * Description: Resets the current cursor position to 0 (upper left).
 * The semaphore guarantees atomic instructions.
 * Inputs: none
 * Outputs: none
 */
void HomeLCD(void)
{
	INT8U err = OS_ERR_NONE;

	OSSemPend(sem,WAIT_FOREVER, &err);
	if (err == OS_ERR_NONE )
	{
		send_cmd(CMD_HOME);
		position = 0;
		OSTimeDly(OS_TICKS_PER_SEC/10);
		err = OSSemPost(sem);
		if (err != OS_ERR_NONE) printf ("Lcd::Home Error: %i", err);
	} else {
		printf("Lcd::Clear Error: %i", err);
	}
}

/* Name: MoveCursor
 * Description: Moves the cursor to the desired position.
 * Bottom line has index 20 -39
 * Inputs: unsigned char position.
 * position should be between 0-39.
 * Top line has index 0-19
 * Bottom line has index 20-39
 * Outputs: none
 */
void MoveCursorLCD(unsigned char pos)
{

	INT8U err = OS_ERR_NONE;

	OSSemPend(sem,WAIT_FOREVER, &err);
	if( err == OS_ERR_NONE)
	{
		move(pos);
		err = OSSemPost(sem);
		if (err != OS_ERR_NONE) printf("Lcd::MoveCursor Error: %i \n", err);
	} else {
		printf("Lcd::MoveCursor Error: %i", err);
	}
}

/* Name: PrintChar
 * Description: Prints a single character to the LCD at the current
 * cursor position. The semaphores guarantee atomic instructions.
 * Inputs:
 * char c must be a printable ascii character, a carriage
 * return or a newline character
 * Outputs: none
 */
void PrintCharLCD( char c)
{
	INT8U err = OS_ERR_NONE;

	OSSemPend(sem,WAIT_FOREVER, &err);
	if(err == OS_ERR_NONE)
	{
		print_char( c);
		err = OSSemPost(sem);
		if (err != OS_ERR_NONE) printf ("Lcd::PrintChar Error: %i \n",err);
	} else {
		printf("Lcd::PrintChar Error: %i \n", err);
	}
}

/* Name: PrintString
 * Description: Prints a c-style string to the LCD at the current cursor
 * position. The semaphores guarantee atomic instructions.
 * Inputs:
 * const char * points to the first letter of the string.
 * Unpredictable results will occur if the string is not
 * null-terminated or if a NULL pointer is passed in.
 * Outputs: none
 */
void PrintStringLCD( const char * str)
{
	INT8U err = OS_ERR_NONE;
	int i = 0;

	OSSemPend(sem,WAIT_FOREVER, &err);
	if(err == OS_ERR_NONE)
	{
		while (str[i] != '\0') {
			print_char( str[i]);
			i++;
		}
		err = OSSemPost(sem);
		if (err != OS_ERR_NONE) printf ("LCD::PrintString Error: %i", err);
	} else {
		printf ("LCD::PrintChar Error: %i",err);
	}
}

