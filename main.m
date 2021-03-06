function [ ] = main( filepath )
    
    inputMP3 = myAudioRead (filepath);
    
    [cBeat, au, ~, ~] = beatTrack(inputMP3);
    
    bpm = genBpm (cBeat);
    
    [segment, offset] = sliceSegment(au);
    pattern = genPattern (au, segment);
    
    
    % gen pattern
    
    % pattern visualization
    
    % gen .sm file
    genSMFile('test.sm', filepath, bpm, 6, pattern, offset, 0, 10);

end

