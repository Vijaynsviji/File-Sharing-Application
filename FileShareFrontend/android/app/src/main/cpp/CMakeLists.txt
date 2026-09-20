cmake_minimum_required(VERSION 3.22.1)

if(ANDROID_ABI STREQUAL "arm64-v8a")
    set(VCPKG_TARGET_TRIPLET "arm64-android" CACHE STRING "")
elseif(ANDROID_ABI STREQUAL "x86_64")
    set(VCPKG_TARGET_TRIPLET "x64-android" CACHE STRING "")
elseif(ANDROID_ABI STREQUAL "armeabi-v7a")
    set(VCPKG_TARGET_TRIPLET "arm-neon-android" CACHE STRING "")
else()
    message(FATAL_ERROR "Unsupported Android ABI: ${ANDROID_ABI}")
endif()

project(file_share_engine)


set(BACKEND_DIR
        ${CMAKE_CURRENT_LIST_DIR}/../../../../../../FileShareBackend
)

add_subdirectory(
        ${BACKEND_DIR}
        backend
)

add_library(
        file_share_engine
        SHARED
        native_bridge.cpp
)

target_link_libraries(
        file_share_engine
        PRIVATE
        FileShareCore
)