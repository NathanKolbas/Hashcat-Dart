cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(native_add VERSION 1.0.0 LANGUAGES C)
add_library(native_add SHARED add.c add.def)
add_executable(add add.c)

set_target_properties(native_add PROPERTIES
    PUBLIC_HEADER add.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "add"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)
