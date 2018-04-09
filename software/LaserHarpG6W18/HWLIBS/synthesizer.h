#ifndef SYNTHESIZER_H_
#define SYNTHESIZER_H_

#include <hps.h>
#include <os_cpu.h>
#include <socal.h>

void writeFreqToSynthesizer(void *synthBase, int frequency, int diode, int instrument);
INT32S readFromSythesizer(void *diode, int enabled);
float readFromEnvelope(void *envelopeLocation, int diode, int reset, int instrument);
int EnvelopeOptions(int diode, int reset, int instrument);
void quickPianoDecay(INT32S startingValue);

#endif /* SYNTHESIZER_H_ */
