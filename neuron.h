#pragma once

#ifndef _NEURON_H
#define _NEURON_H

template<class T>
class Neuron {
public:
    T C;
    T R;
    T Er;
    std::vector<T> V;
    Synapse<T> SynE;
    Synapse<T> SynI;

    Neuron(T C, T R, T Er, T V, Synapse<T> SynE, Synapse<T> SynI) {
        this->C = C;
        this->R = R;
        this->Er = Er;
        this->V.resize(0);
        this->SynE = SynE;
        this->SynI = SynI;
    }

    propagate(std::vector<T> &Eevents, std::vector<T> &Ievents, std::vector<T> &times) {
        auto ge = this->SynE->get_response(Eevents, times);
        auto gi = this->SynI->get_response(Ievents, times);
        if (times->size() != this->V.size()) {
            this->V.resize(times->size(), static_cast<T>(0));
        }
        for(int i = 1; i < this->V.size())
    }
};

#endif