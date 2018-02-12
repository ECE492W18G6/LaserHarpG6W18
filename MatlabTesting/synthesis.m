% https://stackoverflow.com/questions/29341664/direct-digital-synthesis-what-is-phase-truncation
% This code was found online at the link above, and used to understand how DDS (Direct Digital Synthesis) works.

function [wave, fs] = synthesis(freq)
    % INPUT PARAMETERS
    %-----------------------
    fs    = 2^14;   % Clock Sample Rate (hz)
    NT    = 1e4;    % Total Samples for example 
    foutd = freq;     % Desired Output Freq. (hz)
    N     = 16;     % Accumulator resolution (bits)
    P     = 12;     % Lookup Table resolution (bits)


    % FREQUENCY TUNING WORD
    %------------------------------
    FTWf = foutd/fs*2^N;          % float
    FTW  = round(foutd/fs*2^N);   % actual integer term for accumulator
    fout = FTW*fs/2^N;            % actual output frequency


    % SINE WAVE LOOKUP TABLE
    %---------------------------
    x = [0:2^P-1]';
    y = sin(x*2*pi / (2^P-1) );


    % INITIALIZE
    %--------------------------
    dt    = 1/fs;                % Time Step (sec)
    t     = [0:dt:dt*(NT-1)]';   % Time Vector
    phase = zeros(NT,1);         % Save phase vs. time
    wave  = zeros(NT,1);         % Save wave amplitude vs. time


    % SAMPLE THROUGH TIME
    %-----------------------
    pa = 0;   % Phase accumulator

    for ii=1:length(t)

        % ACCUMULATE PHASE
        pa = pa + FTW;

        % ROLLOVER PHASE
        if pa > 2^N
            pa = 1;
        end 

        % PHASE TRUNCATION
        indx = ceil(pa * 2^(P-N));

        % LOOKUP
        phase(ii) = pa;
        wave(ii)  = y( indx );

    end

    figure;
    subplot(211),  plot(t, phase); grid on;
    subplot(212),  plot(t, wave);  grid on; hold on
                   plot(t,sin(foutd*2*pi*t), 'r-.');
end
