function plotArm(xe, ye, xwr, ywr, nArms, T)
armx = [zeros(1,size(xe,2)); xe; xwr];
army = [zeros(1,size(xe,2)); ye; ywr];

figure;

iterationStep = fix(size(xe, 2)/nArms);
nArms = size(armx(:, 1:iterationStep:end), 2);  % Number of arms to plot
colororder(parula(nArms));
ll = plot(armx(:, 1:iterationStep:end),army(:, 1:iterationStep:end));
for l=ll'
    l.Color(4) = 0.75;
end
hold on;
axis equal;

nTrajSamples = size(xwr,2);
surface([xwr;xwr], [ywr;ywr], [zeros(1, nTrajSamples); zeros(1, nTrajSamples)], ...
        [linspace(0,nArms,nTrajSamples); linspace(0,nArms,nTrajSamples)], 'facecol','no',...
        'edgecol','interp',...
        'linew',2)
xlabel("Cartesian X (m)")
ylabel("Cartesian Y (m)")
cb = colorbar;
ylabel(cb, "Time (s)")
cb.Ticks=linspace(0, nArms, 5);
cb.TickLabels = linspace(0, T, 5);
plot(0, 0, 'o', 'Color','k')
text(0, 0, '\uparrow Shoulder', 'VerticalAlignment', 'top')

plot(xwr(end), ywr(end), 'o', 'Color','k')
text(xwr(end), ywr(end), ' \leftarrow Hand', 'VerticalAlignment','baseline', 'HorizontalAlignment', 'left')
end

