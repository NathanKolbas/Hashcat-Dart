cmake_minimum_required(VERSION 3.0)
project(test_import)

set(CMAKE_VERBOSE_MAKEFILE on)
set(CMAKE_OSX_DEPLOYMENT_TARGET 12.0)
set(ANDROID_HOST_PREBUILTS_CLANG "${ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/bin/clang")

include(ExternalProject)
set(EXTERNAL_INSTALL_LOCATION ${CMAKE_BINARY_DIR}/hashcat-prefix/src/hashcat)
ExternalProject_Add(hashcat
        GIT_REPOSITORY https://github.com/hashcat/hashcat.git
        GIT_TAG 1cee512c09e96a5f9842260eb08f60c113878344
        CONFIGURE_COMMAND ""
        BUILD_COMMAND SHARED=1 make CC=${ANDROID_HOST_PREBUILTS_CLANG} CFLAGS="-target ${ANDROID_ABI}" -C ../hashcat
        INSTALL_COMMAND ""
        BUILD_BYPRODUCTS ${EXTERNAL_INSTALL_LOCATION}/libhashcat.so
        )

add_library(hashcat_lib SHARED IMPORTED)
add_dependencies(hashcat_lib hashcat)
set_target_properties(hashcat_lib
        PROPERTIES IMPORTED_LOCATION ${EXTERNAL_INSTALL_LOCATION}/libhashcat.so
        )



# "-Wl,-force_load,${EXTERNAL_INSTALL_LOCATION}/libhashcat.6.2.6.dylib"
add_library(test_import SHARED add.c)
target_link_libraries(test_import
        "-Wl,--whole-archive ${PROJECT_SOURCE_DIR}/src/main/cpp/libs/${ANDROID_ABI}/libhashcat.so -Wl,--no-whole-archive"
        hashcat_lib
        )
#target_link_libraries(test_import ${EXTERNAL_INSTALL_LOCATION}/libhashcat.6.2.6.dylib)
#add_dependencies(test_import extern_lib)

#project(test_import)

#include(ExternalProject)
#set(EXTERNAL_INSTALL_LOCATION ${CMAKE_BINARY_DIR}/hashcat-prefix/src/hashcat)
#ExternalProject_Add(hashcat
#        GIT_REPOSITORY https://github.com/hashcat/hashcat.git
#        GIT_TAG 1cee512c09e96a5f9842260eb08f60c113878344
#        CONFIGURE_COMMAND ""
#        BUILD_COMMAND SHARED=1 make -C ../hashcat
#        INSTALL_COMMAND SHARED=1 make install -C ../hashcat
#        )


#add_library(bruhplzwork SHARED IMPORTED GLOBAL)
#set_target_properties(
#        bruhplzwork
#        PROPERTIES
#        IMPORTED_LOCATION ${EXTERNAL_INSTALL_LOCATION}/libhashcat.6.2.6.dylib
#        IMPORTED_IMPLIB   ${EXTERNAL_INSTALL_LOCATION}/libhashcat.6.2.6.dylib
#)

#include_directories(${EXTERNAL_INSTALL_LOCATION})
#add_library(testlib SHARED IMPORTED ${EXTERNAL_INSTALL_LOCATION}/libhashcat.6.2.6.dylib)
#set_property(TARGET testlib PROPERTY IMPORTED_LOCATION ${EXTERNAL_INSTALL_LOCATION}/libhashcat.6.2.6.dylib)


#add_executable(test_import add.c)
#target_link_libraries(test_import bruhplzwork)

#add_dependencies(test_import hashcat)
#target_link_libraries(test_import PUBLIC ${EXTERNAL_INSTALL_LOCATION}/libhashcat.6.2.6.dylib)


#include_directories(${CMAKE_BINARY_DIR}/googletest-prefix/src/googletest)
#target_link_directories(FirstTest ${CMAKE_BINARY_DIR}/googletest-prefix/src/googletest)
#target_link_libraries(FirstTest temp)


#cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
#project(test_import VERSION 1.0.0 LANGUAGES C)
#add_library(test_import SHARED add.c add.def)
#add_executable(add add.c)
#
##include_directories(native_subtract)
##add_subdirectory(native_subtract)
##add_custom_target(sub make -f "${CMAKE_CURRENT_SOURCE_DIR}/native_subtract/Makefile")
##add_custom_command(OUTPUT sub
##        COMMAND make run
##        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/native_subtract
##        )
##target_include_directories(test_import PUBLIC
##        "${PROJECT_BINARY_DIR}"
##        "${PROJECT_SOURCE_DIR}/native_subtract"
##        )
##INCLUDE_DIRECTORIES(native_subtract)
##LINK_DIRECTORIES(native_subtract)
##TARGET_LINK_LIBRARIES(test_import native_subtract)
#
#include(ExternalProject)
#ExternalProject_Add(hashcat
#        GIT_REPOSITORY https://github.com/hashcat/hashcat.git
#        GIT_TAG 1cee512c09e96a5f9842260eb08f60c113878344
#        UPDATE_COMMAND ""
#        INSTALL_COMMAND "make"
#        )
#add_dependencies(test_import hashcat)
#
##include(ExternalProject)
##ExternalProject_Add(example
##        URL https://github.com/hashcat/hashcat.git
##        # Download options, etc.
##        BUILD_COMMAND ${CMAKE_COMMAND} -E echo "Starting $<CONFIG> build"
##        COMMAND       ${CMAKE_COMMAND} --build <BINARY_DIR> --config $<CONFIG>
##        COMMAND       ${CMAKE_COMMAND} -E echo "$<CONFIG> build complete"
##        )
##ExternalProject_Add(native_subtract
##        URL https://github.com/hashcat/hashcat.git
##        PREFIX ${CMAKE_CURRENT_BINARY_DIR}/native_subtract
##        CONFIGURE_COMMAND ""
##        BUILD_COMMAND make
##        )
##add_library(test_import SHARED add.c add.def native_subtract)
##ExternalProject_Get_Property(native_subtract install_dir)
##add_library(test_import STATIC IMPORTED)
##set_property(TARGET test_import PROPERTY IMPORTED_LOCATION ${install_dir}/lib/libluajit-5.1.a)
##add_dependencies(test_import native_subtract)
##include_directories(${install_dir}/include/luajit-2.0)
##target_link_libraries(test_import native_subtract)
#
#set_target_properties(test_import PROPERTIES
#    PUBLIC_HEADER add.h
#    VERSION ${PROJECT_VERSION}
#    SOVERSION 1
#    OUTPUT_NAME "add"
#    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
#)
#
##ExternalProject_Add(hashcat
##        URL https://github.com/hashcat/hashcat.git
##        PREFIX ${CMAKE_CURRENT_BINARY_DIR}/hashcat
##        CONFIGURE_COMMAND ""
##        BUILD_COMMAND make
##        INSTALL_COMMAND make install
##        PREFIX=${CMAKE_CURRENT_BINARY_DIR}/hashcat
##        )
##ExternalProject_Get_Property(hashcat install_dir)
##add_library(test_import STATIC IMPORTED)
##set_property(TARGET test_import PROPERTY IMPORTED_LOCATION ${install_dir}/lib/libluajit-5.1.a)
##add_dependencies(test_import hashcat)
##include_directories(${install_dir}/include/luajit-2.0)
##target_link_libraries(test_import hashcat)
