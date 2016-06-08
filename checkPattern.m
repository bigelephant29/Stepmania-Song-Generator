function [ validPattern ] = checkPattern( pattern )
    
    measures = size(pattern, 2);
    
    status = {0,0,0,0};
    
    for i=1:measures
        measureSize = size(pattern{i}, 2);
        for j=1:measureSize
            if pattern{i}{j} < 0 || pattern{i}{j} >= 10000
                % not in valid range
                validPattern = 0;
                return
            end
            bit = {pattern{i}{j} / 1000, mod(pattern{i}{j}, 1000) / 100, ...
                   mod(pattern{i}{j}, 100) / 10, mod(pattern{i}{j}, 10)};
            for k=1:4
                if status{k} == 2 && (bit{k} == 1 || bit{k} == 2)
                    % if last status is 2, then new bit must be 0 or 3
                    validPattern = 0;
                    return
                elseif status{k} ~= 2 && bit{k} == 3
                    % if last status is not 2, then new bit must not be 3
                    validPattern = 0;
                    return
                end
                if bit{k} ~= 0
                    % if new bit is not 0, then update bit status
                    status{k} = bit{k};
                end
            end
        end
    end
    
    validPattern = 1;
    
end

