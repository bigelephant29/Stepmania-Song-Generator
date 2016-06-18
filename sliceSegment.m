function segment = sliceSegment (au)
    cBeat = au.cBeat;
    fs = au.fs;
    segment = cell(1, floor(length(cBeat) / 4));
    lbeat = cBeat(1);
    for i = 1:floor(length(cBeat) / 4)
        en = int32(cBeat(i*4) * fs);
        if (en > length(au.signal))
            en = length(au.signal);
        end
        segment{i} = num2cell( au.signal(lbeat : en) );
        lbeat = en;
    end
end