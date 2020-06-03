function [s]=similarity(I,A,T)
s=(2*I.*A+T)./(I.^2+A.^2+T);