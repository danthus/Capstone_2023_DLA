function [b, a] = coeff_double(cutoff, fs)
%COEFF Summary of this function goes here
%   Detailed explanation goes here

ff = cutoff;
% ff = single(0.0004);
ita = 1.0/tan(pi*ff);
q = sqrt(2);
b0 = 1.0 / (1.0 + q*ita + ita*ita) ;
b1= 2*b0;
b2 = b0;

a0 = 1.0;
a1 = 2.0 * (ita*ita - 1.0) * b0;
a2 = -(1.0 - q*ita + ita*ita) * b0;

b = [b0, b1, b2];
a = [a0, -a1, -a2];

end

