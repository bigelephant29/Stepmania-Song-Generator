function segment = sliceSegment (au)
    cBeat = au.cBeat;
    fs = au.fs;
    segment = cell(1, floor(length(cBeat) / 4));
    lbeat = int32(cBeat(1) * fs);
    for i = 1:floor(length(cBeat) / 4)
        if (i*4+1 > length(cBeat))
            en = int32(cBeat(i*4) * fs);
        else
            en = int32(cBeat(i*4+1) * fs) - 1;
        end
        if (en > length(au.signal))
            en = length(au.signal);
        end
        segment{i} = au.signal(lbeat : en);
        lbeat = en + 1;
    end
end