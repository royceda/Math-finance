//Rappel
function [p] = d1(x,t,K,T,r,sigma)
    a = log(x/K)+(r+sigma**2/2)*(T-t)
    p = a /(sigma*sqrt(T-t))
endfunction

test = d1(10,100,100,30,0.05,0.1)

function [p] = d2(x,t,K,T,r,sigma)
    p =  d1(x,t,K,T,r,sigma) - sigma*sqrt(T-t)
endfunction

test = d2(10,100,100,30,0.05,0.1)

function [p] = Call(x, t, T, K, r, sigma)
    first = x*cdfnor("PQ",d1(x,t,K,T,r,sigma),0,1);
    second = K*exp(-r*(T-t))*cdfnor("PQ",d2(x,t,K,T,r,sigma),0,1);
    p = first - second;
endfunction


function [p] = Put(x, t, T, K, r, sigma)
    first = x*cdfnor("PQ",-d1(x,t,K,T,r,sigma),0,1);
    second = K*exp(-r*(T-t))*cdfnor("PQ",-d2(x,t,K,T,r,sigma),0,1);
    p = -first + second;
endfunction

//_______________________________________________________

x = 1000;
T = 100;
K = 1000;
r = 0.005;
sigma = 0.1;
t=0;

n = 1000;
X = grand(n,1,'nor',0,1);

//For a Call
function [p] = gc(X, x, t, T, K, r, sigma)
    first = K*exp(-r*(T-t));
    second = x*exp(sigma*X*sqrt(T-t)) *exp(-((T-t)*sigma**2)/2)
    p = max(0, -first + second);
endfunction


test = g(X(1), x, t, T, K, r, sigma);

//evaluation of Call with Monte Carlo method
function [p] = eval_Call(X, x, t, T, K, r, sigma, n)
    tmp = 0;
    for i = 1:n
        tmp = tmp + gc(X(i), x, t, T, K, r, sigma)/n;
    end
    p = tmp
endfunction


function [p]= error_Rate(X, x, t, T, K, r, sigma, n)
    tmp = 0;
    I = eval_Call(X, x, t, T, K, r, sigma, n);
    for i = 1:n
        tmp = tmp + (gc(X(i), x, t, T, K, r) - I)**2/(n-1);
    end
    p = tmp;
endfunction


function [p] = boundary(X, x, t, T, K, r, sigma, n)
        I = eval_Call(X, x, t, T, K, r, sigma, n);
        A = error_Rate(X, x, t, T, K, r, sigma, n)
        
        p = [I - 1.96*sqrt(A/n), I + 1.96*sqrt(A/n)];
endfunction

function [p] = test1(X, x, t, T, K, r, sigma, y)
    for i = 1:length(y)
        a(i) = eval_Call(X, x, t, T, K, r, sigma, y(i));
    end
    p = [a];
endfunction


function [p] = test2(X, x, t, T, K, r, sigma, y)
    for i = 1:length(y)
        b(i) = Call(x, t, T, K, r, sigma);
    end
    p = [b];
endfunction


function [p] = test3(X, x, t, T, K, r, sigma, y,n)
    b = boundary(X, x, t, T, K, r, sigma, n)
    for i = 1:length(y)
        c(i) = b(1);
    end
    p = [c];
endfunction


function [p] = test4(X, x, t, T, K, r, sigma, y, n)
    b = boundary(X, x, t, T, K, r, sigma, n)
    for i = 1:length(y)
        c(i) = b(2);
    end
    p = [c];
endfunction


n = 10000
y = [10:100:n];
X = grand(n,1,'nor',0,1);
//clf();
//plot2d(y, test1(X, x, t, T, K, r, sigma, y), logflag = 'ln', style=5);
//plot2d(y, test2(X, x, t, T, K, r, sigma, y), logflag = 'ln', style=4);
//plot2d(y, test3(X, x, t, T, K, r, sigma, y, n), logflag = 'ln', style=2);
//plot2d(y, test4(X, x, t, T, K, r, sigma, y, n), logflag = 'ln', style=2);
//legend(["Call par Monte Carlo";"Call exacte";"inte"])



