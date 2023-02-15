cmake_minimum_required(VERSION 3.6)
project(my-bela-project VERSION 0.1.0)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O3 -g -fPIC -ftree-vectorize -ffast-math")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3  -g -fPIC -ftree-vectorize -ffast-math")

if(BELA_SYSROOT STREQUAL "")
    message(FATAL_ERROR "BELA_SYSROOT was not provided")
endif()
if(LINARO_ROOT STREQUAL "")
    message(FATAL_ERROR "LINARO_ROOT was not provided")
endif()

include_directories(
    ${BELA_SYSROOT}/usr/local/include
    ${BELA_SYSROOT}/root/Bela/include
    ${BELA_SYSROOT}/usr/xenomai/include
    ${BELA_SYSROOT}/usr/include

    ${LINARO_ROOT}/arm-linux-gnueabihf/include/c++/7.5.0
    ${LINARO_ROOT}/arm-linux-gnueabihf/libc/usr/include
    ${LINARO_ROOT}/include
    ${LINARO_ROOT}/arm-linux-gnueabihf/include/c++/7.5.0/arm-linux-gnueabihf
    ${LINARO_ROOT}/lib/gcc/arm-linux-gnueabihf/7.5.0/include
)

link_directories(
    ${LINARO_ROOT}/lib
    ${LINARO_ROOT}/arm-linux-gnueabihf/lib
    ${LINARO_ROOT}/arm-linux-gnueabihf/libc/lib

    ${BELA_SYSROOT}/usr/lib/arm-linux-gnueabihf
    ${BELA_SYSROOT}/usr/local/lib
    ${BELA_SYSROOT}/usr/lib
    ${BELA_SYSROOT}/usr/xenomai/lib
    ${BELA_SYSROOT}/root/Bela/lib
)

link_libraries(
    cobalt modechk pthread rt
    prussdrv asound seasocks NE10 mathneon dl
    pd atomic
)

set(BELA_LINK_FLAGS "${BELA_LINK_FLAGS} \
    -B${LINARO_ROOT}/lib/gcc/arm-linux-gnueabihf/7.5.0/ \
    -Wl,-rpath-link,${LINARO_ROOT}/arm-linux-gnueabihf/lib/"
)
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${BELA_LINK_FLAGS}")
set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} ${BELA_LINK_FLAGS}")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${BELA_LINK_FLAGS}")

add_library(sndfile STATIC IMPORTED)
set_target_properties(sndfile PROPERTIES IMPORTED_LOCATION "${BELA_SYSROOT}/usr/lib/arm-linux-gnueabihf/libsndfile.a")
target_link_libraries(sndfile INTERFACE
    FLAC
    ogg
    vorbis
    vorbisenc
)

add_subdirectory(src)

#  === TESTING ===
# if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
#     include(CTest)
# endif()

# if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME AND BUILD_TESTING)
#     add_subdirectory(tests)
#     set_property(GLOBAL PROPERTY CTEST_TARGETS_ADDED 1)
# endif()