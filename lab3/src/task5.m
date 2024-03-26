% 4. Preparing one-versus-rest ensemble of classifiers. Here you’ll have to think about 
% organizing the training (a function similar to trainOVOensemble). Even before, you 
% should decide about representation of classifiers in the matrix; with code reuse in mind it 
% would be wise to put in the negative class label in the second column. Such a value that will 
% allow you – with minimal changes in code – to use voting and unamvoting functions. 
% Alternative is of course to write separate functions for OVR ensemble.
%

[tvec tlab tstv tstl] = readSets();

[mu trmx] = prepTransform(tvec, comp_count);
tvec = pcaTransform(tvec, mu, trmx);
tstv = pcaTransform(tstv, mu, trmx);

% shift labels by one to use labels directly as indices
tlab += 1;
tstl += 1;

% training of the whole ensemble
[ovr, err] = trainOVRensemble(tvec, tlab, @perceptron);
err

% check your ensemble on train set
clab = OVRvoting(tvec, ovr);
cfmx = confMx(tlab, clab)
compErrors(cfmx)

% repeat on test set
clab = OVRvoting(tstv, ovr);
cfmx = confMx(tstl, clab)
compErrors(cfmx)