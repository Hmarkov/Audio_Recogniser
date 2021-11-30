cleanPath = 'testing_speech\X.wav';

inputTemplate = cleanPath;
outputTemplate = 'testing_mfcc\X.mfc';

for i=21:21
    input = strrep(inputTemplate,'X', num2str(i));
    output = strrep(outputTemplate,'X', num2str(i));
    
    [sample,fs] = audioread(input);
    %sample = specsub(sample,fs);
    featureExtraction(sample, fs, output,80);
end