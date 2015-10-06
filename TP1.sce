//Exercice 1
rand('seed',0)
test = rand

class = 50;

n = 1000;
xx = rand(n,1);
clf();
//red
histplot(class, xx, style=6);
legend(["1000"])

n = 10000;
yy = rand(n,1);
//green
histplot(class, yy, style=5);
legend(["10000"])

n = 100000;
zz = rand(n,1);
//grey
histplot(class, zz, style=3);
legend(["100000"])

n = 1000000;
aa = rand(n,1);
//blue
histplot(class, aa, style=2);
legend(["1000000"])


//Exercice 2

deff('[p]=myexp(n, a)', 'p=-1/a*log(rand(n,1))');
clf();
n=1000000;
histplot(1000, myexp(n,2), style=2);
x=[0:0.1:4]
plot2d(x,2*exp(-2*x), style=5);
legend(["n = 1000000, class = 1000"])


//Exercice 3

x1=[0,1,2,3,4,5,6,7,8];
p1=[1/9, 1/9, 1/9, 1/9, 1/9, 1/9, 1/9, 1/9, 1/9, 1/9]

//
// simule une variable aléatoire discrète
// d’ensemble de valeurs possibles x_1,....,x_d
// avec probabilités respectives p_1,...,p_d
// x=( x_1,....,x_d), p=(p_1,...,p_d)
//
function [y] = discrete(x,p)
    if sum(p) ~= 1 then
        error('problem');
    end
    rand('uniform');
    d = length(p);
    pp = [0 p(1:(d-1))];
    cpp = cumsum(pp);
    cp = cumsum(p);
    U = rand(1,1);
    k = find((cpp <= U) & (U<cp));
    y = x(k);
endfunction



x = [0,1,2,3,4];
p = [1/5, 1/5, 1/5, 1/5, 1/5];
a = discr1(x,p);


function [y] = simudsc(n, x, p)
    if sum(p) ~= 1 then
        error('problem');
    end
    for j = 1:n
        y(j) = discrete(x,p); 
    end 
endfunction

v1 = [-3,-1.5,0,2,2.5];
p1 = [0.2,0.2,0.2,0.2,0.2];

n = 1000;
yy = simudsc(n,v1,p1)
clf();
histplot(n, yy, style=5);
legend(["simudsc"])
