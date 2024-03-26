repeat = 100;

[tvec tlab tstv tstl] = readSets();

[mu trmx] = prepTransform(tvec, comp_count);
tvec = pcaTransform(tvec, mu, trmx);
tstv = pcaTransform(tstv, mu, trmx)

% shift labels by one to use labels directly as indices
tlab += 1;
tstl += 1;

# Easy case
pclass = tvec(tlab == 0, :);
nclass = tvec(tlab == 1, :);
total_pos_acc = 0;
total_neg_acc = 0;
for i = 1:repeat
    [sepplane, mispos, misneg] = perceptron(pclass, nclass);
    pos_acc = 1 - mispos / size(pclass, 1);
    total_pos_acc += pos_acc;
    neg_acc = 1 - misneg / size(nclass, 1);
    total_neg_acc += neg_acc;
end
disp("==< Easy case >==")
disp("Positive accuracy: "), disp(total_pos_acc / repeat)
disp("Negative accuracy: "), disp(total_neg_acc / repeat)


# Difficult case
pclass = tvec(tlab == 4, :);
nclass = tvec(tlab == 9, :);
total_pos_acc = 0;
total_neg_acc = 0;
for i = 1:repeat
    [sepplane, mispos, misneg] = perceptron(pclass, nclass);
    pos_acc = 1 - mispos / size(pclass, 1);
    total_pos_acc += pos_acc;
    neg_acc = 1 - misneg / size(nclass, 1);
    total_neg_acc += neg_acc;
end
disp("==< Difficult case >==")
disp("Positive accuracy: "), disp(total_pos_acc / repeat)
disp("Negative accuracy: "), disp(total_neg_acc / repeat)