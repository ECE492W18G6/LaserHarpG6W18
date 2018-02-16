#include "audio.h"



/*
 *********************************************************************************************************
 *                                    reset_audio_core()
 *
 * Description : Clears the input and output audio FIFOs in the Audio core
 *
 *********************************************************************************************************
 */
void reset_audio_core() {

	INT32U control;
	control = alt_read_word(AUDIO_BASE + AUDIO_CONTROL_OFFSET);

	control = control | AUDIO_CONTROL_CR_MASK;
	control = control | AUDIO_CONTROL_CW_MASK;
	alt_write_word(AUDIO_BASE + AUDIO_CONTROL_OFFSET, control);

	control = control & ~AUDIO_CONTROL_CR_MASK;
	control = control & ~AUDIO_CONTROL_CW_MASK;
	alt_write_word(AUDIO_BASE + AUDIO_CONTROL_OFFSET, control);
}



/*
 *********************************************************************************************************
 *                                    enable_audio_read_interrupt()
 *
 * Description : Enables interrupt for 75% fill in the incoming audio data FIFO
 *
 *********************************************************************************************************
 */
void enable_audio_read_interrupt()
{
	INT32U control;
	control = alt_read_word(AUDIO_BASE + AUDIO_CONTROL_OFFSET);

	control = control | AUDIO_CONTROL_RE_MASK;
	alt_write_word(AUDIO_BASE + AUDIO_CONTROL_OFFSET, control);
}



/*
 *********************************************************************************************************
 *                                    disble_audio_read_interrupt()
 *
 * Description : Disables interrupt for 75% fill in the incoming audio data FIFO
 *
 *********************************************************************************************************
 */
void disable_audio_read_interrupt()
{
	INT32U control;
	control = alt_read_word(AUDIO_BASE + AUDIO_CONTROL_OFFSET);

	control = control & ~AUDIO_CONTROL_RE_MASK;
	alt_write_word(AUDIO_BASE + AUDIO_CONTROL_OFFSET, control);
}


/*
 *********************************************************************************************************
 *                                    enable_audio_write_interrupt()
 *
 * Description : Enables interrupt for 75% empty in outgoing audio data FIFO
 *
 *********************************************************************************************************
 */
void enable_audio_write_interrupt()
{
	INT32U control;
	control = alt_read_word(AUDIO_BASE + AUDIO_CONTROL_OFFSET);

	control = control | AUDIO_CONTROL_WE_MASK;
	alt_write_word(AUDIO_BASE + AUDIO_CONTROL_OFFSET, control);
}



/*
 *********************************************************************************************************
 *                                    disable_audio_write_interrupt()
 *
 * Description : Disables interrupt for 75% empty in outgoing audio data FIFO
 *
 *********************************************************************************************************
 */
void disable_audio_write_interrupt()
{
	INT32U control;
	control = alt_read_word(AUDIO_BASE + AUDIO_CONTROL_OFFSET);

	control = control & ~AUDIO_CONTROL_WE_MASK;
	alt_write_word(AUDIO_BASE + AUDIO_CONTROL_OFFSET, control);
}



/*
 *********************************************************************************************************
 *                                    is_audio_read_interrupt_pending()
 *
 * Description : Checks whether a read interrupt is pending from the audio core
 *
 * Returns     : 1 (true) if interrupt is pending, 0 (false) otherwise
 *
 *********************************************************************************************************
 */
INT32U is_audio_read_interrupt_pending()
{
	INT32U control;
	control = alt_read_word(AUDIO_BASE + AUDIO_CONTROL_OFFSET);

	if (control & AUDIO_CONTROL_RI_MASK) {
		return 1;
	}
	else {
		return 0;
	}
}


/*
 *********************************************************************************************************
 *                                    is_audio_write_interrupt_pending()
 *
 * Description : Checks whether a write interrupt is pending from the audio core
 *
 * Returns     : 1 (true) if interrupt is pending, 0 (false) otherwise
 *
 *********************************************************************************************************
 */
INT32U is_audio_write_interrupt_pending()
{
	INT32U control;
	control = alt_read_word(AUDIO_BASE + AUDIO_CONTROL_OFFSET);

	if (control & AUDIO_CONTROL_WI_MASK) {
		return 1;
	}
	else {
		return 0;
	}
}



void clear_adudio_FIFO() {
	alt_write_byte(AUDIO_BASE, 0x4);
}





/*
 *********************************************************************************************************
 *                                    read_audio_data()
 *
 * Description : Reads audio data from the Altera University IP core into a buffer
 *
 * Arguments   : buffer	       	A buffer allocated to hold the audio data
 * 				len				The number of samples to be read
 * 				channel 		Specifies which channel
 *
 * Returns     : The number of audio samples read into the buffer
 *
 *********************************************************************************************************
 */
INT32U read_audio_data(INT32U * buffer, INT32U len, INT32U channel) {

	INT32U fifospace;
	INT32U count = 0;

	while (count < len)
	{
		// determine the number of available words to be read from the channel
		fifospace = alt_read_word(AUDIO_BASE + 1);

		INT8U num_words;
		if (channel == LEFT_CHANNEL)
		{
			num_words = (fifospace & AUDIO_FIFOSPACE_RALC_MASK) >> AUDIO_FIFOSPACE_RALC_BIT_OFFSET;
		}
		else if (channel == RIGHT_CHANNEL)
		{
			num_words = (fifospace & AUDIO_FIFOSPACE_RARC_MASK) >> AUDIO_FIFOSPACE_RARC_BIT_OFFSET;
		}

		// read the next available word
		if (num_words > 0)
		{
			if (channel == LEFT_CHANNEL)
			{
				INT32U read = alt_read_word(AUDIO_BASE + 2);
				buffer[count] = read;
			}
			else if (channel == RIGHT_CHANNEL)
			{
				buffer[count] = alt_read_word(AUDIO_BASE + 3);
			}
			count = count + 1;
		}
		else
		{
			break;
		}

	}


	return count;
}




/*
 *********************************************************************************************************
 *                                    write_audio_data()
 *
 * Description : Writes audio data to the Altera University IP core from a buffer
 *
 * Arguments   : buffer	       	A buffer allocated to hold the audio data
 * 				len				The number of samples to be read
 * 				channel 		Specifies which channel
 *
 * Returns     : The number of audio samples read into the buffer
 *
 *********************************************************************************************************
 */
INT32U write_audio_data(INT32U * buffer, INT32U len, INT32U channel) {

	//printf("write has been called\n");

	INT32U fifospace;
	INT32U count = 0;

	while (count < len)
	{
		// determine the number of available space for words in the channel
		fifospace = alt_read_word(AUDIO_BASE + AUDIO_FIFOSPACE_OFFSET);
		INT8U num_words;
		if (channel == LEFT_CHANNEL)
		{
			num_words = (fifospace & AUDIO_FIFOSPACE_WSLC_MASK) >> AUDIO_FIFOSPACE_WSLC_BIT_OFFSET;
		}
		else if (channel == RIGHT_CHANNEL)
		{
			num_words = (fifospace & AUDIO_FIFOSPACE_WSRC_MASK) >> AUDIO_FIFOSPACE_WSRC_BIT_OFFSET;
		}

		//printf("numwords: %d\n", num_words);
		//printf("next wirte: %d\n", buffer[count]);
		// write word to the next available space
		if (num_words > 0)
		{
			if (channel == LEFT_CHANNEL)
			{
				alt_write_word(AUDIO_BASE + 2, buffer[count]);
				alt_write_word(AUDIO_BASE + 3, buffer[count]);
			}
			else if (channel == RIGHT_CHANNEL)
			{
				alt_write_word(AUDIO_BASE + AUDIO_RIGHTDATA_OFFSET, buffer[count]);
			}
			count = count + 1;
		}
		else
		{
			break;
		}

	}

	alt_write_byte(AUDIO_BASE + AUDIO_CONTROL_OFFSET, 0xC);
	alt_write_byte(AUDIO_BASE + AUDIO_CONTROL_OFFSET, 0x0);

	return count;

}
