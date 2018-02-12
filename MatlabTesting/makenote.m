function note = makenote(freq, Fs, duration, envHi, envLo)
    t = 0:1/Fs:duration;
    
    % can further tweak these innerharmonics to improve sound
    note = 0.4 * sin(2 * pi * t * freq);
    note = note + 0.52 * sin(2 * pi * t * freq * 2);
    note = note + 0.15 * sin(2 * pi * t * freq * 3);
    note = note + 0.06 * sin(2 * pi * t * freq * 4);
    note = note + 0.15 * sin(2 * pi * t * freq * 5);
    note = note + 0.06 * sin(2 * pi * t * freq * 6);
    note = note + 0.01 * sin(2 * pi * t * freq * 7);
    
%     note = 0.4 * sin(2 * pi * t *(262*2.^((freq-1)/12)));
%     note = note + 0.52 * sin(2 * pi * t *(524*2.^((freq-1)/12)));
%     note = note + 0.15 * sin(2 * pi * t *(786*2.^((freq-1)/12)));
%     note = note + 0.06 * sin(2 * pi * t *(1048*2.^((freq-1)/12)));
%     note = note + 0.15 * sin(2 * pi * t *(1310*2.^((freq-1)/12)));
%     note = note + 0.06 * sin(2 * pi * t *(1572*2.^((freq-1)/12)));
%     note = note + 0.06 * sin(2 * pi * t *(1834*2.^((freq-1)/12)));
    for i = 1:length(note)
       if note(i) > 0
           note(i) = note(i) * envHi(i);
       else
           note(i) = note(i) * envLo(i) * -1;
       end
    end
end