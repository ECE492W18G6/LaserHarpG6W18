% generates the piano sound envelope based on middle C
[middleC, Fs] = readMiddleC;
middleC = middleC';
[up,lo] = envelope(middleC(1,:), 1000, 'rms');
% total samples taken from envelope
fullLength = 0:1/length(middleC):1-1/length(middleC);
subplot(3,1,1)
plot(fullLength, up, fullLength, lo)
% taken from https://www.mathworks.com/matlabcentral/answers/48717-create-a-piece-of-music-using-matlab#answer_59582
notename = {'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#'};
song = {'A' 'A' 'E' 'E' 'F#' 'F#' 'E' 'D' 'D' 'C#' 'C#' 'B' 'B' 'A'};
for k1 = 1:length(song)
    idx = strcmp(song(k1), notename);
    songidx(k1) = find(idx);
end

% interpolates the function down so it fits in our duration
duration = 1;
t = 0:(1/duration)/Fs:1;
env = interp1(fullLength, up, t);

env1 = interp1(fullLength, lo, t);
subplot(3,1,2)
plot(t, env, t, env1)

% for each note generate its sound
% taken from https://www.mathworks.com/matlabcentral/answers/48717-create-a-piece-of-music-using-matlab#answer_59582
songnote = [];
for k1 = 1:length(songidx)
    songnote = [songnote; [makenote(songidx(k1),Fs, duration, env)  zeros(1,75)]'];
end
songLength = 0:1/length(songnote):1-1/length(songnote);
subplot(3,1,3)
plot(songLength, songnote)
audiowrite('peak1000.wav',songnote, Fs);