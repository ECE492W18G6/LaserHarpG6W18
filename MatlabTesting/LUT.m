clear; 

c_scale = [261 293 329.6 349.2 392 440 493.9 523.3];

% sine lookup table for after the accumulator.

[a1, freq] = synthesis(440);
[a2, freq] = synthesis(261);

final = a1/2 + a2/2;


 % write the changed matrix to a new .wav file.
audiowrite('middle_a.wav', a1, freq);
audiowrite('middle_c.wav', a2, freq);
audiowrite('ac_chord.wav', final, freq);