% generates the piano sound envelope based on middle C
[middleC, Fs] = readMiddleC;
middleC = middleC(1:floor(2*length(middleC)/3),:);
subplot(2,1,1);

% for frquency analysis
%m = floor(2*length(middleC)/3);       % original sample length
%n = pow2(nextpow2(m));  % transform length
%y = fft(middleC(1:m,:),n);
%f = (0:n-1)*(Fs/n);
%power = abs(y).^2/n;
%plot(f(1:floor(n/2)),power(1:floor(n/2)))
plot(middleC(:,1));

middleC = middleC';

[up1,lo1] = envelope(middleC(1,:), 2000, 'rms');
[up2,lo2] = envelope(middleC(2,:), 150, 'peak');
% total samples taken from envelope
fullLength = 0:1/length(middleC):1-1/length(middleC);

subplot(2,1,1)
%plot(fullLength, up1, fullLength, lo1)
% taken from https://www.mathworks.com/matlabcentral/answers/48717-create-a-piece-of-music-using-matlab#answer_59582
notename = {'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#'};
song = [262, 262, 392, 392, 440, 440, 392, 349, 349, 329, 329, 293, 293, 262];
for k1 = 1:length(song)
    songidx(k1) = song(k1);
end

% interpolates the function down so it fits in our duration
duration = 0.7;
t = 0:(1/duration)/Fs:1;

env1Hi = interp1(fullLength, up1, t);
env1Lo = interp1(fullLength, lo1, t);
env2Hi = interp1(fullLength, up2, t);
env2Lo = interp1(fullLength, lo2, t);


scale1Hi = 1/max(env1Hi);
scale1Lo = 1/min(env1Lo);
scale2Hi = 1/max(env2Hi);
scale2Lo = 1/min(env2Lo);

%env1Hi = env1Hi * scale1Hi;
%env1Lo = env1Lo * scale1Lo;
%env2Hi = env2Hi * scale2Hi;
%env2Lo = env2Lo * scale2Lo;

% so fft because the last two numbers are NaN
env1Hi(length(env1Hi)) = 0;
env1Hi(length(env1Hi) - 1) = 0;
env2Hi(length(env2Hi)) = 0;
env2Hi(length(env2Hi) - 1) = 0;
env1Lo(length(env1Lo)) = 0;
env1Lo(length(env1Lo) - 1) = 0;
env2Lo(length(env2Lo)) = 0;
env2Lo(length(env2Lo) - 1) = 0;

% make both channels of the note
note1 = makenote(1, Fs, duration, env1Hi, env1Lo);
note2 = makenote(1, Fs, duration, env2Hi, env2Lo);
note = [note1; note2];

% for frequency analysis
note = note';
noteLength = 0:1/length(note):1-1/length(note);
subplot(2,1,2)
%m = floor(length(note)/3);       % original sample length
%n = pow2(nextpow2(m));  % transform length
%y = fft(note(1:m,:),n);
%f = (0:n-1)*(Fs/n);
%power = abs(y).^2/n;  
%plot(f(1:floor(n/2)),power(1:floor(n/2)))
%plot(note);
%subplot(3,1,2)
%plot(t, env, t, env1)

% for each note generate its sound
% taken from https://www.mathworks.com/matlabcentral/answers/48717-create-a-piece-of-music-using-matlab#answer_59582
songnote = [];
for k1 = 1:length(songidx)
    songnote = [songnote; [makenote(songidx(k1),Fs, duration, env1Hi, env1Lo)]'];
end
songLength = 0:1/length(songnote):1-1/length(songnote);
%subplot(3,1,3)
plot(songLength, songnote)
audiowrite('peak1000.wav',songnote, Fs);