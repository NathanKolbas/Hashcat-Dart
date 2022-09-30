cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(hashcat VERSION 1.0.0 LANGUAGES C)

add_custom_target(Makefile COMMAND make run
                   WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/<subdir>
)
