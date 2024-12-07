fs = 120;
freq = 20;
mix_freq = 19;
cutoff = 0.0001;
index = 98000;

[b, a] = coeff_short(cutoff, fs);

t = 0:1:100000;
inputSig = 0.5.*(sin(2*pi*freq.*t./fs + pi*rand(1,1))) + 1.1;
% plot(inputSig(1:1000))
sin_mix = 2.*sin(2*pi*mix_freq.*t./fs);
cos_mix = 2.*cos(2*pi*mix_freq.*t./fs);

mix1 = inputSig .* sin_mix;

mix2 = inputSig .* cos_mix;

filt1 = filter(b,a, mix1);
filt2 = filter(b,a, mix2);

ff1 = filter(b,a, filt1);
ff2 = filter(b,a, filt2);

ff1 = filter(b,a, ff1);
ff2 = filter(b,a, ff2);

mag1 = sqrt(filt1.^2 + filt2.^2);
avg1 = mean(mag1(index:end))

mag2 = sqrt(ff1.^2 + ff2.^2);
avg2 = mean(mag2(index:end))