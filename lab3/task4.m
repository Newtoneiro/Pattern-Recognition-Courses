% 4. Preparing one-versus-rest ensemble of classifiers. Here you’ll have to think about 
% organizing the training (a function similar to trainOVOensemble). Even before, you 
% should decide about representation of classifiers in the matrix; with code reuse in mind it 
% would be wise to put in the negative class label in the second column. Such a value that will 
% allow you – with minimal changes in code – to use voting and unamvoting functions. 
% Alternative is of course to write separate functions for OVR ensemble.
%

% training of the whole ensemble
ovr = trainOVRensemble(tvec, tlab, @perceptron);

% check your ensemble on train set
clab = unamvoting(tvec, ovr);
cfmx = confMx(tlab, clab)
compErrors(cfmx)

% repeat on test set
clab = unamvoting(tstv, ovr);
cfmx = confMx(tstl, clab)
compErrors(cfmx)