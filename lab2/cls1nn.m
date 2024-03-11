function label = cls1nn(x, ts)
% 1-NN classfier 
% x - sample to be classified; no label here!
% ts - training set; the first column contains class label
% label - labels of x's nearest neighbour in ts
  sqdist = sumsq(bsxfun(@minus, ts(:,2:end), x), 2);
  [v, iv] = min(sqdist);
  label = ts(iv,1);
end
