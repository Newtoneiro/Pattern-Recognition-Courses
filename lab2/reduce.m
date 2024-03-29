function rds = reduce(ds, parts)
% Function reducing samples count of individual classes in ds
% ds - data set to be reduced (sample = row; in the first column labels)
% parts - row vector of reduction coefficients for individual classes
%	(1 means no reduction; 0 means no samples of given class to be left)
% rds - reduced data set

	labels = unique(ds(:,1));
	if rows(labels) ~= columns(parts)
		error("Class number does not agree with the coefficients number.");
	end

	if max(parts) > 1 || min(parts) < 0
		error("Invalid reduction coefficients.");
	end

	% YOUR CODE GOES HERE
	
	rds = [];
	% for each class
	for clid = 1:rows(labels);
		% select only one class samples from ds
		selected_classes = ds(ds(:, 1) == clid, :);
		% shuffle samples of this class with randperm
		shuffled = randperm(rows(selected_classes));
		% select proper part of shuffled class and append it to rds
		cut_idx = round(parts(clid) * columns(shuffled));
		rds = [rds; selected_classes(shuffled(1:cut_idx), :)];
	end
end
