X=double(input('Enter Matrix: '));
disp('\begin{bmatrix}');
for i = 1:size(X, 1)
    row = sprintf('%.2f & ', X(i, :));  % Format each row
    row = row(1:end-2);  % Remove the last '&'
    disp([row ' \\']);  % Print the row with '\\'
end
disp('\end{bmatrix}');
