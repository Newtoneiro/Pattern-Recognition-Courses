[tvec tlab tstv tstl] = readSets();

[mu trmx] = prepTransform(tvec, comp_count);
tvec = pcaTransform(tvec, mu, trmx);
tstv = pcaTransform(tstv, mu, trmx);

% % % Expand features
tvec = expandFeatures(tvec);
tstv = expandFeatures(tstv);

% shift labels by one to use labels directly as indices
tlab += 1;
tstl += 1;

[ovo err] = trainOVOensemble(tvec, tlab, @perceptron);
[ovr err] = trainOVRensemble(tvec, tlab, @perceptron);

clab = improvedVoting(tvec, ovr, ovo);
cfmx = confMx(tlab, clab)
compErrors(cfmx)

clab2 = improvedVoting(tstv, ovr, ovo);
cfmx2 = confMx(tstl, clab2)
compErrors(cfmx2)