function note = makenote(freq, Fs, duration, env)
    t = 0:(1/duration)/Fs:1;
    note = sin(2 * pi * t *(440*2.^((freq-1)/12)));
    note = note .* env;
end