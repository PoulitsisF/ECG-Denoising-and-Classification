% Function to convert ECG to Scalogram (ecg2cwtscg)

function ecg2cwtscg(ecgdata,cwtfb,ecgtype)
nos = 10; % Number of Signals
nol = 500; % Signal Length
colormap = jet(128);
if ecgtype == 'ARR'
    folderpath = strcat('C:\Program Files\MATLAB\R2023b\bin\AD8232\ecgdataset\arr\');    % Arr Folder
    findx = 0;
    for i = 1:30
        indx = 0;
        for k = 1:nos
            ecgsignal = ecgdata(i,indx+1:indx+nol);
            cfs = abs(cwtfb.wt(ecgsignal));
            im = ind2rgb(im2uint8(rescale(cfs)),colormap);
            filenameindex = findx+k;
            filename = strcat(folderpath,sprintf('%d.jpg',filenameindex));
            imwrite(imresize(im,[227 227]),filename);
            indx = indx+nol;
        end
        findx = findx+nos;
    end
elseif ecgtype == 'CHF'
    folderpath = strcat('C:\Program Files\MATLAB\R2023b\bin\AD8232\ecgdataset\chf\');     % Chf Folder
    findx = 0;
    for i = 1:30
        indx = 0;
        for k = 1:nos
            ecgsignal = ecgdata(i,indx+1:indx+nol);
            cfs = abs(cwtfb.wt(ecgsignal));
            im = ind2rgb(im2uint8(rescale(cfs)),colormap);
            filenameindex = findx+k;
            filename = strcat(folderpath,sprintf('%d.jpg',filenameindex));
            imwrite(imresize(im,[227 227]),filename);
            indx = indx+nol;
        end
        findx = findx+nos;
    end
elseif ecgtype == 'NSR'
    folderpath = strcat('C:\Program Files\MATLAB\R2023b\bin\AD8232\ecgdataset\nsr\');     % Nsr Folder
    findx = 0;
    for i = 1:30
        indx = 0;
        for k = 1:nos
            ecgsignal = ecgdata(i,indx+1:indx+nol);
            cfs = abs(cwtfb.wt(ecgsignal));
            im = ind2rgb(im2uint8(rescale(cfs)),colormap);
            filenameindex = findx+k;
            filename = strcat(folderpath,sprintf('%d.jpg',filenameindex));
            imwrite(imresize(im,[227 227]),filename);
            indx = indx+nol;
        end
        findx = findx+nos;
    end
end