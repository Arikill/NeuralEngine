#include "headers.h"

int main(int argc, char* argv[]) {
    auto ts = Timeseries<float>(0.0, 1.0, 1e3);
    auto times = ts.generate_time();
    auto events = ts.generate_n_random_events(10);
    auto syn = Synapse<float>(0.01, 1, 1e3, -0.2, 0.002);
    auto res = syn.get_response(events, times);
    for(int i = 0; i < times.size(); i++) {
        std::cout << times[i] << ": " << res[i] << std::endl;
    }
    return 0;
}