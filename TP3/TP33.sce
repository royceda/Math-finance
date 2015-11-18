//Exercice 3

t = 0;
x = 1000;
T = 100;
K = 1000;
r = 0.005;
sigma = 0.1;
n = 10000
y = [10:100:n];
X = grand(n,1,'nor',0,1);

//We use the previous Call compute with Monte Carlo
function [p] = eval_PutVC(X, x, t, T, K, r, sigma, n)
    I = x*(1-exp(-r*T));
    p = I - eval_Call(X, x, t, T, K, r, sigma, n)
endfunction


function [p]= error_Rate(X, x, t, T, K, r, sigma, n)
    tmp = 0;
    I = eval_PutVC(X, x, t, T, K, r, sigma, n);
    for i = 1:n
        tmp = tmp + (g(X(i), x, t, T, K, r) - I)**2/(n-1);
    end
    p = tmp;
endfunction


function [p] = boundary(X, x, t, T, K, r, sigma, n)
        I = eval_PutVC(X, x, t, T, K, r, sigma, n);
        A = error_Rate(X, x, t, T, K, r, sigma, n)
        
        p = [I - 1.96*sqrt(A/n), I + 1.96*sqrt(A/n)];
endfunction


function [p] = test1(X, x, t, T, K, r, sigma, y)
    for i = 1:length(y)
        a(i) = -eval_PutVC(X, x, t, T, K, r, sigma, y(i));
    end
    p = [a];
endfunction


function [p] = test2(X, x, t, T, K, r, sigma, y)
    for i = 1:length(y)
        b(i) = Put(x, t, T, K, r, sigma);
    end
    p = [b];
endfunction


function [p] = test3(X, x, t, T, K, r, sigma, y,n)
    b = boundary(X, x, t, T, K, r, sigma, n)
    for i = 1:length(y)
        c(i) = -b(1);
    end
    p = [c];
endfunction


function [p] = test4(X, x, t, T, K, r, sigma, y, n)
    b = boundary(X, x, t, T, K, r, sigma, n)
    for i = 1:length(y)
        c(i) = -b(2);
    end
    p = [c];
endfunction


n = 1000
y = [1:10:n];
X = grand(n,1,'nor',0,1);
clf();
plot2d(y, test1(X, x, t, T, K, r, sigma, y), logflag = 'ln', style=5);
plot2d(y, test2(X, x, t, T, K, r, sigma, y), logflag = 'ln', style=4);
plot2d(y, test3(X, x, t, T, K, r, sigma, y, n), logflag = 'ln', style=2);
plot2d(y, test4(X, x, t, T, K, r, sigma, y, n), logflag = 'ln', style=2);
legend(["Put par Monte Carlo";"Put exacte";"inte"])

