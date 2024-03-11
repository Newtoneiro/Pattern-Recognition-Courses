function pdf = pdf_indep(pts, para)
% Computes probability density function assuming feature independence
% pts  - contains points for which pdf is computed (sample = row)
% para - structure containing parameters:
%	para.labels - class labels
%	para.mu - features' mean values (row per class)
%	para.sig - features' standard deviations (row per class)
% pdf - probability density matrix
%	row count = number of samples in pts
%	column count = number of classes

	% final result matrix
	pdf = zeros(rows(pts), rows(para.mu));
	
	% intermediate (one dimensional) density matrix
	onedpdfs = zeros(rows(pts), columns(para.mu));
	
	% YOUR CODE GOES HERE
	
	% for each class
	for clid = 1:rows(para.labels)
		% for each feature
		for fid = 1:columns(para.mu)
			% fill proper column in onedpdfs matrix
			onedpdfs(:, fid) = normpdf(pts(:, fid), para.mu(clid, fid), para.sig(clid, fid))
		% aggregate onedpdfs into one column of pdf matrix
		end
		% The features are independent thus pdf(x, y) = pdf(x) * pdf(y)
		pdf(:, clid) = prod(onedpdfs, 2)
	end
end
