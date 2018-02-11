% generates the piano sound envelope based on middle C
[middleC, Fs] = readMiddleC;
subplot(2,1,1);
m = length(middleC);       % original sample length
n = pow2(nextpow2(m));  % transform length
y = fft(middleC,n);
f = (0:n-1)*(Fs/n);
power = abs(y).^2/n;      

%plot(f(1:floor(n/2)),power(1:floor(n/2)))
plot(middleC);

% DFT of signal
middleC = middleC';

[up1,lo1] = envelope(middleC(1,:), 150, 'peak');
[up2,lo2] = envelope(middleC(2,:), 150, 'peak');
% total samples taken from envelope

fullLength = 0:1/length(middleC):1-1/length(middleC);

%subplot(3,1,1)
%plot(fullLength, up2, fullLength, lo2)
% taken from https://www.mathworks.com/matlabcentral/answers/48717-create-a-piece-of-music-using-matlab#answer_59582
notename = {'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#'};
song = {'A' 'A' 'E' 'E' 'F#' 'F#' 'E' 'D' 'D' 'C#' 'C#' 'B' 'B' 'A'};
for k1 = 1:length(song)
    idx = strcmp(song(k1), notename);
    songidx(k1) = find(idx);
end

% interpolates the function down so it fits in our duration
duration = 4.7;
t = 0:(1/duration)/Fs:1;

env1Hi = interp1(fullLength, up1, t);
env1Lo = interp1(fullLength, lo1, t);
env2Hi = interp1(fullLength, up2, t);
env2Lo = interp1(fullLength, lo2, t);


scale1Hi = 1/max(env1Hi);
scale1Lo = 1/min(env1Lo);
scale2Hi = 1/max(env2Hi);
scale2Lo = 1/min(env2Lo);

env1Hi = env1Hi * scale1Hi;
env1Lo = env1Lo * scale1Lo;
env2Hi = env2Hi * scale2Hi;
env2Lo = env2Lo * scale2Lo;

note1 = makenote(1, Fs, duration, env1Hi, env1Lo);
note2 = makenote(1, Fs, duration, env2Hi, env2Lo);
note = [note1; note2];

note = note';
noteLength = 0:1/length(note):1-1/length(note);
subplot(2,1,2)
m = length(note);       % original sample length
n = pow2(nextpow2(m));  % transform length
%y = fft(note,n);
f = (0:n-1)*(Fs/n);
%power = abs(y).^2/n;  
%plot(f(1:floor(n/2)),power(1:floor(n/2)))
plot(note);
%subplot(3,1,2)
%plot(t, env, t, env1)

% for each note generate its sound
% taken from https://www.mathworks.com/matlabcentral/answers/48717-create-a-piece-of-music-using-matlab#answer_59582
songnote = [];
for k1 = 1:length(songidx)
    %songnote = [songnote; [makenote(songidx(k1),Fs, duration, env, env1)  zeros(1,75)]'];
end
songLength = 0:1/length(songnote):1-1/length(songnote);
%subplot(3,1,3)
%plot(songLength, songnote)
audiowrite('peak1000.wav',note, Fs);