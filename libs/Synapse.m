classdef Synapse
    properties
        fs
        tau
        gain
        Erev
        delay
        taup
        Et
    end

    methods
        function obj = Synapse(props)
            obj.fs = props.fs;
            obj.tau = props.tau;
            obj.gain = props.gain;
            obj.Erev = props.Erev;
            obj.delay = props.delay;
            obj.taup = props.taup;
            if isfield(props, 'Et')
                obj.Et = Et;
            else
                obj.Et = [];
            end
        end

        function responses = alpha(obj, event_times, times)
            exponents = (times > event_times').*(times - event_times')./obj.tau;
            responses = exponents.*exp(1-exponents);
        end

        function y = time_delay(obj, x)
            samples = floor(obj.delay*obj.fs);
            if samples <= 0
                y = x;
                return
            end
            xappend = zeros(1, samples)+x(1, 1);
            y = cat(2, xappend, x(1, 1:end-samples));
        end

        function output = propagate(obj, event_times, times)
            responses = obj.alpha(event_times, times);
            responses = obj.gain.*responses;
            output = obj.gain.*normalize(mean(responses, 1), 'range');
            output = obj.time_delay(output);
        end

        function I = update(obj, event_times, times, V)
            g = obj.propagate(event_times, times);
            I = g.*(V - obj.Erev);
        end
    end
end