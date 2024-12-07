% Simulation parameters
samplingFreq = 100000; % Sampling rate in Hz
duration = 1; % Duration of the signal in seconds
frequency = 100;
amplitude = 2.0;
dc_offset = 2.0;

t = linspace(0, duration, duration * samplingFreq);

% signal wave
signal_wave = amplitude * sin(2 * pi * frequency * t) + dc_offset;

% reference wave
reference_wave = sin(2 * pi * frequency * t);

% Mixing
mixed_wave = signal_wave .* reference_wave;

% Low-pass filtering
% compute filter coefficients
fc = 10; % Cutoff frequency of the filter in Hz
wc = 2 * pi * fc;
filter_order = 2; % Order of the filter
a = zeros(1, filter_order+1);
b = zeros(1, filter_order+1);

gamma = pi / (2 * filter_order);
a(1) = 1;
for k = 1:(filter_order)
    rfac = cos(k * gamma) / sin((k + 1) * gamma);
    a(k + 1) = rfac * a(k);
end

den = zeros(1, filter_order+1);
for k = 1:(filter_order+1)
    den(filter_order+2 - k) = a(k) / wc^(k-1);
end

num = 1;
K = 2 * samplingFreq;

if filter_order == 1
    commonDen = den(1) * K + den(2);
    b(1) = num / commonDen;
    b(2) = num / commonDen;
    a(1) = -1;
    a(2) = -(-den(1) * K + den(2)) / commonDen;
                
elseif filter_order == 2
    commonDen = den(1) * K^2 + den(2) * K + den(3);
    b(1) = num / commonDen;
    b(2) = 2 * num / commonDen;
    b(3) = num / commonDen;
    a(1) = -1;
    a(2) = -(-2 * den(1) * K^2 + 2 * den(3)) / commonDen;
    a(3) = -(den(1) * K^2 - den(2) * K + den(3)) / commonDen;
end

% perform filtering
filtered_wave = 0 * t;
for i = (filter_order+1):(duration * samplingFreq)
    filtered_wave(i) = b(1)*mixed_wave(i);
    for j = 2:(filter_order+1)
        filtered_wave(i) = filtered_wave(i) + a(j)*filtered_wave(i-(j-1)) + b(j)*mixed_wave(i-(j-1));
    end
end

disp("Filter coefficients b_i: ");
disp(b);
disp("Filter coefficients a_i: ");
disp(a);

% Plots
figure;
subplot(4, 1, 1);
plot(t, signal_wave);
title('Signal Wave');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4, 1, 2);
plot(t, reference_wave);
title('Reference Wave');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4, 1, 3);
plot(t, mixed_wave);
title('Mixed Wave');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4, 1, 4);
plot(t, filtered_wave);
title('Filtered Wave');
xlabel('Time (s)');
ylabel('Amplitude');
