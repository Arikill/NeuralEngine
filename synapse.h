#pragma once

#ifndef _SYNAPSE_H
#define _SYNAPSE_H

template <class T>
class Synapse {
public:
    Eigen::Matrix<T, 5, 1> params;

    Synapse(T tau, T gain, T fs, T Erev, T rfrc) {
        this->params(0, 0) = tau;
        this->params(1, 0) = gain;
        this->params(2, 0) = Erev;
        this->params(3, 0) = rfrc;
    }

    void alpha(int ntimes, T event_time, std::vector<T> &times, std::vector<T> &output) {
        std::vector<T> exponent(ntimes, 0.0);
        for(int t = 0; t < ntimes; t++) {
            if (times[t] >= event_time) {
                exponent[t] = (times[t] - event_time)/this->tau;
            }
            output[t] = this->gain*exponent[t]*exp(1-exponent[t]);
        }
    }

    std::vector<T> get_response(std::vector<int> &events, std::vector<T> &times) {
        int ntimes = times.size();
        auto event_times = this->get_event_times(events);
        int nevents = filtered_times.size();
        Eigen::Matrix<T, nevents, ntimes> res;
        
        std::vector<std::vector<T>> nres(nevents, std::vector<T>(ntimes, 0));
        std::vector<T> res(ntimes, 0.0);
        for(int n = 0; n < nevents; n++) {
            this->alpha(ntimes, filtered_times[n], times, nres[n]);
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