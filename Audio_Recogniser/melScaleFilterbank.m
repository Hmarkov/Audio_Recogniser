function [ coeffs ] = melScaleFilterbank( mag, numChannels )
    %new array of size channels
    coeffs = zeros(numChannels,1);
    %mel rectangular filterbank
    frameFreq =round( length(mag)/numChannels);
    channelIndex = 1;

    for i=1 : numChannels
        sum = 0.0;
        %average magnitudes in frames
        for j=1 : frameFreq
            sum = sum + mag((i-1)*frameFreq + j);  
        end
        sum = sum/frameFreq;
        coeffs(i) = sum;
        channelIndex = channelIndex + 1;  
    end
end

