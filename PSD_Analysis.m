% PSD of all trials for C3 and C4 channels is computed and then averaged

C3 = 8;
C4 = 12;

C3_left  = squeeze(X(Y==1,:,C3));
C3_right = squeeze(X(Y==2,:,C3));
C4_left  = squeeze(X(Y==1,:,C4));
C4_right = squeeze(X(Y==2,:,C4));

for i = 1:size(C3_left,1)
    [pxx,f] = pwelch(C3_left(i,:),[],[],[],Fs);
    pxxC3L(i,:) = pxx;
end

for i = 1:size(C3_right,1)
    pxxC3R(i,:) = pwelch(C3_right(i,:),[],[],[],Fs);
end

for i = 1:size(C4_left,1)
    pxxC4L(i,:) = pwelch(C4_left(i,:),[],[],[],Fs);
end

for i = 1:size(C4_right,1)
    pxxC4R(i,:) = pwelch(C4_right(i,:),[],[],[],Fs);
end

pxxC3L = mean(pxxC3L);
pxxC3R = mean(pxxC3R);
pxxC4L = mean(pxxC4L);
pxxC4R = mean(pxxC4R);

figure(1)
subplot(221)
plot(f,pxxC3L,'b','LineWidth',2)
hold on
plot(f,pxxC3R,'r','LineWidth',2)
xlim([0 30])
xline(9,'--')
xline(13,'--')
legend('Left','Right')
title('PSD of C3 (Left cortex)')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
grid on
hold off

subplot(222)
plot(f,10*log10(pxxC3L),'b','LineWidth',2)
hold on
plot(f,10*log10(pxxC3R),'r','LineWidth',2)
xlim([0 30])
xline(9,'--')
xline(13,'--')
legend('Left','Right')
title('PSD of C3 (Left cortex)')
xlabel('Frequency (Hz)')
ylabel('Power (dB)')
grid on
hold off

subplot(223)
plot(f,pxxC4L,'b','LineWidth',2)
hold on
plot(f,pxxC4R,'r','LineWidth',2)
xlim([0 30])
xline(9,'--')
xline(13,'--')
legend('Left','Right')
title('PSD of C4 (Right cortex)')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
grid on
hold off

subplot(224)
plot(f,10*log10(pxxC4L),'b','LineWidth',2)
hold on
plot(f,10*log10(pxxC4R),'r','LineWidth',2)
xlim([0 30])
xline(9,'--')
xline(13,'--')
legend('Left','Right')
title('PSD of C4 (Right cortex)')
xlabel('Frequency (Hz)')
ylabel('Power (dB)')
grid on
hold off