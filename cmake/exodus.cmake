# SEACAS is a TriBITS project and can't be add_subdirectory'd, so build only
# its Exodus C library. Defines target `exodus` and points Omega_h at it.
set(EXO ${CMAKE_SOURCE_DIR}/contrib/seacas/packages/seacas/libraries/exodus)
find_package(netCDF CONFIG REQUIRED)

file(GLOB EXO_SRC ${EXO}/src/ex_*.c ${EXO}/src/deprecated/ex_*.c)
list(REMOVE_ITEM EXO_SRC ${EXO}/src/ex_threadsafe.c)
file(WRITE ${CMAKE_BINARY_DIR}/exodus_gen/exodus_config.h "#pragma once\n")

add_library(exodus ${EXO_SRC})
target_include_directories(exodus PUBLIC ${EXO}/include ${CMAKE_BINARY_DIR}/exodus_gen)
target_link_libraries(exodus PUBLIC netCDF::netcdf)
set_target_properties(exodus PROPERTIES C_STANDARD 99 C_EXTENSIONS ON POSITION_INDEPENDENT_CODE ON)

# Omega_h's XSDK mode accepts our own library instead of find_package(SEACASExodus)
set(USE_XSDK_DEFAULTS ON)
set(TPL_ENABLE_SEACASExodus ON CACHE BOOL "" FORCE)
set(TPL_SEACASExodus_LIBRARIES exodus CACHE STRING "" FORCE)
