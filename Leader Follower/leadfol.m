clc,clear
% Number of agents (including the leader)
num_agents = 5;

% Time parameters
t_span = [0, 10]; % Simulation time span
dt = 0.1; % Time step

% Initial positions and velocities of agents
initial_positions = rand(num_agents, 2) * 10; % Random initial positions
initial_velocities = zeros(num_agents, 2); % Initial velocities

% Define the leader's trajectory (e.g., a circle)
leader_speed = 1.0;
leader_radius = 5.0;
leader_trajectory = @(t) [leader_radius * cos(leader_speed * t), leader_radius * sin(leader_speed * t)];

% Define gains for control laws
k_p = 1.0; % Proportional gain
k_v = 0.5; % Velocity gain

% Simulation loop
t = t_span(1);
agent_positions = initial_positions;
agent_velocities = initial_velocities;

while t < t_span(2)
    % Update time
    t = t + dt;
    
    % Compute leader position at the current time
    leader_position = leader_trajectory(t);
    
    % Loop through all agents (including the leader)
    for i = 1:num_agents
        % Compute the desired formation position based on the leader's position
        if i == 1  % Leader
            desired_position = leader_position;
        else
            % Follower's control law (e.g., proportional control)
            error = leader_position - agent_positions(i, :);
            desired_position = agent_positions(i, :) + k_p * error;
        end
        
        % Compute control inputs to reach the desired position
        control_input = k_p * (desired_position - agent_positions(i, :)) + k_v * (0 - agent_velocities(i, :));
        
        % Update agent velocities and positions using a simple Euler integration
        agent_velocities(i, :) = agent_velocities(i, :) + control_input * dt;
        agent_positions(i, :) = agent_positions(i, :) + agent_velocities(i, :) * dt;
    end
    
    % Visualization (you can use plot or any visualization tool)
    scatter(agent_positions(:, 1), agent_positions(:, 2), 'filled');
    axis equal;
    xlim([-10, 10]);
    ylim([-10, 10]);
    drawnow;
end
