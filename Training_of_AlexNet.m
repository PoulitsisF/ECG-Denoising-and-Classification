%Training and Validation using AlexNet

DatasetPath = 'C:\Program Files\MATLAB\R2023b\bin\AD8232\ecgdataset';

% Reading Images from Image Database Folder
images = imageDatastore(DatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');

% Distributing Images in the set of Training and Testing 
numTrainFiles = 250;
[TrainImages,TestImages] = splitEachLabel(images,numTrainFiles,'randomize');

net = alexnet; % Importing pretrained AlexNet 
layersTransfer = net.Layers(1:end-3); % Preserving all layers except last three
numClasses = 3; % Number of output classes: ARR, CHF, NSR

% Defining layers of AlexNet 
layers = [layersTransfer
fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
softmaxLayer
classificationLayer];   

% Training options
options = trainingOptions('sgdm','MiniBatchSize',20,'MaxEpochs',8, ...
    'InitialLearnRate',1e-4,'Shuffle','every-epoch', ...
    'ValidationData',TestImages,'ValidationFrequency',10, ...
    'Verbose',false,'Plots','training-progress');

% Training the AlexNet
netTransfer = trainNetwork(TrainImages,layers,options);

% Classifying Images
YPred = classify(netTransfer,TestImages);
YValidation = TestImages.Labels;
accuracy = sum(YPred == YValidation)/numel(YValidation)

% Plotting Confusion Matrix
plotconfusion(YValidation,YPred)

% After training, save the trained model
save('trained_alexnet_model.mat', 'netTransfer');

