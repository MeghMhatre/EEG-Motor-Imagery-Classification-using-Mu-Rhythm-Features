clearvars -except X Y Fs

X = X(Y==1|Y==2,:,:);
Y = Y(Y==1|Y==2,:);

% Computing Bandpower
mu_band = [9 13];
numTrials = size(X,1);
numCh     = size(X,3);
mu_power = zeros(numTrials,numCh);
for tr = 1:numTrials
    for ch = 1:numCh
        sig = squeeze(X(tr,:,ch));
        mu_power(tr,ch) = bandpower(sig,Fs,mu_band);
    end
end

% Computing Features
f1 = zeros(numTrials,3);

for i = 1:length(Y)
    % Feat 1: C3 variance
    C3 = squeeze(X(i,:,8)); % C3 -> 8
    f1(i,1) = log(var(C3));

    % Feat 2: C4 variance
    C4 = squeeze(X(i,:,12)); % C4 -> 12
    f1(i,2) = log(var(C4));

    % Feat 3: Hemishpere band power
    left_ch  = [3 9 15];   % [FC3 C3 CP3]
    right_ch = [5 11 17];  % [FC4 C4 CP4]

    pL = sum(mu_power(i, left_ch));
    pR = sum(mu_power(i, right_ch));

    f1(i,3) = log((pL) / (pR));
end

% rng(1) % same split every run 
cv = cvpartition(Y,'HoldOut',0.3);

Xtrain = f1(training(cv),:);
Ytrain = Y(training(cv));

Xtest  = f1(test(cv),:);
Ytest  = Y(test(cv));

model = fitcdiscr(Xtrain, Ytrain);
Ypred = predict(model, Xtest);
accuracy = mean(Ypred == Ytest);
disp(['Test Accuracy: ', num2str(accuracy)]);


