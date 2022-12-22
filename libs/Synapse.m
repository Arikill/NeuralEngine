classdef Synapse
    properties
        fs
        tau
        gain
        erev
        taup
        trfc
    end

    methods
        function obj = Synapse(fs, tau, gain, erev, taup, trfc)
            obj.fs = fs;
            obj.tau = tau;
            obj.gain = gain;
            obj.erev = erev;
            obj.taup = taup;
            obj.trfc = trfc;
        end

        function new_event_times = check_refractory_period(obj, event_times)
            nevents = size(event_times, 2);
            new_event_times = [];
            new_event_times(end+1) = event_times(1);
            for i = 2:nevents
                if ((event_times(i) - event_times(i-1)) > obj.trfc)
                    new_event_times(end+1) = event_times(i);
                end
            end
        end

        function responses = alpha(obj, event_times, times)
            exponents = (times > event_times').*(times - event_times')./obj.tau;
            responses = exponents.*exp(1-exponents);
        end

        function output = propagate(obj, event_times, times)
            event_times = obj.check_refractory_period(event_times);
            responses = obj.alpha(event_times, times);
            output = obj.gain.*normalize(mean(responses, 1), 'range');
        end

        function I = update(obj, event_times, times, V)
            g = obj.propagate(event_times, times);
            I = g.*(V - obj.Erev);
        end
    end
end