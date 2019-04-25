function cond=G0(T,enlist,condlist)
% flist=exp(enlist/T)./((1+exp(enlist/T)).^2*T);
if T>1e-4
    flist=1./(4*cosh(enlist/(2*T)).^2*T);
    nor=real(ifft(fft(flist).*fft(ones(1,length(enlist)))));
    condlistc=real(fftshift(ifft(fft(flist).*fft(condlist))))./nor;
else
    condlistc=condlist;
end
cond=condlistc(ceil(length(condlistc)/2));
end
