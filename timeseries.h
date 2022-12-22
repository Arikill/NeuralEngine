#pragma once

#ifndef _TIMESERIES_H
#define _TIMESERIES_H

template <class T>
class Timeseries {
public:
    T tstart;
    T tend;
    T fs;
    Timeseries(T tstart, T tend, T fs) {
        this->tstart = tstart;
        this->tend = tend;
        this->fs = fs;
    }

    int get_samples() {
        return static_cast<int>(this->fs*(this->tend - this->tstart));
    }

    std::vector<T> generate_time() {
        int n = this->get_samples();
        std::vector<T> times(n);
        for(int i = 0; i < n; i++) {
            times[i] = this->tstart + static_cast<T>(i)/this->fs;
        }
        return times;
    }

    std::vector<int> generate_random_events(int nevents, T threshold) {
        int n = this->get_samples();
        std::vector<int> events(nevents, 0);
        int evt_cnt = 0;
        std::minstd_rand gen(std::random_device{}());
        std::uniform_real_distribution<T> dist(0, 1);
        for(int i = 0; i < n; i++) {
            if (dist(gen) >= threshold) {
                events[evt_cnt] = i;
                evt_cnt++;
                if (evt_cnt >= nevents) break;
            }
        }
        return events;
    }

};

#endif