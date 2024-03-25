function [sepplane mispos misneg] = perceptron(pclass, nclass)
% Computes separating plane (linear classifier) using
% perceptron method.
% pclass - 'positive' class (one row contains one sample)
% nclass - 'negative' class (one row contains one sample)
% Output:
% sepplane - row vector of separating plane coefficients
% mispos - number of misclassified samples of pclass
% misneg - number of misclassified samples of nclass

  % training data aggregation and denormalization (of the neg class)
  sepplane = rand(1, columns(pclass) + 1) - 0.5;
  tset = [ ones(rows(pclass), 1) pclass; -ones(rows(nclass), 1) -nclass];
  nPos = rows(pclass); % number of positive samples
  nNeg = rows(nclass); % number of negative samples

  i = 1;
  do 
    %%% YOUR CODE GOES HERE %%%
    %% You should:
    %% 1. Check which samples are misclassified (boolean column vector)
    miscls = tset * sepplane' < 0;

    %% 2. Compute separating plane correction 
    %%		This is sum of misclassfied samples coordinate times learning rate
    my_sum = sum(tset(miscls, :), 1);

    %% 3. Modify solution (i.e. sepplane)
    if (sum(miscls) == 0)
      break
    endif
    lr = 1/sqrt(sum(miscls));
    sepplane = sepplane + lr * my_sum;

    %% 4. Optionally you can include additional conditions to the stop criterion

    if (abs(lr * my_sum) < 0.00001)
      break;
    endif
    
    %%		200 iterations can take a while and probably in most cases is unnecessary

    ++i;
  until i > 1;

  %%% YOUR CODE GOES HERE %%%
  %% You should:
  %% 1. Compute the numbers of false positives and false negatives
  out = tset * sepplane';

  pos_vector = tset(:, 1) == 1;
  mispos = sum(out(pos_vector, :) < 0);
  % For negative class
  neg_vector = tset(:, 1) == -1;
  misneg = sum(out(neg_vector, :) < 0);
end
