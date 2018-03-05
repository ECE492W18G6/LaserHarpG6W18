# LaserHarp

## Original Source Code
- **Synthesizer_tb.vhd** - Testbench file for the VHDL Synthesizer **T**
- **audio.c** - Audio driver functions for Audio Codec **E**

## Adapted Source Code
- **lcd.c** - LCD driver functions for 16x2 LCD screen **E**
- **audio_cfg.c** - Audio configuration driver for Audio Codec **E**
- **sin_lut.vhd** - ROM with sine wave values. **E**
- **Synthesizer.vhd** - Sums up and accumulates frequency to search through sine LUT to find respective sine wave. **E**
- **toplevel.vhd** - Port connections for system components **E**
- **app.c** - Port connections for system components **E**

