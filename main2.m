% mainscript is rather short this time

% primary component

countcomp_count = 40;

[tvec tlab tstv tstl] = readSets();
% let's look at the first digit in the training set

imshow(1-reshape(tvec(1,:), 28, 28)');
% let's check labels in both sets[unique(tlab)'; unique(tstl)']

% compute and perform PCA transformation

[mu trmx] = prepTransform(tvec, comp_count);
tvec = pcaTransform(tvec, mu, trmx);
tstv = pcaTransform(tstv, mu, trmx);

% let's shift labels by one to use labels directly as indices

tlab += 1;
tstl += 1;

##########exploration##
dist=[];
##for lab=1:rows(unique(tlab))
##  lab;
##  dist(lab)=[sum((tlab==lab),1)/rows(tlab)];
##end
##lab
##dist
##plot(1:1:rows(unique(tlab)),dist, "*")
####hold on;
####for lab=1:rows(unique(tstl))
##  lab;
##    dist(lab)=[sum((tstl==lab),1)/rows(tstl)]
##end
####plot(1:1:rows(unique(tstl)),dist, "+")

% To successfully prepare ensemble you have to implement perceptron function
% I would use 10 first zeros and 10 fisrt ones 
% and only 2 first primary components
% It'll allow printing of intermediate results in perceptron function#testing with zeros and ones
#z=zeros(10,10)
#oney=ones(10,10)
#[sepplane fp fn] = perceptron(pos, neg)
#err_cf= (fp+fn)/(rows(pos)+rows(neg))
#task 1
disp("111111111111111111111111111111111")
#for example digit 4 and 6
pos=tvec(tlab==4,1:2);
neg=tvec(tlab==6,1:2);
[sepplane fp fn]= perceptron(pos, neg)
###task2
disp("2222222222222222222222222222222222222222222333333333333333333333333333")

% training of the whole ensemble

[err ovo] = trainOVOensamble(tvec, tlab, @perceptron);
err;

% check your ensemble on train 
setclab = unamvoting(tvec, ovo);
cfmx = confMx(tlab, clab)
compErrors(cfmx)

% repeat on test set
clab = unamvoting(tstv, ovo);
cfmx = confMx(tstl, clab)
compErrors(cfmx)

##############################################
disp("4444444444444455555555555555555555555")

[err ovr] = trainOVRensamble(tvec, tlab, @perceptron);err;

% check your ensemble on train set

clab = OVRclassifier(tvec, ovr);
cfmx1 = confMx(tlab, clab)
e1=compErrors(cfmx1)

% repeat on test setc
lab = OVRclassifier(tstv, ovr);
cfmx2 = confMx(tstl, clab)
e2=compErrors(cfmx2)

disp("666666666666666666666666666666666666")

[err ovr] = rds_trainOVRensamble(tvec, tlab, @perceptron);
err;

% check your ensemble on train set
clab = OVRclassifier(tvec, ovr);
cfmx = confMx(tlab, clab)
compErrors(cfmx)

% repeat on test set
clab = OVRclassifier(tstv, ovr);
cfmx = confMx(tstl, clab)
compErrors(cfmx)

##############################################################################disp("7777777777777777777777777777777777777777777777777")tvec = expandFeatures(tvec);tstv = expandFeatures(tstv);###task2 with expandeddisp("22222222222222222222222222222223333333333377777777777777777777777777777777")% training of the whole ensemble[err ovo] = trainOVOensamble(tvec, tlab, @perceptron);err;% check your ensemble on train setclab = unamvoting(tvec, ovo);cfmx = confMx(tlab, clab)compErrors(cfmx)% repeat on test setclab = unamvoting(tstv, ovo);cfmx = confMx(tstl, clab)compErrors(cfmx)##############################################disp("4444444444445555555555555557777777777777777777777777777777777777777777777777")[err ovr] = trainOVRensamble(tvec, tlab, @perceptron);err;% check your ensemble on train setclab = OVRclassifier(tvec, ovr);cfmx = confMx(tlab, clab)compErrors(cfmx)% repeat on test setclab = OVRclassifier(tstv, ovr);cfmx = confMx(tstl, clab)compErrors(cfmx)####################################################disp("666666666666666666666666666666666677777777777777777777777777777777777777777777")[err ovr] = rds_trainOVRensamble(tvec, tlab, @perceptron);err;clab = OVRclassifier(tvec, ovr);cfmx = confMx(tlab, clab)eeex1=compErrors(cfmx)clab2 = OVRclassifier(tstv, ovr);cfmx2 = confMx(tstl, clab2)eeex2=compErrors(cfmx2)######################################################################improvementdisp("improvement")####################################################################clear;clc;% primary component countcomp_count = 40; [tvec tlab tstv tstl] = readSets(); % let's check labels in both sets[unique(tlab)'; unique(tstl)']% compute and perform PCA transformation[mu trmx] = prepTransform(tvec, comp_count);tvec = pcaTransform(tvec, mu, trmx);tstv = pcaTransform(tstv, mu, trmx);% let's shift labels by one to use labels directly as indicestlab += 1;tstl += 1;[err ovr] = trainOVRensamble(tvec, tlab, @perceptron);[err ovo] = trainOVOensamble(tvec, tlab, @perceptron);clab = improvement(tvec, ovr, ovo);cfmx = confMx(tlab, clab)eeex1=compErrors(cfmx)clab2 = improvement(tstv, ovr, ovo);cfmx2 = confMx(tstl, clab2)eeex2=compErrors(cfmx2)##########################################################disp("improvement222222222222")tvec = expandFeatures(tvec);tstv = expandFeatures(tstv);[err ovr] = trainOVRensamble(tvec, tlab, @perceptron);[err ovo] = trainOVOensamble(tvec, tlab, @perceptron);clab = improvement(tvec, ovr, ovo);cfmx = confMx(tlab, clab)eeex1=compErrors(cfmx)clab2 = improvement(tstv, ovr, ovo);cfmx2 = confMx(tstl, clab2)eeex2=compErrors(cfmx2)