function re=bare_eig(H)
eiv=eigs(H,6,'sm');

eiv=eiv(eiv>0);
eiv=sort(eiv);
re=eiv(2)/eiv(1);

