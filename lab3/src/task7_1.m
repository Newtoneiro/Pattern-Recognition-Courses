
[tvec tlab tstv tstl] = readSets();

[mu trmx] = prepTransform(tvec, comp_count);
tvec = pcaTransform(tvec, mu, trmx);
tstv = pcaTransform(tstv, mu, trmx);

% Expand features
tvec = expandFeatures(tvec);
tstv = expandFeatures(tstv);

% shift labels by one to use labels directly as indices
tlab += 1;
tstl += 1;

% training of the whole ensemble
[ovo, err] = trainOVOensemble(tvec, tlab, @perceptron);
err

% check your ensemble on train set
clab = unamvoting(tvec, ovo);
cfmx = confMx(tlab, clab)
compErrors(cfmx)

% repeat on test set
clab = unamvoting(tstv, ovo);
cfmx = confMx(tstl, clab)
compErrors(cfmx)