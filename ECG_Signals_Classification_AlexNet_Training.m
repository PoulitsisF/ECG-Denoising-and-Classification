%  Program to create CWT Image database from ECG Signals

load('ECGData.mat'); % Loading ECG database
data = ECGData.Data; % Getting Database
labels = ECGData.Labels; % Getting Labels

ARR = data(1:30,:); % Taking First 30 Recordings
CHF = data(97:126,:);
NSR = data(127:156,:); 

signallength = 500;

% Defining Filters for CWT with amor wavelet and 12 filters per octave
fb = cwtfilterbank('SignalLength',signallength,'Wavelet','amor','VoicesPerOctave',12);

% Making Folders
mkdir('ecgdataset'); % Main Folder
mkdir('ecgdataset\arr'); % Sub-folders
mkdir('ecgdataset\chf');
mkdir('ecgdataset\nsr');

ecgtype = {'ARR', 'CHF', 'NSR'};
 

% ECG 1-D Signal to Image Conversion
ecg2cwtscg(ARR,fb,ecgtype{1});
ecg2cwtscg(CHF,fb,ecgtype{2});
ecg2cwtscg(NSR,fb,ecgtype{3});
