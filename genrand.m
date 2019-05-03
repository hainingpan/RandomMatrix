num=100;
H=cell(num,1);
W=cell(num,1);
Heff=cell(num,1);
for i=1:num
    [hh,ww]=hwg(40,4,.3);  
    H{i}=hh;
    W{i}=ww;
    Heff{i}=heff(hh,ww);
end