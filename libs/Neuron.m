classdef Neuron
    properties
        fs
        C
        R
        V
        Et
        Er
        Emax
        Trfrc
        SynE
        SynI
        SynNMDA
    end

    methods
        function obj = Neuron(props, synE_props, synI_props, nmda_props)
            obj.fs = props.fs;
            obj.C = props.C;
            obj.R = props.R;
            obj.Et = props.Et;
            obj.Er = props.Er;
            obj.Emax = props.Emax;
            obj.Trfrc = props.Trfrc;
            obj.SynE = Synapse(synE_props);
            obj.SynI = Synapse(synI_props);
%             obj.SynNMDA = NMDASynapse(nmda_props);
            if nargin >= 4
                obj.SynNMDA = NMDASynapse(nmda_props);
            else
                obj.SynNMDA = [];
            end
        end
        
        function new_event_times = enforce_refractory_period(obj, event_times)
            nevents = size(event_times, 2);
            if nevents <= 0
                new_event_times = event_times;
                return;
            end
            new_event_times = zeros(1, 1);
            new_event_times(1, 1) = event_times(1);
            for i = 2:nevents
                if ((event_times(i) - event_times(i-1)) > obj.Trfrc)
                    new_event_times(1, end+1) = event_times(i);
                end
            end
        end

        function [spikeTimes, obj, ge, gi, gnmda] = propagate(obj, I, eventsE, eventsI, times)
            if (size(obj.V, 2) ~= size(times, 2))
                obj.V = zeros(1,size(times, 2))+obj.Er;
            end
            ge = obj.SynE.propagate(eventsE, times);
            gi = obj.SynI.propagate(eventsI, times);
            if ~isempty(obj.SynNMDA)
                gnmda = obj.SynNMDA.propagate(eventsE, times);
            else
                gnmda = 0.*ge;
            end
            for i = 2: size(times, 2)
                obj.V(1, i) = obj.V(1, i-1) + (1/obj.fs).*(1/obj.C).*(I - ...
                    (1/obj.R).*(obj.V(1, i-1) - obj.Er) - ...
                    ge(1, i-1).*(obj.V(1, i-1) - obj.SynE.Erev) - ...
                    gnmda(1, i-1).*(obj.V(1, i-1) - obj.SynNMDA.Erev).*(obj.V(1, i-1) > obj.SynNMDA.Et) - ...
                    gi(1, i-1).*(obj.V(1, i-1) - obj.SynI.Erev));
            end
            spikeTimes = find((obj.V >= obj.Et).*times)./obj.fs;
            spikeTimes = obj.enforce_refractory_period(spikeTimes);
        end
    end
end