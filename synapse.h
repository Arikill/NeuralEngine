#pragma once

#ifndef _SYNAPSE_H
#define _SYNAPSE_H
template <class T>
class synapse {
public:
    T tau;
    T gain;
    T fs;
    synapse(T tau, T gain, T fs) {
        this->tau = tau;
        this->gain = gain;
        this->fs = fs;
    }

    std::vector<T> get_event_times(std::vector<int> &events) {
        int nevents = events.size();
        std::vector<T> event_times;
        for(int i = 0; i < nevents; i++) {
            event_times[i] = events[i]/this->fs;
        }
        return event_times;
    }

    void alpha_function(T event_time, std::vector<T> &times, int ntimes, std::vector<T> &output) {
        std::vector<T> exponent(ntimes, 0.0);
        for(int t = 0; t < ntimes; t++) {
            if (times[t] > event_time) {
                exponent[t] = (times[t] - event_time)/this->tau;
            }
            output[t] = this->gain*exponent[t]*exp(1-exponent[t]);
        }
    }

    std::vector<T> get_response(std::vector<int> &events, std::vector<T> &times) {
        int ntimes = times.size();
        int nevents = events.size();
        std::vector<std::vector<T>> nres(nevents, std::vector<T>(ntimes, 0));
        std::vector<T> res(ntimes, 0.0);
        for(int n = 0; n < nevents; n++) {
            this->alpha_function(events[n], times, ntimes, nres[n]);
        }
    }

};
#endif