#pragma once

#ifndef _SYNAPSE_H
#define _SYNAPSE_H

template <class T>
class Synapse {
public:
    T tau;
    T gain;
    T fs;
    T Erev;
    T refrc;

    Synapse(T tau, T gain, T fs, T Erev, T refrc) {
        this->tau = tau;
        this->gain = gain;
        this->fs = fs;
        this->Erev = Erev;
        this->refrc = refrc;
    }

    std::vector<T> remove_sub_refractory_inputs(std::vector<T> &event_times) {
        int nevents = event_times.size();
        std::vector<T> filtered_times(1, 0);
        filtered_times[0] = event_times[0];
        for(int i = 1; i < nevents; i++) {
            if ((event_times[i] - event_times[i-1]) > this->refrc) {
                filtered_times.push_back(event_times[i]);
            }
        }
        return filtered_times;
    }

    std::vector<T> get_event_times(std::vector<int> const &events) {
        int nevents = events.size();
        std::vector<T> event_times(nevents, 0.0);
        for(int i = 0; i < nevents; i++) {
            event_times[i] = static_cast<T>(events[i])/this->fs;
        }
        return event_times;
    }

    void alpha(T event_time, std::vector<T> &times, int ntimes, std::vector<T> &output) {
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
        auto event_times = this->get_event_times(events);
        auto filtered_times = this->remove_sub_refractory_inputs(event_times);
        int nevents = filtered_times.size();
        std::vector<std::vector<T>> nres(nevents, std::vector<T>(ntimes, 0));
        std::vector<T> res(ntimes, 0.0);
        for(int n = 0; n < nevents; n++) {
            this->alpha(filtered_times[n], times, ntimes, nres[n]);
        }
        for (int t = 0; t < ntimes; t++) {
            for (int n = 0; n < nevents; n++) {
                res[t] += nres[n][t];
            }
            res[t] = res[t]/(static_cast<float>(nevents));
        }
        return res;
    }

};
#endif