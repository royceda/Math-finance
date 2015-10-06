
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

