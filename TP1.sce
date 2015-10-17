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
clf();
histplot(class, yy, style=5);
legend(["10000"])

n = 100000;
zz = rand(n,1);
//grey
clf();
histplot(class, zz, style=3);
legend(["100000"])

n = 1000000;
aa = rand(n,1);
//blue
clf();
histplot(class, aa, style=2);
legend(["1000000"])


//Exercice 2

deff('[p]=myexp(n, a)', 'p=-1/a*log(rand(n,1))');
n=1000000;
x=[0:0.1:4];
clf();
histplot(1000, myexp(n,2), style=2);
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
a = discrete(x,p);


function [y] = simudsc(n, x, p)
    for j = 1:n
        y(j) = discrete(x,p); 
    end 
endfunction

v1 = [-3,-1.5,0,2,2.5];
p1 = [0.2,0.3,0.1,0.3,0.1];

n = 1000;
yy = simudsc(n,v1,p1);
//clf();
//histplot(100, yy, style=5);
//legend(["simudsc n=1000"])


//Exercice 4

a = 9;
b = 10;
r = rand(1,1)*(b-a)+a;

function [X] = BM(n)
    theta = rand(n,1)*2*%pi+0;
    R = myexp(n,1/2);
    
    for i = 1:n
        X(i) = cos(theta(i))*sqrt(R(i));
    end
    
endfunction

//clf();
n=100000;
//histplot(1000, BM(n), style=2);
//legend(['n=500000, class=1000'])

x=[-5:0.1:5]
//plot2d(x,1/(4*sqrt(2*%pi))*exp(-(x-3)**2/2*4**2), style=1)

//plot2d(x,1/(2*sqrt(2*%pi))*exp(-x**2/4), style=1)
//X = grand(n,1,'nor',3,4);
//histplot(1000, X, style=4);



//Exercice 5

function [vect]=rejet1()
    
        u = rand(1,1)*2-1;
        v = rand(1,1)*2-1;
        r = u**2 + v**2;
        if r>1 then
            vect = rejet1();
        end
        
        if r>1 then
            rejet1();
        else
            z = sqrt((-2*log(r))/r);
            x = u*z;
            y = v*z;
        
            X = x;
            Y = y;
            //print(%io(2),X,Y,r);
        
            vect(1) = X
            vect(2) = Y
            vect(3) = r
        end
endfunction


function [p]=rejet(n)
    for i=1:n
        V = rejet1();
        p(1)(i) = V(1);
        p(2)(i) = V(2);
    end
endfunction

n = 100000;
//histplot(1000, rejet(n), style=2);
//legend(['n=100000, class=1000'])

