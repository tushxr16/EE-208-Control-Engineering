clc
A = [[-0.14 -0.69 0.0]; [-0.19 -0.048 0.0]; [0.0 1.0 0.0];];
B = [[0.056];[-0.23];[0.0];];
C = [[1 0 0];[0 1 0];];
D = [[0];[0];];

s = tf('s');
n = 5;
j = 1;
Data = zeros(3*n,5);
%Poles (-0.459,0.271,0)

ST1=[];ST2=[];
for k1 = -n:-1
    for k2 = -n:-1
        a = -k2/(10*sqrt(2));
            poles = [k1/10 -a+1i*a -a-1i*a];
            K = place(A,B,poles);
            Data(j,1) = K(1);
            Data(j,2) = K(2);
            Data(j,3) = K(3);
            [a,b] = ss2tf(A-B*K,B,C,D);
            tf1 = (s*a(1,2) + a(1,3))/(s*s*s*b(1,1) + s*s*b(1,2) + s*b(1,3) + b(1,4));
            tf2 = (s*a(2,2) + a(2,3))/(s*s*s*b(1,1) + s*s*b(1,2) + s*b(1,3) + b(1,4));
            ST1(end+1) = stepinfo(feedback(tf1,K(1))).SettlingTime;
            ST2(end+1) = stepinfo(feedback(tf2,K(2))).SettlingTime;
            j=j+1;
    end
end

Data(:,4) = ST1;
Data(:,5) = ST2;
Data