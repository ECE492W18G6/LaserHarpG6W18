# Polyphonic LaserHarp

## Original Source Code
- **Synthesizer_tb.vhd** - Testbench file for the VHDL Synthesizer; *Tested and passed*
- **audio.c** - Audio driver functions for Audio Codec; *Executed*
- **options.c** - Functions for instrument, key, scale, octave implementations in instrument; *Executed*
- **button.c** - Button functions on the FPGA board for changing the instrument’s sound; *Executed*
- **synthesizer.c** - Functions for ease of reading and writing the synthesizer and envelope to and from the memory; *Executed*
- **Photodiodes.vhd** - VHDL component to read voltage changes provided by photodiode conduits; *Executed*
- **EnvelopeController.vhd** - Controls the envelopes between the instruments and pedal; *Executed*
- **EnvelopeController_tb.vhd** - Testbench file for the envelope controller; *Tested and passed*
- **HarpEnvelope_lut.vhd** - Sound envelope for the harp; *Executed*
- **ClarinetEnvelope_lut.vhd** - Sound envelope for the clarinet; *Executed*
- **HarpsichordEnvelope_lut.vhd** - Sound envelope for the harpsichord; *Executed*
- **PianoEnvelope_lut.vhd** - Sound envelope for the piano; *Executed*
- **MUX4x1.vhd** - *Executed*
- **MUX8x1.vhd** - *Executed*
- **Pedal.vhd** - Pedal file functions for when the pedal is pushed down; *Executed*

## Adapted Source Code
- **lcd.c** - LCD driver functions for 16x2 LCD screen; *Executed*
- **audio_cfg.c** - Audio configuration driver for Audio Codec; *Executed*
- **PianoSin_lut.vhd** - ROM with sine wave values for the piano; *Executed*
- **HarpsichordSin_lut.vhd** - ROM with sine wave values for the harpsichord; *Executed*
- **HarpSin_lut.vhd** - ROM with sine wave values for the harp; *Executed*
- **ClarinetSin_lut.vhd** - ROM with sine wave values for the clarinet; *Executed*
- **Synthesizer.vhd** - Sums up and accumulates frequency to search through sine LUT to find respective sine wave; *Executed*
- **toplevel.vhd** - Port connections for system components; *Executed*
- **app.c** - Task functions for Audio, LCD and LEDs; *Executed*
