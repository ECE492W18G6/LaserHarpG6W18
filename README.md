# Polyphonic LaserHarp

A polyphonic laser harp with selectable instruments, scales, keys, and octaves.

### The Laser Harp includes:
- Eight monotonic laser “strings”
- Selectable scales; major, natural minor, harmonic minor, melodic minor, blues, and dorian
- Capability to change keys (C, C#, D, D#, E, F, F#, G, G#, A, A#, B).
- Capability to change between octaves 2 through 5
- Audio synthesis to produce notes

#### Allowing the user to select from multiple instrument sounds
- Harp
- Piano
- Clarinet
- Harpsichord

### Audio Effects

#### Sound Envelope: Different envelope implementations depending on the instrument. 
- Harp has a sharp rise, and a slow decay
- Piano and Harpsichord have a short decay when played “staccato,” and a longer decay when played “legato”
- Clarinet only has sustain, with an abrupt attack and release

#### Timbre Sound (Frequency Harmonics): Adding harmonics to make the harp sound like a specific instrument
- Piano has basic frequency harmonics
- Harp is similar with added higher frequencies
- Clarinet uses odd harmonics only
- Harpsichord uses sawtooth waveform instead of sine wave

#### Sustained Notes: Implementing a similar effect to that of the right pedal on a piano
- Piano and Harpsichord have longer decays when sustained
- Harp is not affected by sustaining
- Clarinet keeps note sustained until the pedal is released

#### Octave changing: Pressing on the pedal will shift the scale up or down an octave. This allows for ease of access to more than one octave while playing melodies.


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
- **MUX4x1.vhd** - A generic n-bit multiplexer which takes in 4 std_logic_vector signals, 2 selector bits and outputs the selected signal; *Executed*
- **MUX8x1.vhd** - A generic n-bit multiplexer which takes in 8 std_logic_vector signals, 3 selector bits and outputs the selected signal; *Executed*
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
