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

    std::vector<T> generate_times_for_events(std::vector<int> const &events) {
        int n = events.size();
        std::vector<T> times(n, 0.0);
        for(int i = 0; i < n; i++) {
            times[i] = events[i]/this->fs;
        }
        return times;
    }

    std::vector<T> generate_time() {
        int n = this->get_samples();
        std::vector<T> times(n);
        for(int i = 0; i < n; i++) {
            times[i] = this->tstart + static_cast<T>(i)/this->fs;
        }
        return times;
    }

    std::vector<int> generate_n_random_events(int n) {
        std::vector<int> events(n, 0);
        int min = static_cast<int>(this->tstart*this->fs);
        int max = static_cast<int>(this->tend*this->fs);
        std::minstd_rand gen(std::random_device{}());
        std::uniform_int_distribution dist(min, max);
        for (int i = 0; i < n; i++) {
            events[i] = dist(gen);
        }
        std::sort(events.begin(), events.end());
        return events;
    }
};

#endif