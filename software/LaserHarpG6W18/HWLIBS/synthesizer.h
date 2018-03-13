#ifndef SYNTHESIZER_H_
#define SYNTHESIZER_H_

#define SYNTH_OFFSET 20

void writeFreqToSynthesizer(int diode, float frequnecy);
INT32S readFromSythesizer(int diode, int enabled);
float readFromEnvelope(int envelopeLocation, int diode, int reset, int instrument);

#endif 