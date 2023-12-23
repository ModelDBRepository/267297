function [im] = vecToIm(X,n,m)
% n = rows
% m = columns
% X = column vector

im=X(1:m)';
for k=1:n-1
   im=[im; X(k*m+1:k*m+m)'];
end

end

