neuron = Neuron(1e4, 0.001, 1, 0.8, 0, 0.01, 1, 0.5, 0.02, 1, -0.5);
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