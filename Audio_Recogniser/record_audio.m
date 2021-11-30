recObj=audiorecorder(16000, 16, 2);
for fileNumber =21:21
    disp("start speaking")
    recordblocking(recObj,7)
    disp("end")
    y=getaudiodata(recObj,"double");
    yNorm=0.99 * y/max(abs(y));
    new= plus(int2str(fileNumber),".wav");
    audiowrite(new,yNorm,16000);
end

% Albi
% Alejandro
% Benjamin
% Felipe, 
% Alexander