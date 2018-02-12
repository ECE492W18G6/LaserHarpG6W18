clear; 

c_scale = [261 293 329.6 349.2 392 440 493.9 523.3];

[a1, freq] = synthesis(c_scale(6)); % freq 261
[a2, freq] = synthesis(c_scale(1)); % frew 440

final = a1/2 + a2/2;


 % write the changed matrix to a new .wav file.
audiowrite('middle_a.wav', a1, freq); 
audiowrite('middle_c.wav', a2, freq);
audiowrite('ac_chord.wav', final, freq);
