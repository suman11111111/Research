% Define the number of agents and the size of the formation
numAgents = 5;
formationSize = 2;

% Define the initial positions of the agents in a circle
initialPositions = formationSize * [cos(linspace(0, 2*pi, numAgents)); sin(linspace(0, 2*pi, numAgents))];

% Define the desired formation positions as a square
desiredPositions = formationSize * [-1 -1 1 1; -1 1 1 -1];

% Define the obstacle position and radius
obstaclePosition = [0.5; 0.5];
obstacleRadius = 0.2;

% Define the simulation time step and duration
dt = 0.01;
duration = 10;

% Define the control gains
kP = 1;
kV = 1;

% Initialize the agent positions and velocities
positions = initialPositions;
velocities = zeros(2, numAgents);

% Run the simulation
for t = 0:dt:duration
    % Compute the inter-agent distances and angles
    distances = sqrt(sum((positions - positions(:, 1)).^2, 1));
    angles = atan2(positions(2, :) - positions(2, 1), positions(1, :) - positions(1, 1));
    
    % Compute the formation errors
    formationErrors = positions(:, 2:end) - desiredPositions(:, 2:end);
    
    % Compute the obstacle avoidance velocities
    obstacleVelocities = zeros(2, numAgents);
    for i = 1:numAgents
        if distances(i) < obstacleRadius
            obstacleDirection = positions(:, i) - obstaclePosition;
            obstacleVelocity = kV * (obstacleRadius - distances(i)) * obstacleDirection / distances(i);
            obstacleVelocities(:, i) = obstacleVelocity;
        end
    end
    
    % Compute the control velocities
    controlVelocities = kP * formationErrors - kV * velocities(:, 2:end) + obstacleVelocities(:, 2:end);
    
    % Update the positions and velocities
    positions(:, 2:end) = positions(:, 2:end) + velocities(:, 2:end) * dt;
    velocities(:, 2:end) = velocities(:, 2:end) + controlVelocities * dt;
end

% Plot the final positions of the agents and the obstacle
figure;
plot(positions(1, :), positions(2, :), 'bo');
hold on;
rectangle('Position', [obstaclePosition(1) - obstacleRadius, obstaclePosition(2) - obstacleRadius, 2 * obstacleRadius, 2 * obstacleRadius], 'Curvature', [1 1], 'FaceColor', 'r');
axis equal;