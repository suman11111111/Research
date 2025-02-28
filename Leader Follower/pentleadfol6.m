clear, clc

% Number of agents (including the leader)
num_agents = 5; % 1 leader and 4 followers to form a pentagon

% Time parameters
t_span = [0, 10]; % Simulation time span
dt = 0.1; % Time step

% Define the leader's trajectory (e.g., a circular path for a pentagon)
leader_speed = 1.0;
leader_radius = 5.0;

% Define gains for control laws
k_p = 1.0; % Proportional gain
k_v = 0.5; % Velocity gain

% Video settings
video_filename = 'simulation_video.avi';
frame_rate = 10; % Frames per second

% Create a VideoWriter object to save the video
video = VideoWriter(video_filename);
video.FrameRate = frame_rate;

open(video); % Open the video file

% Simulation loop
t = t_span(1);
leader_position = [leader_radius, 0]; % Initial leader position

% Random initial positions for followers
theta_offset = 2 * pi / (num_agents); % Offset angle for followers
follower_initial_positions = zeros(num_agents - 1, 2);

for i = 1:num_agents - 1
    theta = (i - 1) * theta_offset;
    follower_initial_positions(i, :) = [leader_radius * cos(theta), leader_radius * sin(theta)];
end

% Initialize agent positions and velocities
agent_positions = [leader_position; follower_initial_positions];
agent_velocities = zeros(num_agents, 2);

while t < t_span(2)
    % Update time
    t = t + dt;
    
    % Compute leader position at the current time
    leader_position = [leader_radius * cos(leader_speed * t), leader_radius * sin(leader_speed * t)];
    
    % Loop through all agents (including the leader)
    for i = 1:num_agents
        % Compute the desired formation position based on the leader's position
        if i == 1  % Leader
            desired_position = leader_position;
        else
            % Follower's control law (proportional control to form a pentagon)
            theta = (i - 1) * theta_offset; % Angle for the ith follower
            offset = [leader_radius * cos(leader_speed * t + theta), leader_radius * sin(leader_speed * t + theta)];
            desired_position = offset;
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
    
    % Plot the leader with a red marker
    hold on;
    scatter(agent_positions(1, 1), agent_positions(1, 2), 'filled', 'r');
    hold off;
    
    drawnow;
    
    % Capture the current frame and add it to the video
    frame = getframe(gcf);
    writeVideo(video, frame);
end

close(video); % Close the video file

