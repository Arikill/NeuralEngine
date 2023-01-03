%% Neuronal Properties
neuron_properties = {};
neuron_properties.fs = 1e4;
neuron_properties.C = 6e-11;
neuron_properties.R = 0.2e9;
neuron_properties.Et = -62e-3;
neuron_properties.Er = -65e-3;
neuron_properties.Emax = 0e-3;
neuron_properties.Trfrc = 0.002;

%% Excitatory Synapse Properties
synE_properties = {};
synE_properties.fs = 1e4;
synE_properties.tau = 0.01;
synE_properties.gain = 1e-9;
synE_properties.Erev = -45e-3;
synE_properties.delay = 0.005;
synE_properties.taup = 0.01;

%% Inhibitory Synapse Properties
synI_properties = {};
synI_properties.fs = 1e4;
synI_properties.tau = 0.02;
synI_properties.gain = 1e-9;
synI_properties.Erev = -70e-3;
synI_properties.delay = 0.005;
synI_properties.taup = 0.01;

%% NMDA Synapse Properties
neuron_properties = {};
neuron_properties.fs = 1e4;
neuron_properties.C = 6e-11;
neuron_properties.R = 0.2e9;
neuron_properties.Et = -62e-3;
neuron_properties.Er = -65e-3;
neuron_properties.Emax = 0e-3;
neuron_properties.Trfrc = 0.002;

%% Excitatory Synapse Properties
synE2_properties = {};
synE2_properties.fs = 1e4;
synE2_properties.tau = 0.03;
synE2_properties.gain = 0e-9;
synE2_properties.Erev = -45e-3;
synE2_properties.Et = -63e-3;
synE2_properties.delay = 0.005;
synE2_properties.taup = 0.01;

%% Building a neuron
neuron = Neuron(neuron_properties, synE_properties, synI_properties, synE2_properties);
% eventsE = sort(rand(1, 20));
% eventsI = sort(rand(1, 20));
times = linspace(0, 1, 1e4);
[res, neuron, ge, gi] = neuron.propagate(eventsE, eventsI, times);
figure();
tiledlayout(2, 1);
nexttile;
plot(times, neuron.V);
nexttile;
plot(times, ge, 'r', times, gi, 'b');
% figure(2);
% plot(diff(eventsE), 'r');
% hold on;
% plot(diff(eventsI), 'b');
% hold off;