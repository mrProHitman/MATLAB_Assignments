clc; clear; close all;
num = 25;
den = [1 4 25];
G = tf(num, den);
bode(G)
grid on
title('Bode Plot')
figure;
hold on;
    
for i = 1:10
        
        num = 25;
        den = [1 i 25];
        
        sys = tf(num,den);
        bode(sys)
end
grid on
xlabel('Time (sec)')    
ylabel('c(t)')
