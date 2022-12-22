classdef Neuron
    properties
        fs
        C
        R
        I
        V
        Et
        Er
        SynE
        SynI
    end

    methods
        function obj = Neuron(fs, C, R, Et, Er, tauE, gainE, erevE, taupE, trfcE, tauI, gainI, erevI, taupI, trfcI)
            obj.fs = fs;
            obj.C = C;
            obj.R = R;
            obj.Et = Et;
            obj.Er = Er;
            obj.SynE = Synapse(fs, tauE, gainE, erevE, taupE, trfcE);
            obj.SynI = Synapse(fs, tauI, gainI, erevI, taupI, trfcI);
            obj.I = 0;
        end

        function [output, obj, ge, gi] = propagate(obj, eventsE, eventsI, times)
            output = [];
            if (size(obj.V, 2) ~= size(times, 2))
                obj.V = zeros(1,size(times, 2))+obj.Er;
            end
            ge = obj.SynE.propagate(eventsE, times);
            gi = obj.SynI.propagate(eventsI, times);
            for i = 2: size(times, 2)
                obj.V(1, i) = obj.V(1, i-1) + (1/obj.fs).*(1/obj.C).*(obj.I - ...
                    (1/obj.R).*(obj.V(1, i-1) - obj.Er) - ...
                    ge(1, i-1).*(obj.V(1, i-1) - obj.SynE.erev) - ...
                    gi(1, i-1).*(obj.V(1, i-1) - obj.SynI.erev));
                if (obj.V(1, i) > obj.Et)
                    output(1, end+1) = i;
                end
            end
        end
    end
end