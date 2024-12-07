freq = 100;
multiplier = 50;
cycles = 30;
amplitude = 1.6;
offset = 3;

Fs = freq*multiplier;
t = 0:1:multiplier*cycles;

signal = amplitude*sin(freq*2*pi*t/Fs + pi/3) + offset;
subplot(3,2,1);
plot(signal);
title('signal');

sine_table = sin(freq*2*pi*t/Fs);
cos_table = cos(freq*2*pi*t/Fs);

subplot(3,2,3);
plot(sine_table);
subplot(3,2,4);
plot(cos_table);


mix1 = signal.*sine_table;
mix2 = signal.*cos_table;

[b,a] = butter(2, 0.001);

filt1 = filter(b,a,mix1);
filt2 = filter(b,a,mix2);

subplot(3,2,5);
plot(mix1);
hold on
plot(filt1);

subplot(3,2,6);
plot(mix2);
hold on
plot(filt2);

mag = 2*sqrt(filt1(1, end-100:end).^2 + filt2(1, end-100:end).^2);
subplot(3,2,2);
plot(mag);
ylim([0,amplitude+2]);

mean(mag)
rms(mag)
