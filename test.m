neuron = Neuron(1e4, 6e-11, 0.2e9, -45e-3, -65e-3, 0.01, 1e-9, -30e-3, 0, 0.002, 0.01, 1e-9, -90e-3, 0, 0.002);
eventsE = sort(rand(1, 20));
eventsI = sort(rand(1, 20));
times = linspace(0, 1, 1e4);
[res, neuron, ge, gi] = neuron.propagate(eventsE, eventsI, times);
figure(1)
tiledlayout(2, 1);
nexttile;
plot(times, neuron.V);
nexttile;
plot(times, ge, 'r', times, gi, 'b');
figure(2)
plot(diff(eventsE), 'r');
hold on;
plot(diff(eventsI), 'b');
hold off;