clc; clear; close all;

zeta = [0 0.3 0.6 0.8 1 2 5 10];
wn = [1 3 5];     % three values of natural frequency

t = 0:0.01:10;

for j = 1:length(wn)

    figure;
    hold on;
    
    for i = 1:length(zeta)
        
        num = wn(j)^2;
        den = [1 2*zeta(i)*wn(j) wn(j)^2];
        
        sys = tf(num,den);
        
        [y,t1] = step(sys,t);
        
        plot(t1,y,'LineWidth',1.5)
    end
    
    grid on
    xlabel('Time (sec)')
    ylabel('c(t)')
    title(['Unit Step Response for \omega_n = ',num2str(wn(j))])
    
    legend('\xi=0','0.3','0.6','0.8','1','2','5','10')
end