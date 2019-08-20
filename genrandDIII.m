num=100;
H=cell(num,1);
W=cell(num,1);
Heff=cell(num,1);
for i=1:num
    [hh,ww]=hwgDIII(80,4,.1);  
    H{i}=hh;
    W{i}=ww;
    Heff{i}=heff(hh,ww);
end