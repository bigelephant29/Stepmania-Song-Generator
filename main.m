function [ ] = main( filepath )
    
    inputMP3 = myAudioRead (filepath);
    
    [cBeat, au, bpm, beatPos] = beatTrack(inputMP3);
    
    au.segment = sliceSegment(au);
    
    % gen pattern
    
    % pattern visualization
    
    % gen .sm file

end

