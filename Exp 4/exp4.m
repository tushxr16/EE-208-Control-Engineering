Ts = 0.001; 
z = tf('z',Ts);
gol = ((0.099207)*(z-(0.9))*(z-(0.8)))/((z-1)*(z-1)*(z-1));
gcl = feedback(gol,1);
bodeplot(gcl)
stepinfo(gcl)
rlocus(gcl)
damp(gcl)



s = mesh(Z1,Z2,Freq,'FaceAlpha',0.5);
s.FaceColor = 'interp';
colorbar





Z1=[];Z2=[];
n=10;C=0;
for z1 = 1:10
    for z2 = 1:10
        gol = ((z-(z1/10))*(z-(z2/10)))/((z-1)*(z-1)*(z-1));
        gcl = feedback(gol,1);
        Stability(end+1)=isstable(gcl);
        if(isstable(gcl)==1)
            Z1(end+1)=z1/10;
            Z2(end+1)=z2/10;
        end
    end
end


scatter(Z1,Z2)