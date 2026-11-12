cmake_minimum_required(VERSION 3.20)
project(anisotropic_omega_h LANGUAGES C CXX)

include(cmake/exodus.cmake)

set(BUILD_TESTING OFF)
add_subdirectory(contrib/omega_h)

add_executable(exo2vtk example/main.cpp)
target_link_libraries(exo2vtk PRIVATE omega_h)
