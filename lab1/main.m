% ========================================
% ==     Bartosz Latosek EPART 24L      ==
% ========================================

% Load the original datasets [iris2 = versicolor, iris3 = virginica]

global orig_versicolor = load ('static/iris2.txt')
global orig_virginica = load ('static/iris3.txt')

% Label the data and dispose of the indexes

global versicolor = [orig_versicolor(:, 2:end), zeros(rows(orig_versicolor), 1)]
global virginica = [orig_virginica(:, 2:end), ones(rows(orig_versicolor), 1)]

% Verify if the size of the classes datasets matches

if (size (versicolor)(2) != size (virginica)(2))
    printf("Irises sizes don\'t match - %f - %f", versicolor(2), virginica(2))
endif

% Function imitating classifier
% @sample - sample data to clasify
% @dataset - the dataset on which base the prediction
% returns -> the class - 0 for Versicolor, 1 for Virginica
function retval = classify(sample, dataset)
    retval = 0
    % Another check for the size 
    expected_size = size (dataset)(2) - 1 % -1 for the class column
    sample_size = size (sample)
    if (sample_size(2) != expected_size)
        printf("Sample size is incorrect. [%f], expected [%f]\n", sample_size(2), expected_size)
        return
    endif
    
    % Return the value and idx of the closest match
    [val, idx] = min(sqrt(sum((dataset(:, 1:end-1) -sample).^2, 2)))
    retval = dataset(idx, end)
    return
endfunction

% Main function for evaluating the dummy classifier
function evaluate()
    global versicolor
    global virginica

    % Combine the datasets
    dataset = [versicolor; virginica]

    % Save the orig size and correct guesses, to further calculate the Acc.
    % The orig_size is decremented by 1, because the last step of the while loop
    % would consist of dataset with the size of 0. Therefore the following condition, i > 1 (instead of 0)
    orig_size = size (dataset)(1) - 1
    correct = 0

    % Start from the combined, full dataset
    i = size (dataset)(1)
    while (i > 1)
        % Sample the data
        sample_idx = randi(size(dataset, 1),1)
        sample = dataset(sample_idx, :)

        % Remove the selected sample from the dataset
        dataset = [dataset(1:sample_idx-1, :); dataset(sample_idx+1:end, :)]

        % Make prediction
        prediction = classify(sample(:, 1:end-1), dataset)
        label = sample(:, end)

        % If our guess was correct -> Add the correct counter
        if (prediction == label)
            correct = correct + 1
        endif

        i = i - 1
    endwhile

    printf("=====================================\n")
    printf("Accuracy: %f\n", correct / orig_size)
    printf("=====================================\n")
endfunction