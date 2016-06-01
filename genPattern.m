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
function pattern = genPattern (segment, bpm)
    % don't change these variable !!
    LEFT = 1000; UP = 100; DOWN = 10; RIGHT = 1;
    %============================
    
    for i = 1:length(segment)
        pattern{i} = [UP, DOWN, LEFT, RIGHT];
    end
end