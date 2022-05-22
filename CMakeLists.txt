cmake_minimum_required(VERSION 3.22)
project(cuda_basics CUDA)

set(CMAKE_CUDA_STANDARD 17)

add_executable(cuda_basics main.cu)

set_target_properties(cuda_basics PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)
