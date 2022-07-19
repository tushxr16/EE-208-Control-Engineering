clear
close all
clc

%CONSTANT VARIABLES
mc = 10;    ml = 10;    g = 9.8;
F = 1;      l = 1;

%FOR ITERATION
i=1;
n=5;
% FOR GRAPHS
EIG = zeros(n,n);
X=linspace(10,1000,1);
Y=linspace(1,10,n);

for ml = X
    j=1;
    for l = Y
        A = [[0 1 0 0];
            [0 0 (ml/mc)*g 0];
            [0 0 0 1];
            [0 0 -g*(ml+mc)/(mc*l) 0];];
        B = [[0];
            [1/mc];
            [0];
            [-1/(mc*l)];];
        C = [[1 0 l 0];];
        D = 0;

        sys = tf(ss(A,B,C,D))
        temp = eig(sys(1));
        EIG(i,j) = abs(temp(3));
        %         rlocus(sys)
        %         legend("DISTANCE X")
        step(feedback(F*sys,[0]))
        hold on
        grid;
        Observability = [C;C*A;C*A*A];
        a = length(A) - rank(Observability)
        Controlability = [A, A*B, A*A*B];
        b = length(A) - rank(Controlability)
        j=j+1;
    end
    i=i+1;
end


%2D PLOT
% plot(Y,EIG(1,:),Color='red');
% plot(X,EIG(:,1),Color='red');
% grid;
% xlabel("TOTAL WEIGHT OF HOOK AND LOAD");
% ylabel("EIGENVALUES");
% legend("LENGTH OF ROPE = 1m")
% title("MOVEMENT OF EIGENVALUES");

%3D PLOT
% surf(X,Y,EIG);
% grid;
% xlabel("TOTAL WEIGHT OF HOOK AND LOAD");
% ylabel("LENGTH OF ROPE");
% zlabel("IMAGINARY EIGENVALUES");
% title("MOVEMENT OF EIGENVALUES");