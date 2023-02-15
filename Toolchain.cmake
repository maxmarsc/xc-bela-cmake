
# targets
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR armv7a)
set(triple arm-linux-gnueabihf)

# misc settings
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")
set(LINARO_ROOT "/usr/local/linaro/arm-bela-linux-gnueabihf")
set(BELA_SYSROOT "/usr/local/linaro/BelaSysroot")
set(CMAKE_SYSROOT "/usr/local/linaro/arm-bela-linux-gnueabihf/arm-linux-gnueabihf/libc")

# compiler settings
set(CMAKE_C_COMPILER "${LINARO_ROOT}/bin/arm-linux-gnueabihf-gcc" CACHE INTERNAL "")
set(CMAKE_CXX_COMPILER "${LINARO_ROOT}/bin/arm-linux-gnueabihf-g++" CACHE INTERNAL "")

set(CMAKE_C_COMPILER_TARGET ${triple})
set(CMAKE_CXX_COMPILER_TARGET ${triple})

## LINARO
set(CMAKE_C_COMPILER_EXTERNAL_TOOLCHAIN "${LINARO_ROOT}/lib/gcc")
set(CMAKE_CXX_COMPILER_EXTERNAL_TOOLCHAIN "${LINARO_ROOT}/lib/gcc")

# compiler args
set(CMAKE_C_FLAGS "-DXENOMAI_SKIN_posix -march=armv7-a -mtune=cortex-a8 -mfloat-abi=hard -mfpu=neon" CACHE STRING "")
set(CMAKE_CXX_FLAGS "-DXENOMAI_SKIN_posix -march=armv7-a -mtune=cortex-a8 -mfloat-abi=hard -mfpu=neon" CACHE STRING "")

set(CMAKE_CROSSCOMPILING_EMULATOR "qemu-arm-static;-L;${LINARO_ROOT}/arm-linux-gnueabihf/libc/" CACHE FILEPATH "Path to the emulator for the target system.")