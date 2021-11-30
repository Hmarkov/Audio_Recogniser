function [  ] = featureExtraction( sample,fs, filename,channelsNum)
    % if fs~=16000
    %     downsampledFs = 16000;
    %     sample = resample(sample,downsampledFs,fs);
    %     fs = downsampledFs;
    % end
    numSamples = length(sample);
    frameSizeSec = 0.02;   %20ms
    overlapSizeSec = 0.01; %10ms
    overlapSizeSamples = overlapSizeSec * fs; 
    frameSizeSamples = frameSizeSec * fs;        

    frameNumber = 1;
    numOfFrames = floor(numSamples/overlapSizeSamples -1) ;
    featureVectors = zeros(numOfFrames,channelsNum/2);

    %loop by calculating new frame each time
    for  i=1 : overlapSizeSamples : length(sample) - frameSizeSamples - 1
        %Extract frame
        startFrame = i;
        endFrame = i + frameSizeSamples;
        frame = sample(startFrame:endFrame);
        emphasisedFrame = filter([1,-0.97],1,frame);
        frame = emphasisedFrame;

        %Hamming window
        ham = hamming(length(frame)) .* frame;
        %Take FFT
        complexSpectrum = fft(ham);
        %Convert to magnitude spectrum
        mag = abs(complexSpectrum); 
        mag = mag(1:floor(length(mag)/2));
        %Get mel filterbank
        filterbank = melScaleFilterbank(mag,channelsNum);
        %log
        logCoefficients = log(filterbank);
        %dct
        %estimate quefrency
        quefrencyFull = dct(logCoefficients);
        %truncation
        quefrencyTrun = quefrencyFull(1:length(quefrencyFull)/2);
        featureVectors(frameNumber,:) = transpose(quefrencyTrun);
        frameNumber = frameNumber + 1;
    end

    %write parameterised file
    writeToHTKFile(filename,featureVectors,overlapSizeSec);

end

