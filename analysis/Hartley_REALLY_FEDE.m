function H=Hartley_REALLY_FEDE(kx,ky,L,W,PHASE)
H=zeros(L,W);
for l=1:L
    for m=1:W
H(l,m)=sin(2*pi*(kx*l+ky*m)/L+PHASE);
    end
end