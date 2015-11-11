//Exercie 1

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

P = Put(1000, 0, 100,1000, 0.005, 0.1)


//Exercice 2


function [p] = g(X, x, t, T, K, r, sigma)
    p = K*exp(-r*(T-t)) - x*exp(sigma*sqrt(T-t)*X - sigma**2*(T-t)/2);
endfunction


g(13, 1000, 0, 100, 1000, 0.005, 0.1);

function [p] = Put_MC(x, t, T, K, r, sigma, n)
    X = grand(1,1,'nor',0,1);
    tmp(1) = g(X, x, t, T, K, r, sigma)/n;
    for i= 2:n 
        tmp(i) = tmp(i-1) + g(X, x, t, T, K, r, sigma)/n;
    end
    p = tmp(n)
endfunction


test_mc = Put_MC(1000, 0, 100, 1000, 0.05, 0.1, 100)

y = [10:100:10000]

function [p] = testMC(y, x, t, T, K, r, sigma)
    for i = 1:length(y)
        p(i) = Put_MC(x, t, T, K, r, sigma, y(i));
    end
endfunction


test = testMC(y, 1000, 0, 100, 1000, 0.05, 0.1)
plot2d(y, testMC(y, 1000, 0, 100, 1000, 0.05, 0.1), logflag = 'ln', style=5)



//Variable de controle





