function [ newPattern ] = optimizePattern( oldPattern )
    
    measures = size(oldPattern, 2);
    
    for i = 1:measures
        
        measureSize = size(oldPattern{i}, 2);
        % special case : all zero
        all_zero = 1;
        for j = 1 : measureSize
            if oldPattern{i}{j} ~= 0
                all_zero = 0;
                break
            end
        end
        
        if all_zero == 1
            newPattern{i} = {0};
            continue
        end
        
        match = 0;
        for k = 2 : measureSize
            if mod(measureSize, k) ~= 0
                continue
            end
            match = 1;
            for j = 1 : measureSize
                if mod(j, k) ~= 1 && oldPattern{i}{j} ~= 0
                    match = 0;
                    break
                end
            end
            if match == 1
                cnt = 1;
                for j = 1 : k : measureSize
                    newPattern{i}{cnt} = oldPattern{i}{j};
                    cnt = cnt+1;
                end
                break
            end
        end
        if match == 0
            newPattern{i} = oldPattern{i};
        end
    end
    
end

