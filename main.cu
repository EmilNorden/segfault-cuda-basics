#include <iostream>
#include <array>

template <size_t N>
std::array<float, N> add_on_gpu(const std::array<float, N> &a, const std::array<float, N> &b) {
    std::array<float, N> results{};

    // Get some data onto the GPU

    // Run our fancy CUDA logic

    // Get our data back from the GPU

    return results;
}

int main() {

    auto result = add_on_gpu<3>(
            {1,2,3},
            {10,20,30});

    for(auto x : result) {
        std::cout << x << "\n";
    }

    return 0;
}
