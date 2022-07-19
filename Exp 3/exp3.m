s=tf('s');n=5;
vent=507.1*(s+1)*(s+65)*(s+129);

PM=zeros(n,n);GM=zeros(n,n);Stablility=[];
OverShoot=zeros(n,n);       SettlingTime=zeros(n,n);
RiseTime=zeros(n,n);        PeakTime=zeros(n,n);

T=linspace(1,10,n);     K=linspace(0.1,1,n);
Tc=[];                  Kf=[];

for i=1:n
    for j=1:n
        plant = 0.1/((s+(T(i)/10))*(s+0.5)*(s+0.1)*(s+0.2));
        sys = feedback(plant,K(j));
        [gm,pm] = margin(feedback(vent*sys,1));
        PM(i,j) = pm;
        GM(i,j) = gm;
        step(feedback(vent*sys,1))
        hold on
        OverShoot(i,j)    = stepinfo(feedback(vent*sys,1)).Overshoot;
        SettlingTime(i,j) = stepinfo(feedback(vent*sys,1)).SettlingTime;
        RiseTime(i,j)     = stepinfo(feedback(vent*sys,1)).RiseTime;
        PeakTime(i,j)     = stepinfo(feedback(vent*sys,1)).PeakTime;
        Stablility(i,j)   = isstable(feedback(vent*sys,1));
    end
    Tc(end+1)=i;Kf(end+1)=i;
end
hold off

disp(PM);
disp(Stablility);
disp(OverShoot);
disp(SettlingTime);
disp(RiseTime);
disp(PeakTime);

s = mesh(Kf,Tc,PM,'FaceAlpha',0.5);
s.FaceColor = 'interp';
colorbar




