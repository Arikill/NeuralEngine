classdef Synapse
    properties
        fs
        tau
        gain
        Erev
    end

    methods
        function obj = Synapse(fs, tau, gain, Erev)
            obj.fs = fs;
            obj.tau = tau;
            obj.gain = gain;
            obj.Erev = Erev;
        end

        function responses = alpha(obj, event_times, times)
            exponents = (times > event_times').*(times - event_times')./obj.tau;
            responses = obj.gain.*exponents.*exp(1-exponents);
        end

        function output = propagate(obj, event_times, times)
            responses = obj.alpha(event_times, times);
            output = mean(responses, 1);
        end

        function I = update(obj, event_times, times, V)
            g = obj.propagate(event_times, times);
            I = g.*(V - obj.Erev);
        end
    end
end