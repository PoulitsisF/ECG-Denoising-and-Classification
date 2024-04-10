% Load the custom-trained AlexNet model
load('C:\Program Files\MATLAB\R2023b\bin\AD8232\trained_alexnet_model.mat', 'netTransfer'); % Load the pre-trained AlexNet model and the 'netTransfer' variable

% Load the scalogram image file selected by the user
[filename, filepath] = uigetfile('*.jpg;*.png;*.bmp', 'Select scalogram image file');
image_filepath = fullfile(filepath, filename);
ecg_image = imread(image_filepath);

% Perform classification using the pre-trained AlexNet model
predicted_label = classify(netTransfer, ecg_image);

% Display the result to the user
fprintf('The ECG signal belongs to class: %s\n', char(predicted_label));