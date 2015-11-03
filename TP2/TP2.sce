//Exercice 1

n = 10;
p0 = 1/2;
p1 = 1/2; 

D = grand(1,1,'bin',n, p0);
G = grand(1,1,'bin',n,p1)

P = D-G;
Pa = D+G

function [P]=Pos(n)
    D = grand(1,1,'bin',n, 0.5);
    P = 2*D-1;
endfunction



function [p] = RandWalk(n)
    p(1) = 0;
    for i=2:n
        p(i) = p(i-1) + Pos(1)
    end
endfunction

clf();
x=[0:100]
    plot(x, RandWalk(101), 'r-');
    plot(x, RandWalk(101), 'b-');
    plot(x, RandWalk(101), 'k-');
    plot(x, RandWalk(101), 'm-');
    plot(x, RandWalk(101), 'g-');
legend(["Marches aleatoires n = 100"])


function [p]=brown(k,n)
    V = RandWalk(k);
    for i=1:n  
        p(i) = V(i)/sqrt(n);
    end
endfunction

 B = brown(100000,100)

//clf();
//x=[0:100]
//plot(x, brown(100001,101),'m-')
//legend(["100"])

//clf();
//x=[0:1000]
//plot(x, brown(100001,1001),'m-')
//legend(["1000"])

//clf();
//x=[0:10000]
//plot(x, brown(100001,10001),'m-')
//legend(["10 000"])


//clf();
//x=[0:100000]
//plot(x, brown(100001,100001),'m-')
//legend(["100 000"])



//Exercice 2


function [p] = BS(sigma, mu, b)
    t = [0: 0.001: 1];
    for i=1:length(t)
        p(i) = exp(mu*t(i) - rho**2*t(i)/2 + sigma*b(i));
    end
endfunction


function [p] = simuBS()
    k = 10000;
    N = 10000;
    b = brown(k, N);
    rho = 0.1;
    mu = [0, 0.01, 0.05, 0.1, 0.2, 0.5];
    for i =1:6
        p(i) = BS(rho, mu(i), b(i));
    end
    
endfunction

//Cas 1

k = 10000;
N = 10000;
b = brown(k, N);
sigma = 0.1;
mu = [0, 0.01, 0.05, 0.1, 0.2, 0.5]


//Variation de la dérive
//clf();
//x= [0: 0.001: 1];
//plot(x, BS(0.1, 0, b),'c-')
//plot(x, BS(0.1, 0.01, b),'g-')
//plot(x, BS(0.1, 0.05, b),'b-')
//plot(x, BS(0.1, 0.1, b),'r-')
//plot(x, BS(0.1, 0.2, b),'k-')
//plot(x, BS(0.1, 0.5, b),'m-')
//legend(["0%"; "1%"; "5%";"10%"; "20%"; "50%"]);





//Variation de la volatilité
//clf();
//x= [0: 0.001: 1];
//plot(x, BS(0.01, 0.2, b),'c-')
//plot(x, BS(0.02, 0.2, b),'g-')
//plot(x, BS(0.05, 0.2, b),'b-')
//plot(x, BS(0.1 ,0.2, b),'r-')
//plot(x, BS(0.15, 0.2, b),'k-')
//plot(x, BS(0.2, 0.2, b),'m-')
//legend(["1%"; "2%"; "5%";"10%"; "15%"; "20%"]);




//Exercice 4

//Call
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


//Strike price
clf();
x= [0.01: 0.001: 100];
function [p] = test1(x)
    for i = 1:length(x)
        p(i) = Call(x(i),10,30,100,0.05,0.1);
    end 
endfunction

plot(x, test1(x),'m-')


//Temps avant echeance
x= [0:0.1:29.99];
function [p] = test2(x)
    for i = 1:length(x)
        p(i) = Call(100, x(i),30,100,0.05,0.1);
    end 
endfunction

//plot(x, test2(x),'m-')


//taux interet
x= [0:0.0001:0.2];
function [p] = test3(x)
    for i = 1:length(x)
        p(i) = Call(100, 10,30,100,x(i),0.1);
    end 
endfunction

//plot(x, test3(x),'m-')


//volatilité
x= [0.01:0.0001:0.25];
function [p] = test4(x)
    for i = 1:length(x);
        p(i) = Call(100,10,30,100,0.05,x(i));
    end 
endfunction

//plot(x, test4(x),'m-')





//Put

function [p] = Put(x, t, T, K, r, sigma)
    first = x*cdfnor("PQ",-d1(x,t,K,T,r,sigma),0,1);
    second = K*exp(-r*(T-t))*cdfnor("PQ",-d2(x,t,K,T,r,sigma),0,1);
    p = -first + second;
endfunction




//clf();
x= [0.01: 0.001: 100];
function [p] = test1(x)
    for i = 1:length(x)
        p(i) = Put(x(i),10,30,100,0.05,0.1);
    end 
endfunction


//plot(x, test1(x),'m-')



x= [0:0.01:29.999];
function [p] = test2(x)
    for i = 1:length(x)
        p(i) = Put(100, x(i),30,100,0.05,0.1);
    end 
endfunction

//plot(x, test2(x),'m-')




x= [0:0.0001:0.2];
function [p] = test3(x)
    for i = 1:length(x)
        p(i) = Put(100, 10,30,100,x(i),0.1);
    end 
endfunction

//plot(x, test3(x),'m-')



x= [0.1:0.001:0.9];
function [p] = test4(x)
    for i = 1:length(x)
        p(i) = Put(100, 10,30,100,0.05,x(i));
    end 
endfunction

//plot(x, test4(x),'r-')




