# Polyphonic LaserHarp

## Original Source Code
- **Synthesizer_tb.vhd** - Testbench file for the VHDL Synthesizer; *Tested and passed*
- **audio.c** - Audio driver functions for Audio Codec; *Executed*
- **photodiode.vhd** - VHDL component to read voltage changes provided by photodiode conduits; *Compiled*

## Adapted Source Code
- **lcd.c** - LCD driver functions for 16x2 LCD screen; *Executed*
- **audio_cfg.c** - Audio configuration driver for Audio Codec; *Executed*
- **sin_lut.vhd** - ROM with sine wave values; *Executed*
- **Synthesizer.vhd** - Sums up and accumulates frequency to search through sine LUT to find respective sine wave; *Executed*
- **toplevel.vhd** - Port connections for system components; *Executed*
- **app.c** - Task functions for Audio, LCD and LEDs; *Executed*

