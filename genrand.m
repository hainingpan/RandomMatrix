num=10;
H=cell(num,1);
W=cell(num,1);
Heff=cell(num,1);
for i=1:num
    [hh,ww]=hw(40,2);  
    H{i}=hh;
    W{i}=ww;
    Heff{i}=heff(hh,ww);
end