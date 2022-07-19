import mlreportgen.dom.*
[a,b,c] = gCLTFforT();
s = mesh(b,c,a,'FaceAlpha',0.5);
s.FaceColor = 'interp';
colorbar
function [ov,k,t] = gCLTFforT()
    s = tf('s');
    j=0;i=0;
    ov = []; t = []; k = [];
    for T = 0:10
        tmp = [];
        t(end+1) = T;
        for K = 1:5
            G_OL = (0.03*K*15)/((s)*(1+(0.1*(1+(i/100)))*s)*(1+0.2*(1+(j/100))*s)*(1+(T)*s));
            fb = feedback(G_OL,1);
            tmp(end+1) = stepinfo(fb).SettlingTime;
%             tmp(end+1) = stepinfo(fb).RiseTime;
%             tmp(end+1) = stepinfo(fb).Overshoot;
%             tmp(end+1) = stepinfo(fb).RiseTime;
        end
        ov(end+1) = tmp;
    end
end

import mlreportgen.dom.*
gCLTFforT();

function [s] = gCLTFforT()
    s = tf('s');
    j=0;i=0;
    for T = -50:50
        for K = 1:1
            G_OL = (30*K)/((s)*(1+(0.1*(1+(i/100)))*s)*(1+0.2*(1+(j/100))*s)*(1+(T*20)*s));
            fb = feedback(G_OL,1);
            damp(fb);
            stepinfo(fb)
        end
    end
    for T = -20:20
        for K = 1:1
            G_OL = (30*K)/((s)*(1+(0.1*(1+(i/100)))*s)*(1+0.2*(1+(j/100))*s)*(1+(T/100)*s));
            fb = feedback(G_OL,1);
            damp(fb);
            stepinfo(fb)
        end
    end
end

import mlreportgen.dom.*
gCLTFforT();

function [s] = gCLTFforT()
    s = tf('s');
    j=0;i=0;
    for T = 1:1
        for K = 35:55
            G_OL = (0.03*K)/((s)*(1+(0.1*(1+(i/100)))*s)*(1+0.2*(1+(j/100))*s)*(1+(T)*s));
            fb = feedback(G_OL,1);
            step(fb)
            hold on
        end
    end
    hold off
end

import mlreportgen.dom.*

s = tf('s');
T=1;
i=0;
j=0;

G_OL = (30)/((s)*(1+(0.1*(1+(i/100)))*s)*(1+0.2*(1+(j/100))*s)*(1+(T)*s));
controlSystemDesigner('rlocus',G_OL);