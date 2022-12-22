#pragma once

#ifndef _NEURON_H
#define _NEURON_H

template<class T>
class Neuron {
public:
    T C;
    T R;
    T Er;
    T V;
    Synapse<T> SynE;
    Synapse<T> SynI;

    Neuron(T C, T R, T Er, T V, Synapse<T> SynE, Synapse<T> SynI) {
        this->C = C;
        this->R = R;
        this->Er = Er;
        this->V = V;
        this->SynE = SynE;
        this->SynI = SynI;
    }
};

#endif