#include <iostream>
#include <array>

__global__ void add_kernel(float *a, float *b, float *result, size_t N) {
    auto index = threadIdx.x;
    if(index < N) {
        result[index] = a[index] + b[index];
    }
}

template <size_t N>
std::array<float, N> add_on_gpu(const std::array<float, N> &a, const std::array<float, N> &b) {
    std::array<float, N> results{};
    // Get some data onto the GPU
    float *device_array_a;
    cudaMalloc(&device_array_a, sizeof(float) * N);
    cudaMemcpy(device_array_a, a.data(), sizeof(float) * N, cudaMemcpyHostToDevice);

    float *device_array_b;
    cudaMalloc(&device_array_b, sizeof(float) * N);
    cudaMemcpy(device_array_b, b.data(), sizeof(float) * N, cudaMemcpyHostToDevice);

    float *device_results;
    cudaMalloc(&device_results, sizeof(float) * N);

    // Run our fancy CUDA logic
    add_kernel<<<1, N>>>(device_array_a, device_array_b, device_results, N);

    // Get our data back from the GPU
    cudaMemcpy(results.data(), device_results, sizeof(float) * N, cudaMemcpyDeviceToHost);

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
