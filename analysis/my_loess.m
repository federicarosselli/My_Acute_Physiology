%simulate loess function
function y = my_loess(x,n)
    
    l = length(x);
    y = zeros(l,1);
    
    for i = 1:n
        y(i) = x(i);
        y(end - i + 1) = x(end - i + 1); 
    end;
    
    for i = n + 1: l - n
        y(i) = mean(x(i - n:i + n));
    
    end
    




end