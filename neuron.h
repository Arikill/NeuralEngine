#pragma once

#ifndef _NEURON_H
#define _NEURON_H

template<class T>
class neuron {
public:
    T C;
    T R;
    T Er;
    T V;

    neuron(T C, T R, T Er, T V) {
        this->C = C;
        this->R = R;
        this->Er = Er;
        this->V = V;
    }
};

#endif