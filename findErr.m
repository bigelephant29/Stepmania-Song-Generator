function err = findErr (seg, data)
%{
    err = error;
    seg = the length we are interesting in.
    data = marray of point.
    
    we want to see the error of using the length of seg to represent the
    data points.
%}
    err = 0;
    for i = 1:length(data)
        err = err + (int32(data(i)/seg) - data(i)/seg)^2;
    end
end