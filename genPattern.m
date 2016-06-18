function pattern = genPattern (au, segment)
%{
    pattern = genPattern (segment, bpm)
    segment, a vertor of wav, segmented by measure.
    bpm, beats per minute.
    pattern, a vertor of patterns, segmented by measure.

    note:
        ABCD = left, up, down, right
        0: no behavior
        1: normal beat
        2: hold head
        3: hold tail
    
%}
    % don't change these variable !!
    NODE = [1000, 100, 10, 1];
    %LEFT = 1000; UP = 100; DOWN = 10; RIGHT = 1;
    %============================
    fs = au.fs;
    tmpau.fs = fs;
    pattern = cell(1, length(segment));
    for i = 1:length(segment)
        tmpau.signal = segment{i};
        onset = wave2onset(tmpau, 0);
        minRa = 0;
        minErr = realmax('single');
        if ~isempty(onset)
            for j = 32:-1:3
                tmp = findErr (fs*4/j, onset);
                if (tmp < minErr)
                    minErr = tmp;
                    minRa = j;
                end
            end
        end
        point = int32(onset./ (fs*4/minRa));
        node = randi(4, 1, minRa);
        pattern{i} = num2cell( zeros(minRa) );
        for k = 1:length(point)
            if point(k) == 0
                continue
            end
            pattern{i}{point(k)} = NODE (node(k));
        end
    end
end