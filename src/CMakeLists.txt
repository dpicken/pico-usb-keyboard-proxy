cmake_minimum_required(VERSION 3.12)

include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)

project(pico-usb-keyboard-proxy C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()

add_executable(pico-usb-keyboard-proxy
        main.cc
        )

target_link_libraries(pico-usb-keyboard-proxy pico_stdlib)

pico_add_extra_outputs(pico-usb-keyboard-proxy)
