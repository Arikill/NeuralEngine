#include "headers.h"

int main(int argc, char* argv[]) {
    auto ts = timeseries<float>(0.0, 1.0, 1e4);
    auto times = ts.generate_time();
    auto events = ts.generate_random_events(10, 0.998);
    return 0;
}