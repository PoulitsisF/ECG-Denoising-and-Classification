% Scalogram Creation
signallength = 500;

% Defining Filters for CWT with amor wavelet and 12 filters per octave
fb = cwtfilterbank('SignalLength',signallength,'Wavelet','amor','VoicesPerOctave',12);

% ECG 1-D Signal to Image Conversion
ecg2cwtscg_final(ecgsig,fb);

function ecg2cwtscg_final(ecgdata,cwtfb)
nol = 500; % Signal Length
colormap = jet(128);
folderpath = strcat('C:\Program Files\MATLAB\R2023b\bin\AD8232\ECG_file\');    % ECG file Folder
  ecgsignal = ecgdata(1:nol);
  cfs = abs(cwtfb.wt(ecgsignal));
  im = ind2rgb(im2uint8(rescale(cfs)),colormap);
  filenameindex = 'ECG_Scalogram';
  filename = strcat(folderpath,sprintf('%s.jpg',filenameindex));
  imwrite(imresize(im,[227 227]),filename);
end
