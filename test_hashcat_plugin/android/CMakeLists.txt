# Sets lib_src_DIR to the path of the target CMake project.
set( lib_src_DIR ../gmath )

# Sets lib_build_DIR to the path of the desired output directory.
set( lib_build_DIR ../gmath/outputs )
file(MAKE_DIRECTORY ${lib_build_DIR})

# Adds the CMakeLists.txt file located in the specified directory
# as a build dependency.
add_subdirectory( # Specifies the directory of the CMakeLists.txt file.
                  ${lib_src_DIR}

                  # Specifies the directory for the build outputs.
                  ${lib_build_DIR} )

# Adds the output of the additional CMake build as a prebuilt static
# library and names it lib_gmath.
add_library( lib_gmath STATIC IMPORTED )
set_target_properties( lib_gmath PROPERTIES IMPORTED_LOCATION
                       ${lib_build_DIR}/${ANDROID_ABI}/lib_gmath.a )
include_directories( ${lib_src_DIR}/include )

# Links the top-level CMake build output against lib_gmath.
target_link_libraries( native-lib ... lib_gmath )
