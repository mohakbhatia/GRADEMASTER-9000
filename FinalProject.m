clc
clear all
close all

answer1 = '8';
answer2 = 'raleigh';
answer3 = 'mitochondria';
answer4pt1 = 'taj';
answer4pt2 = 'mahal';
answer5 = '256';
answer6 = 'yes';
answer7 = 'no';
answer8pt1 = 'neil';
answer8pt2 = 'armstrong';
answer9 = 'eagles';
answer10 = 'a';

questiontotal = 10;
points = 0;
a = arduino('com6','Uno');

mycam = webcam(1);
img = snapshot(mycam);

%% OCR 
ocrResults = ocr(img);
recognizedText = ocrResults.Text  ; 
list = strsplit(recognizedText);

%% Grading

% Potentiometer Reading
pot = readVoltage(a, 'A0');
points = 0;

for i = 1:length(list)
 if strcmp(lower(list{1,i}), 'one')||strcmp(lower(list{1,i}), 'answerone')
     if strcmp(lower(list{1,i+1}), answer1)
         points = points+1;
     end
 end
 if strcmp(lower(list{1,i}), 'two')||strcmp(lower(list{1,i}), 'answertwo')
     if strcmp(lower(list{1,i+1}), answer2)
         points = points+1;
     end
 end
 if strcmp(lower(list{1,i}), 'three')||strcmp(lower(list{1,i}), 'answerthree')
     if strcmp(lower(list{1,i+1}), answer3)
         points = points+1;
     end
 end
 if strcmp(lower(list{1,i}), 'four')||strcmp(lower(list{1,i}), 'answerfour')
     if strcmp(lower(list{1,i+1}), answer4pt1) && strcmp(lower(list{1,i+2}), answer4pt2)||strcmp(lower(list{1,i+1}), strcat(answer4pt1,answer4pt2))
         points = points+1;
     end
 end
 if strcmp(lower(list{1,i}), 'five')||strcmp(lower(list{1,i}), 'answerfive')
     if strcmp(lower(list{1,i+1}), answer5)
         points = points+1;
     end
 end
 if strcmp(lower(list{1,i}), 'six')||strcmp(lower(list{1,i}), 'answersix')
     if strcmp(lower(list{1,i+1}), answer6)
         points = points+1;
     end
 end
 if strcmp(lower(list{1,i}), 'seven')||strcmp(lower(list{1,i}), 'answerseven')
     if strcmp(lower(list{1,i+1}), answer7)
         points = points+1;
     end
 end
 if strcmp(lower(list{1,i}), 'eight')||strcmp(lower(list{1,i}), 'answereight')
     if strcmp(lower(list{1,i+1}), answer8pt1) && strcmp(lower(list{1,i+2}), answer8pt2)
         points = points+1;
     end
 end
 if strcmp(lower(list{1,i}), 'nine')||strcmp(lower(list{1,i}), 'answernine')
     if strcmp(lower(list{1,i+1}), answer9)
         points = points+1;
     end
 end
 if strcmp(lower(list{1,i}), 'ten')||strcmp(lower(list{1,i}), 'answerten')
     if strcmp(lower(list{1,i+1}), answer10)
         points = points+1;
     end
 end      
end

percentage = 0;
percentage = (points/questiontotal)*100;

if pot >= 0 && pot < 1
    finalgrade = 5
end

if pot >= 1 && pot < 2
    A = 99;
    B = 89;
    C = 79;
    D = 69;
    if percentage >= A
        finalgrade = 1;
    end
    if percentage >= B && percentage < A
        finalgrade = 2;
    end
    if percentage >= C && percentage < B
        finalgrade = 3;
    end
    if percentage >= D && percentage < C
        finalgrade = 4;
    end
    if percentage < D
        finalgrade = 5;
    end
end

if pot >= 2 && pot < 3
    A = 90;
    B = 80;
    C = 70;
    D = 60;
    if percentage >= A
        finalgrade = 1;
    end
    if percentage >= B && percentage < A
        finalgrade = 2;
    end
    if percentage >= C && percentage < B
        finalgrade = 3;
    end
    if percentage >= D && percentage < C
        finalgrade = 4;
    end
    if percentage < D
        finalgrade = 5;
    end
end

if pot >= 3 && pot < 4
    A = 80;
    B = 70;
    C = 60;
    D = 50;
    if percentage >= A
        finalgrade = 1;
    end
    if percentage >= B && percentage < A
        finalgrade = 2;
    end
    if percentage >= C && percentage < B
        finalgrade = 3;
    end
    if percentage >= D && percentage < C
        finalgrade = 4;
    end
    if percentage < D
        finalgrade = 5;
    end
end

if pot >= 4 && pot < 5
    finalgrade = 1;
end

finalgrade;
%  
%% Robot Stamping 

% Servo Set Up
% Defined Servo Position Values
pitchup = 0.15;
pitchdown = 0.72;
boopdown = 1;
boopup = 0.78;

yawFink = 0;
yawDink = 0.06;
yawCink = 0.21;
yawBink = 0.325;
yawAink = 0.42;

yawFstamp = 0.48;
yawDstamp = 0.585;
yawCstamp = 0.72;
yawBstamp = 0.805;
yawAstamp = 0.915;

% Defining Servos
yaw = servo(a, 'D2');
pitch = servo(a, 'D3');
boop = servo(a, 'D4');

%Initial Position
writePosition(yaw,yawCstamp)
writePosition(pitch,pitchup)
writePosition(boop,boopdown)
pause(1)

% Grade Stamping
if finalgrade == 1

    writePosition(yaw,yawCstamp)
    writePosition(pitch,pitchup)
    writePosition(boop,boopdown)
    
 
    writePosition(yaw,yawAink+0.05)
    pause(1)
    writePosition(boop,boopup)
    pause(0.5)
    writePosition(boop,boopdown)
    pause(0.5)
    writePosition(yaw,yawAink)
    pause(0.5)
    writePosition(boop,boopup)
    pause(0.5)
    writePosition(boop,boopdown)
    pause(0.5)
    writePosition(yaw,yawAink-.05)
    pause(0.5)
    writePosition(boop,boopup)
    pause(0.5)
    writePosition(boop,boopdown)
    pause(0.5)

    writePosition(yaw,yawAstamp)
    pause(1)
    writePosition(pitch,pitchdown)
    pause(1)
    writePosition(pitch,pitchup)
    pause(1)
    writePosition(yaw,yawCstamp)
end

% Stamp B
if finalgrade == 2
    writePosition(yaw,yawCstamp)
    writePosition(pitch,pitchup)
    writePosition(boop,boopdown)
    
    writePosition(yaw,yawBink+0.05)
    pause(1)
    writePosition(boop,boopup)
    pause(0.5)
    writePosition(boop,boopdown)
    pause(0.5)
    writePosition(yaw,yawBink)
    pause(0.5)
    writePosition(boop,boopup)
    pause(0.5)
    writePosition(boop,boopdown)
    pause(0.5)
    writePosition(yaw,yawBink-.05)
    pause(0.5)
    writePosition(boop,boopup)
    pause(0.5)
    writePosition(boop,boopdown)
    pause(0.5)
    
    writePosition(yaw,yawBstamp)
    pause(1)
    writePosition(pitch,pitchdown)
    pause(1)
    writePosition(pitch,pitchup)
    pause(1)
    writePosition(yaw,yawCstamp)
end

% Stamp C
if finalgrade == 3
    writePosition(yaw,yawCstamp)
    writePosition(pitch,pitchup)
    writePosition(boop,boopdown)

    writePosition(yaw,yawCink+0.05)
    pause(1)
    writePosition(boop,boopup)
    pause(0.5)
    writePosition(boop,boopdown)
    pause(0.5)
    writePosition(yaw,yawCink)
    pause(0.5)
    writePosition(boop,boopup)
    pause(0.5)
    writePosition(boop,boopdown)
    pause(0.5)
    writePosition(yaw,yawCink-.05)
    pause(0.5)
    writePosition(boop,boopup)
    pause(0.5)
    writePosition(boop,boopdown)
    pause(0.5)
    
    writePosition(yaw,yawCstamp)
    pause(1)
    writePosition(pitch,pitchdown)
    pause(1)
    writePosition(pitch,pitchup)
    pause(1)
    writePosition(yaw,yawCstamp)
end

% Stamp D
if finalgrade == 4
    writePosition(yaw,yawCstamp)
    writePosition(pitch,pitchup)
    writePosition(boop,boopdown)

    writePosition(yaw,yawDink+0.05)
    pause(1)
    writePosition(boop,boopup)
    pause(0.5)
    writePosition(boop,boopdown)
    pause(0.5)
    writePosition(yaw,yawDink)
    pause(0.5)
    writePosition(boop,boopup)
    pause(0.5)
    writePosition(boop,boopdown)
    pause(0.5)
    writePosition(yaw,yawDink-.05)
    pause(0.5)
    writePosition(boop,boopup)
    pause(0.5)
    writePosition(boop,boopdown)
    pause(0.5)
    
    writePosition(yaw,yawDstamp)
    pause(1)
    writePosition(pitch,pitchdown)
    pause(1)
    writePosition(pitch,pitchup)
    pause(1)
    writePosition(yaw,yawCstamp)
end

% Stamp F
if finalgrade == 5
    writePosition(yaw,yawCstamp)
    writePosition(pitch,pitchup)
    writePosition(boop,boopdown)

    writePosition(yaw,yawFink+0.05)
    pause(1)
    writePosition(boop,boopup)
    pause(0.5)
    writePosition(boop,boopdown)
    pause(0.5)
    writePosition(yaw,yawFink)
    pause(0.5)
    writePosition(boop,boopup)
    pause(0.5)
    writePosition(boop,boopdown)
    pause(0.5)

    writePosition(yaw,yawFstamp)
    pause(1)
    writePosition(pitch,pitchdown)
    pause(1)
    writePosition(pitch,pitchup)
    pause(1)
    writePosition(yaw,yawCstamp)
end
