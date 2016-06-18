function bpm = genBpm (cBeat)
%{
    cBeat = the cbeat return from beat track

    bpm = array of bpm of every beat
%}
    bpm = num2cell( zeros(1, length(cBeat)));
    for i = 2:length(cBeat)
        bpm{i} = 60. / (cBeat(i) - cBeat(i - 1));
    end
    bpm{1} = bpm{2};
end