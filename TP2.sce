//Exercice 1

n = 10;
p0 = 1/2;
p1 = 1/2; 

D = grand(1,1,'bin',n, p0);
G = grand(1,1,'bin',n,p1)

P = D-G;
Pa = D+G

function [P]=A(n)
    D = grand(1,1,'bin',n, 0.5);
    G = grand(1,1,'bin',n,0.5);
    P = 2*D-1;
endfunction



function [p] = B(n)
    p(1) = 0;
    for i=2:n
        p(i) = p(i-1) + A(1)
    end
endfunction

clf();
x=[0:10000]
plot(x, B(10001))
legend(["Marche aleatoire n = 10 000"])


function [p]=brown(k,n)
    V = B(k);
    for i=1:n  
        p(i) = V(i)/sqrt(n);
    end
endfunction

 brown(100000,100)

clf();
x=[0:1000]
plot(x, brown(100000,1001))



//Exercice 2

n = 10 000

function [p] = BS(u, o)
    t = [0, 0.01, 1];
    k = 10000;
    N = 14;
    for i in 1:lenght(t)
        exp(u*t - o**2/2*t + o*brown(k, N))
    end
endfunction


function [p] = simuBS()
    mhu = [0, 0.01, 0.05, 0.1, 0.2, 0.5];
    for i in 1:6
        u = mhu(i);
        exp(mhu*t)
    end
    
endfunction

//Cas 1


rho = 0.1;
mhu = 0.0;







//Cas 2
