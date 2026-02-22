function [] = forceGraph()
    % 1. Strut Dimensions (mm)
    w = 50; h = 2000; d = 50; 
    
    figure('Color', 'w');
    hold on; grid on;

    % 2. Draw Strut Outline (Wireframe)
    % Define the 8 corners
    v = [-w/2 0 -d/2;  w/2 0 -d/2;  w/2 0 d/2;  -w/2 0 d/2; ...
         -w/2 h -d/2;  w/2 h -d/2;  w/2 h d/2;  -w/2 h d/2];
    % Define the 12 edges connecting the corners
    edges = [1 2; 2 3; 3 4; 4 1; 5 6; 6 7; 7 8; 8 5; 1 5; 2 6; 3 7; 4 8];
    for i = 1:size(edges,1)
        plot3(v(edges(i,:),1), v(edges(i,:),2), v(edges(i,:),3), 'k:', 'LineWidth', 0.5);
    end

    % 3. Force Data
    yA = 1960; yB = 40; yFan = 1000;
    yC = 1038.1; yD = 961.9; % Fixed yD to be consistent with 3" spacing
    
    origins = [0, yA, 0; 0, yB, 0; 0, yC, 0; 0, yD, 0; 0, yFan, -74.6];
    
    % Vectors (Rx, Ry, Rz)
    vectors = [-67.81, 545.84, 99.51;
               67.81,  545.84, 76.20;
               279.80, 295.84, 274.17;
               194.32, 295.84, -98.46;
               0, -300, -175.7];

    % 4. Plot Vectors
    colors = lines(5);
    scale = 0.8; % Adjusted scale for better visibility
    for i = 1:5
        quiver3(origins(i,1), origins(i,2), origins(i,3), ...
                vectors(i,1)*scale, vectors(i,2)*scale, vectors(i,3)*scale, ...
                'Color', colors(i,:), 'LineWidth', 2, 'AutoScale', 'off');
    end

    % 5. Labels and Formatting
    xlabel('X (Side-to-Side)'); ylabel('Y (Vertical)'); zlabel('Z (Rear-To-Front)');
    title('3D Force Vectors on Vertical Strut Outline');
    legend('Strut', 'Pin A', 'Pin B', 'Pin C', 'Pin D', 'Fan Load', 'Location', 'northeastoutside');
    view(-45, 30); 
    axis equal;
end