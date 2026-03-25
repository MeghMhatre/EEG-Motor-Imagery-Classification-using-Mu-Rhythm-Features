clc, clear all,close all

A01 = load("A01T.mat");
A02 = load("A02T.mat");
A03 = load("A03T.mat");
Data = [A01]; % Single subject trial input
Fs = 250;
run_win =[];
run_lab = [];

for dt = Data % External loop to optionally add multi-subject trials
% Loop for Runs 4 to 9
for g = 4:9

    % -1- Load Run
    trial = {}; 
    win_trial = {}; 

    run = dt.data{g};
    sig = run.X(:,1:22);
    labels = run.y;

    % -2- Extracting only indexed trials
    trials = run.trial;
    trials_mod = [trials; size(sig,1)+1];
    for i = 1:length(trials)
        trial{i} = sig(trials_mod(i):trials_mod(i+1)-1,:);
    end

    % -3- Removing artifact trials
    artifacts = run.artifacts;
    clean_idx = artifacts == 0;
    clean_trials = trial(clean_idx);
    clean_labels = labels(clean_idx);
    
    % -4- Time windowed segments of Motor Imagery
    start_idx = 2*Fs + 1; % Start time
    end_idx = 6*Fs; % End time
    for i = 1:length(clean_trials)
        win_trial{i} = clean_trials{i}(start_idx:end_idx,:);
    end

    % -5- Append to main data variable

    run_win = [run_win, win_trial];
    run_lab = [run_lab; clean_labels];

end
end
%% 2 Prepare bandpass filtered data 

[b,a] = butter(4,[9 13]/(Fs/2),'bandpass'); % Mu [9 13], overall [8 30]
run_win_filt = {};
for i = 1:length(run_win)
    run_win_filt{i} = filtfilt(b,a,run_win{i});
end

run_win = run_win_filt;



%% 3 Dimensional Matrix

numTrials = length(run_win);
samples   = size(run_win{1},1);
channels  = size(run_win{1},2);

X = zeros(numTrials, samples, channels);
Y = run_lab;

for i = 1:numTrials
    X(i,:,:) = run_win{i};
end
