clc

for K=linspace(1,100,1)
    out = sim('l10_final.slx');
    x1 = out.sd{1}.Values;
    subplot(2,3,1)
    plot(x1.Time,x1.Data);
    hold on;
    grid
    ylabel('x1-Position of Trolley(m)')
    xlabel('Time (seconds)');
    x2 = out.sd{2}.Values;
    subplot(2,3,2)
    plot(x2.Time,x2.Data);
    hold on;
    grid
    ylabel('x2-Speed of Trolley (m/s)')
    xlabel('Time (seconds)')
    subplot(2,3,3)
    x3 = out.sd{3}.Values;
    plot(x3.Time,x3.Data);
    hold on;
    grid
    ylabel('x3-Rope Angle (rads)')
    xlabel('Time (seconds)')
    subplot(2,3,4)
    x4 = out.sd{4}.Values;
    plot(x4.Time,x4.Data);
    hold on;
    grid
    ylabel('x4-Angular Speed of Rope (rad/s)')
    xlabel('Time (seconds)')
    subplot(2,3,5)
    x5 = out.sd{5}.Values;
    plot(x5.Time,x5.Data);
    hold on;
    grid
    ylabel('Output')
    xlabel('Time (seconds)')
    subplot(2,3,6)
    x6 = out.sd{6}.Values;
    plot(x6.Time,x6.Data);
    hold on;
    grid
    ylabel('Input')
    xlabel('Time (seconds)')
end

hold off

ml=10;
mc=10;
g=9.8;
l=1;
K=1;







