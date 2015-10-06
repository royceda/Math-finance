
//Exercice 1
n = 1000;
xx = rand(n,1);
histplot(n, xx, style=8);

//Exercice 2

deff('[p]=myexp(n, a)', 'p=-1/a*log(rand(n,1))');
histplot(1000, myexp(1000,2), style=4);
