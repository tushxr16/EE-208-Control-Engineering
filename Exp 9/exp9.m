clc;

L_vals = zeros(1,10);
T_vals = zeros(1,10);
K_P = zeros(3,10);
K_PI = zeros(3,10);
K_PID = zeros(3,10);

for n = 1:10

    syms s;
    tf1 = 1/((s+1.5)^n);
    
    Y_s = tf1/s;
    yt = ilaplace(Y_s);
    y2t = diff(diff(yt));
    inf_pt = solve(y2t == 0);

    s = tf('s');
    tf1 = 1/((s+1.5)^n);
    [y,time] = step(tf1);
    pidtune(tf1,'PID');

    l = time(find(y>=0.5*y(end),1));
    t = time(find(y>=(1-exp(-1))*y(end),1));
    D = diff(y)./diff(time);
    inflex = find(diff(D)./diff(time(1:end-1))<0,1);
    A = D(inflex)*time(inflex)-y(inflex);
    tangent = D(inflex)*time - A;
    step(tf1)
    hold on
    plot(time(inflex),y(inflex),'*')
    hold on
    L_vals(n)=(-y(inflex)/D(inflex))+time(inflex);
    T_vals(n)=time(inflex)+((y(end-1)-y(inflex))/D(inflex))-L_vals(n);
    K_P(:,n) = [T_vals(n)/L_vals(n) 0 0];
    K_PI(:,n) = [(0.9*T_vals(n))/L_vals(n) (0.27*T_vals(n))/(L_vals(n)*L_vals(n)) 0];
    K_PID(:,n) = [(1.2*T_vals(n))/L_vals(n) (0.6*T_vals(n))/(L_vals(n)*L_vals(n)) 0.6*T_vals(n)];

end
hold off

OVERSHOOT = zeros(3,10);
RISE_TIME = zeros(3,10);
SETT_TIME = zeros(3,10);
SS_ERRORS = zeros(3,10);
EIG_VALUE = zeros(3,10);

for n = 2:10
    s = tf('s');
    sys = 1/((s+1.5)^n);
    step(feedback(sys*pidtune(sys,'PID'),1))

    C = pid(K_P(1,n),K_P(2,n),K_P(3,n),0);
    G_CL = feedback(sys*C,1);
    OVERSHOOT(1,n) = stepinfo(G_CL).RiseTime;
    RISE_TIME(1,n) = stepinfo(G_CL).Overshoot;
    SETT_TIME(1,n) = stepinfo(G_CL).SettlingTime;
    SS_ERRORS(1,n) = 1-dcgain(G_CL);
    EIG_VALUE(1,n) = max(abs(eig(G_CL)));
    
    C = pid(K_PI(1,n),K_PI(2,n),K_PI(3,n),0);
    G_CL = feedback(sys*C,1);
    OVERSHOOT(2,n) = stepinfo(G_CL).RiseTime;
    RISE_TIME(2,n) = stepinfo(G_CL).Overshoot;
    SETT_TIME(2,n) = stepinfo(G_CL).SettlingTime;
    SS_ERRORS(2,n) = 1-dcgain(G_CL);
    EIG_VALUE(2,n) = max(abs(eig(G_CL)));

    C = pid(K_PID(1,n),K_PID(2,n),K_PID(3,n),0);
    G_CL = feedback(sys*C,1);
    OVERSHOOT(3,n) = stepinfo(G_CL).RiseTime;
    RISE_TIME(3,n) = stepinfo(G_CL).Overshoot;
    SETT_TIME(3,n) = stepinfo(G_CL).SettlingTime;
    SS_ERRORS(3,n) = 1-dcgain(G_CL);
    EIG_VALUE(3,n) = max(abs(eig(G_CL)));

    hold on
end

hold off

plot(linspace(2,10,9),EIG_VALUE(1,2:10))
hold on
plot(linspace(2,10,9),EIG_VALUE(2,2:10))
hold on
plot(linspace(2,10,9),EIG_VALUE(3,2:10))
xlabel('MULTIPLICITY')
ylabel('PERFORMANCE MEASURE')
title('DYNAMIC PERFORMANCE FOR DIFFERENT CONTROLLERS')
legend('P CONTOLLER','PI CONTROLLER','PID CONTROLLER')
grid