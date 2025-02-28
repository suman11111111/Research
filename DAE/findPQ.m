% Define example matrices A and B
A = [1, 2; 3, 4];
B = [5, 6; 7, 8];

% Call the function
[P, Q] = findPQ(A, B);

% Display results
disp('Matrix P:');
disp(P);

disp('Matrix Q:');
disp(Q);

% Verify the result
B_computed = Q * A * P;
disp('Computed B:');
disp(B_computed);

% Compute Frobenius norm of the error
error_norm = norm(B - B_computed, 'fro');
disp(['Frobenius norm of error: ', num2str(error_norm)]);
