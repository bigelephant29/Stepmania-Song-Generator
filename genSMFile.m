function [] = genSMFile( smFileName, targetMP3, bpms, difficulty, pattern, offset, sampleStart, sampleLength )
    
    % configuration
    PROJECTNAME='Stepmania-Song-Generator';
    if isinteger(difficulty) ~= 0 || difficulty <= 0
        difficulty = 5; % set default value to 5
    end
    
    % open target .sm file
    fileID = fopen(smFileName, 'w');
    if fileID == -1
        % File cannot be opened
        return
    end
    
    validPattern = checkPattern(pattern);
    
    if validPattern == 0
        return
    end
    
    pattern = optimizePattern(pattern);
    
    % open source .mp3 file
    mp3Info = audioinfo(targetMP3);
    [~, mp3Filename, mp3Ext] = fileparts(mp3Info.Filename);
    if strcmp(mp3Ext,'.mp3') == 0
        % mp3 file extension error
        return
    end
    
    % #TITLE:
    if size(mp3Info.Title) ~= 0
        fprintf(fileID, '#TITLE:%s;\n', mp3Info.Title);
    else
        fprintf(fileID, '#TITLE:%s;\n', mp3Filename);
    end
    
    % #SUBTITLE:
    
    % #ARTIST:
    fprintf(fileID, '#ARTIST:%s;\n', mp3Info.Artist);
    
    % #CREDIT:
    fprintf(fileID, '#CREDIT:%s;\n', PROJECTNAME);
    
    % #MUSIC:
    fprintf(fileID, '#MUSIC:%s;\n', targetMP3);
    
    % #SELECTABLE:
    fprintf(fileID, '#SELECTABLE:YES;\n');
    
    % #BACKGROUND:
    % #BANNER:
    % #CDTITLE:
    
    % #DISPLAYBPM:
    fprintf(fileID, '#DISPLAYBPM:%.3f:%.3f;\n', min(cell2mat(bpms)), max(cell2mat(bpms)));
    
    % #OFFSET:
    fprintf(fileID, '#OFFSET:%.3f;\n', offset);
    
    % #SAMPLESTART:
    fprintf(fileID, '#SAMPLESTART:%.3f;\n', sampleStart);
    
    % #SAMPLELENGTH:
    fprintf(fileID, '#SAMPLELENGTH:%.3f;\n', sampleLength);
    
    % #BPMS:
    fprintf(fileID, '#BPMS:');
    for i = 1 : length(bpms)
        if i > 1
            fprintf(fileID, ',');
        end
        fprintf(fileID, '%d=%.3f', i-1, bpms{i});
    end
    fprintf(fileID, ';\n');
    
    % #STOPS:
    
    % separate line
    fprintf(fileID, '//---------------dance-single - ----------------\n');
    
    % #NOTES:
    fprintf(fileID, '#NOTES:\n');
    
    fprintf(fileID, '     dance-single:\n');
    fprintf(fileID, '     %s:\n', PROJECTNAME);
    fprintf(fileID, '     Edit:\n');
    fprintf(fileID, '     %d:\n', difficulty);
    fprintf(fileID, '     0.000,0.000,0.000,0.000,0.000:\n');
    
    % notes
    measures = size(pattern, 2);
    for i=1:measures
        measureSize = size(pattern{i}, 2);
        for j=1:measureSize
            fprintf(fileID, '%04d\n', pattern{i}{j});
        end
        if i ~= measures
            fprintf(fileID, ',\n');
        else
            fprintf(fileID, ';');
        end
    end
    
end

