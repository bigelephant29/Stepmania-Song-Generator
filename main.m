function [ ] = main( filepath )
    
    inputMP3 = myAudioRead (filepath);
    
    [cBeat, au, bpm, beatPos] = beatTrack(inputMP3);
    
    segment = sliceSegment(au);
    pattern = genPattern (au, segment);
    
    
    % gen pattern
    
    % pattern visualization
    
    % gen .sm file
    genSMFile('test.sm', filepath, bpm, 6, pattern, -cBeat(1), 0, 10);

end

