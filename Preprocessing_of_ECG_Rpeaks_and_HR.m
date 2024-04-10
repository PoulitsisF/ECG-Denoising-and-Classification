% Program to get QRS Peaks and Heart Rate from ECG Signal
clc 
clear all

%load file
[filename,pathname] = uigetfile('*.*','Select the ECG Signal');
filewithpath = strcat(pathname,filename);
Fs = input('Enter Sample Rate (Hz): '); %sample rate of AD8232 is ...    (MIT-BIH Dataset 360 Hz)

ecg = load(filename); % Reading ECG Signal
ecgsig = (ecg.val)./200; % Normalize Gain
t = 1:length(ecgsig); % No. of samples
ts = t./Fs; % Getting Time Vector
timelimit = length(ecgsig)/Fs;

wt = modwt(ecgsig,4,'sym4'); % 4-level undecimated DWT using sym4
wtrec = zeros(size(wt));
wtrec(3:4,:) = wt(3:4,:); % Extracting only d3 and d4 coefficients
y = imodwt(wtrec,'sym4'); %,'sym4' IDWT with only d3 and d4

% Displaying Noisy and Denoised ECG Signals 

subplot(211)
plot(ts,ecgsig);
xlim([0,timelimit]);
grid on;
xlabel('Seconds')
ylabel('Amplitude')
title('Noisy ECG Signal')

subplot(212)
plot(ts,y);
xlim([0,timelimit]);
grid on;
xlabel('Seconds')
ylabel('Amplitude')
title('Denoised ECG Signal')

% Finding R-Peaks and Heart Rate

ms = abs(y).^2; % Magnitude square
avg = mean(ms); % Getting Average of y^2 as threshold

[Rpeaks,locs] = findpeaks(ms,t,'MinPeakHeight',8*avg,'MinPeakDistance',50);

nohb = length(locs); % No. of heart beats
hbpermin = (nohb*60)/timelimit; % Getting Beats per Minute (Heart Rate)
disp(strcat('Heart Rate= ',num2str(hbpermin))) % Display of Heart Rate

% Displaying Detected R-Peaks

figure;
plot(t,ms)
grid on;
xlim([0,length(ecgsig)]);
hold on
plot(locs,Rpeaks,'ro')
xlabel('Samples')
ylabel('Amplitude')
title(strcat('Location of R-Peaks, Heart Rate: ',num2str(hbpermin)))

