import mlreportgen.dom.*

[C_Cltf,F_Cltf,valueOfK] = loopK(0.01,14,2);

% VARIABLES TO STORE VALUES OF OVERSHOOT, PEAK TIME, SETTLING TIME,
% STEADYSTATE ERROR FOR EACH CLTF

overShootCLTF_C = [stepinfo(C_Cltf(1)).Overshoot];
peakTimeCLTF_C = [stepinfo(C_Cltf(1)).PeakTime];
settlingTimeCLTF_C = [stepinfo(C_Cltf(1)).SettlingTime];
tmp = step(C_Cltf(1),1);
ssErrorCLTF_C = [abs(tmp(end)-1)];

overShootCLTF_F = [stepinfo(F_Cltf(1)).Overshoot];
peakTimeCLTF_F = [stepinfo(F_Cltf(1)).PeakTime];
settlingTimeCLTF_F = [stepinfo(F_Cltf(1)).SettlingTime];
tmp = step(F_Cltf(1),1);
ssErrorCLTF_F = [abs(tmp(end)-1)];

for i = 2:length(C_Cltf)
    
    overShootCLTF_C(end+1) = stepinfo(C_Cltf(i)).Overshoot;
    peakTimeCLTF_C(end+1) = stepinfo(C_Cltf(i)).PeakTime;
    settlingTimeCLTF_C(end+1) = stepinfo(C_Cltf(i)).SettlingTime;
    tmp = step(C_Cltf(i),1);
    ssErrorCLTF_C(end+1) = [abs(tmp(end)-1)];
    
    overShootCLTF_F(end+1) = stepinfo(F_Cltf(i)).Overshoot;
    peakTimeCLTF_F(end+1) = stepinfo(F_Cltf(i)).PeakTime;
    settlingTimeCLTF_F(end+1) = stepinfo(F_Cltf(i)).SettlingTime;
    tmp = step(F_Cltf(i),1);
    ssErrorCLTF_F(end+1) = [abs(tmp(end)-1)];
end

% displayValues(overShootCLTF_C,peakTimeCLTF_C,settlingTimeCLTF_C,ssErrorCLTF_C,overShootCLTF_F,peakTimeCLTF_F,settlingTimeCLTF_F,ssErrorCLTF_F,valueOfK);
% plotGraph(C_Cltf);
plotGraph(F_Cltf);


% PLOT THE GRAPH
function plotGraph(C)

%     UNCOMMENT THE GRAPH YOU WANT TO SEE

%     step(C(1),C(2),C(3),C(4),C(5),C(6),C(7),C(8),C(9),C(10),C(11),C(12),C(13),C(14),C(15))
%     pzmap(C(1),C(2),C(3),C(4),C(5),C(6),C(7),C(8),C(9),C(10),C(11),C(12),C(13),C(14),C(15))
%     rlocus(C(1),C(2),C(3),C(4),C(5),C(6),C(7),C(8),C(9),C(10),C(11),C(12),C(13),C(14),C(15))
%     legend('K=0.01','K=0.02','K=0.04','K=0.08','K=0.16','K=0.32','K=0.64','K=1.28','K=2.56','K=5.12','K=10.24','K=20.48','K=40.96','K=81.92','K=163.84')
end


% DISPLAY THE VALUES OF STEP RESPONSE FOR EACH CLTF
function displayValues(overShootCLTF_C,peakTimeCLTF_C,settlingTimeCLTF_C,ssErrorCLTF_C,overShootCLTF_F,peakTimeCLTF_F,settlingTimeCLTF_F,ssErrorCLTF_F,valueOfK)
    disp("   Overshoot Cascaded");
    disp(overShootCLTF_C);
    disp("   Peak Time Cascaded");
    disp(peakTimeCLTF_C);
    disp("   Settling Time Cascaded");
    disp(settlingTimeCLTF_C);
    disp("   Steady State Cascaded");
    disp(ssErrorCLTF_C);

    disp("   Overshoot Feedback");
    disp(overShootCLTF_F);
    disp("   Peak Time Feedback");
    disp(peakTimeCLTF_F);
    disp("   Settling Time Feedback");
    disp(settlingTimeCLTF_F);
    disp("   Steady State Feedback");
    disp(ssErrorCLTF_F);
    disp("   Value of K");
    disp(valueOfK);
end


%FUNCTION TO FIND THE CLTF FOR EACH VALUE OF 'K'
function [cascadedCLTFs,feedbackCLTFs,valueOfK] = loopK(K_begin,vals,interval)
    [tmpCLTF_Cascade,tmpCLTF_FeedBack] = Calc_CLTF(interval*K_begin);
    cascadedCLTFs = [tmpCLTF_Cascade];
    feedbackCLTFs = [tmpCLTF_FeedBack];
    valueOfK = [K_begin];
    tmp = interval;
    for i = 1:vals
        [tmpCLTF_Cascade,tmpCLTF_FeedBack] = Calc_CLTF(K_begin*tmp);
        cascadedCLTFs(end+1) = tmpCLTF_Cascade;
        feedbackCLTFs(end+1) = tmpCLTF_FeedBack;
        valueOfK(end+1) = K_begin*tmp;
        tmp = interval*tmp;
    end
end


% FUNCTION TO GENERATE CLTF IN TERMS OF 'K'
function [G_CLTF_Cascade,G_CLTF_FeedBack] = Calc_CLTF(K)
    s = tf('s');
    G_CLTF_FeedBack = K/((s*s) +((3+(80*K))*s) + (10 + (400*K)));
    G_CLTF_Cascade = 80*K*(s+5)/((s*s) + ((3+(80*K))*s) + 10 + (400*K));
end
