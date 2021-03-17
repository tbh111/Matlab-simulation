function [x]=number_sig(number, Fs)
t1 = [1:Fs/20]; %410个采样点
% t1 = linspace(0,1,410);
switch(number)
    case '1'
        x = sin(2*pi*697*t1/Fs)+sin(2*pi*1209*t1/Fs);
    case '2'
        x = sin(2*pi*697*t1/Fs)+sin(2*pi*1336*t1/Fs);
    case '3'
        x = sin(2*pi*697*t1/Fs)+sin(2*pi*1477*t1/Fs);
    case 'A'
        x = sin(2*pi*697*t1/Fs)+sin(2*pi*1633*t1/Fs);
    case '4'
        x = sin(2*pi*770*t1/Fs)+sin(2*pi*1209*t1/Fs);
    case '5'
        x = sin(2*pi*770*t1/Fs)+sin(2*pi*1336*t1/Fs);
    case '6'
        x = sin(2*pi*770*t1/Fs)+sin(2*pi*1477*t1/Fs);
    case 'B'
        x = sin(2*pi*770*t1/Fs)+sin(2*pi*1633*t1/Fs);
    case '7'
        x = sin(2*pi*852*t1/Fs)+sin(2*pi*1209*t1/Fs);
    case '8'
        x = sin(2*pi*852*t1/Fs)+sin(2*pi*1336*t1/Fs);
    case '9'
        x = sin(2*pi*852*t1/Fs)+sin(2*pi*1477*t1/Fs);
    case 'C'
        x = sin(2*pi*852*t1/Fs)+sin(2*pi*1633*t1/Fs);
    case '*'
        x = sin(2*pi*941*t1/Fs)+sin(2*pi*1209*t1/Fs);
    case '0'
        x = sin(2*pi*941*t1/Fs)+sin(2*pi*1336*t1/Fs);
    case '#'
        x = sin(2*pi*941*t1/Fs)+sin(2*pi*1477*t1/Fs);
    case 'D'
        x = sin(2*pi*941*t1/Fs)+sin(2*pi*1633*t1/Fs);
end
end