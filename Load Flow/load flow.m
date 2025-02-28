% enter input: No of buses in the system
N = input('Enter the number of buses in the system: ');

% line data in a CSV file
filename = input('Enter the CSV file name with line data (e.g., "line_data.csv"): ', 's');
line_data = csvread(filename, 1, 0); % Assuming the data starts from the second row

% Display the first few rows of the imported data
disp(line_data);

% Initialize YBUS matrix
YBUS = zeros(N, N);

% Step 3: Loop through the line data to populate YBUS
for i = 1:size(line_data, 1)
    fromBus = line_data(i, 2);
    toBus = line_data(i, 3);
    resistance = line_data(i, 4);
    reactance = line_data(i, 5);
    shuntAdmittance = line_data(i, 6);
    tapRatio = line_data(i, 7);
    
    % Calculation of Z
    Z = (resistance + 1i * reactance) / tapRatio;
    
    % Formation YBUS matrix
    YBUS(fromBus, fromBus) = YBUS(fromBus, fromBus) + 1 / ((resistance + 1i*reactance) / abs(tapRatio^2)) + shuntAdmittance;
    YBUS(toBus, toBus) = YBUS(toBus, toBus) + (1 / (resistance + 1i * reactance)) + shuntAdmittance;
    YBUS(fromBus, toBus) = YBUS(fromBus, toBus) - 1 / Z;
    YBUS(toBus, fromBus) = YBUS(toBus, fromBus) - 1 / Z;
end

% Step 4: Count non-zero and zero entries
nonZeroEntries = nnz(YBUS);
zeroEntries = N^2 - nonZeroEntries;

fprintf('Total number of non-zero entries in YBUS: %d\n', nonZeroEntries);
fprintf('Total number of entries with zeros in YBUS: %d\n', zeroEntries);

