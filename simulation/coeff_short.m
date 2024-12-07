function [b, a] = coeff_short(cutoff, fs)
%COEFF Summary of this function goes here
%   Detailed explanation goes here

ff = single(cutoff);
% ff = single(0.0004);
ita = single(1.0/tan(pi*ff));
q = single(sqrt(2));
b0 = single(1.0 / (1.0 + q*ita + ita*ita)) ;
b1= single(2*b0);
b2 = single(b0);

a0 = single(1.0);
a1 = single(2.0 * (ita*ita - 1.0) * b0);
a2 = single(-(1.0 - q*ita + ita*ita) * b0);

b = [b0, b1, b2];
a = [a0, -a1, -a2];

end

