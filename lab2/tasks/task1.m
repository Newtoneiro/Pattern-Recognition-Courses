% POINT 1
[train test] = load_cardsuits_data();

% Our first look at the data
size(train)
size(test)
labels = unique(train(:,1))
unique(test(:,1))
[labels'; sum(train(:,1) == labels')]

% the first task after loading the data is checking
% training set for outliers; to this end we usually compute 
% simple statistics: mean, median, std, 
% and/or plot histogram of individual feature: hist
% and/or plot two features at a time: plot2features

[mean(train); median(train)]
hist(train(:,1))

plot2features(train, 2, 3)

% Outlier found, identifying it:

[max_v maxid] = max(train) % - Sample nr. 186 identified as outlier, removing it from the training set
train(186, :) = [];

% searching again

plot2features(train, 2, 3)

[min_v minid] = min(train) % - Sample nr. 641 identified as outlier, removing it from the training set
train(641, :) = [];

% searching again

plot2features(train, 2, 3)
plot2features(train, 4, 5)
plot2features(train, 6, 7)
plot2features(train, 7, 8)

% no more outliers found in train set. Doing the same for test set:

plot2features(test, 2, 3)

% Outlier found, identifying it:

[min_v minid] = min(test) % - Sample nr. 186 identified as outlier, removing it from the test set
test(186, :) = [];

% searching again

plot2features(test, 2, 3) % - Sample nr. 641 identified as outlier, removing it from the test set
test(641, :) = [];


plot2features(test, 2, 3)
plot2features(test, 4, 5)
plot2features(test, 6, 7)
plot2features(test, 7, 8)

% no more outliers found in test set.



