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
plot(x, brown(10000,1001))
