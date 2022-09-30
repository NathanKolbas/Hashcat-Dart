# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

if(EXISTS "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/_deps/hashcat-subbuild/hashcat-populate-prefix/src/hashcat-populate-stamp/hashcat-populate-gitclone-lastrun.txt" AND EXISTS "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/_deps/hashcat-subbuild/hashcat-populate-prefix/src/hashcat-populate-stamp/hashcat-populate-gitinfo.txt" AND
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/_deps/hashcat-subbuild/hashcat-populate-prefix/src/hashcat-populate-stamp/hashcat-populate-gitclone-lastrun.txt" IS_NEWER_THAN "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/_deps/hashcat-subbuild/hashcat-populate-prefix/src/hashcat-populate-stamp/hashcat-populate-gitinfo.txt")
  message(STATUS
    "Avoiding repeated git clone, stamp file is up to date: "
    "'/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/_deps/hashcat-subbuild/hashcat-populate-prefix/src/hashcat-populate-stamp/hashcat-populate-gitclone-lastrun.txt'"
  )
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E rm -rf "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/_deps/hashcat-src"
  RESULT_VARIABLE error_code
)
if(error_code)
  message(FATAL_ERROR "Failed to remove directory: '/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/_deps/hashcat-src'")
endif()

# try the clone 3 times in case there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  execute_process(
    COMMAND "/usr/bin/git" 
            clone --no-checkout --config "advice.detachedHead=false" "https://github.com/hashcat/hashcat.git" "hashcat-src"
    WORKING_DIRECTORY "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/_deps"
    RESULT_VARIABLE error_code
  )
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  message(STATUS "Had to git clone more than once: ${number_of_tries} times.")
endif()
if(error_code)
  message(FATAL_ERROR "Failed to clone repository: 'https://github.com/hashcat/hashcat.git'")
endif()

execute_process(
  COMMAND "/usr/bin/git" 
          checkout "1cee512c09e96a5f9842260eb08f60c113878344" --
  WORKING_DIRECTORY "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/_deps/hashcat-src"
  RESULT_VARIABLE error_code
)
if(error_code)
  message(FATAL_ERROR "Failed to checkout tag: '1cee512c09e96a5f9842260eb08f60c113878344'")
endif()

set(init_submodules TRUE)
if(init_submodules)
  execute_process(
    COMMAND "/usr/bin/git" 
            submodule update --recursive --init 
    WORKING_DIRECTORY "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/_deps/hashcat-src"
    RESULT_VARIABLE error_code
  )
endif()
if(error_code)
  message(FATAL_ERROR "Failed to update submodules in: '/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/_deps/hashcat-src'")
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/_deps/hashcat-subbuild/hashcat-populate-prefix/src/hashcat-populate-stamp/hashcat-populate-gitinfo.txt" "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/_deps/hashcat-subbuild/hashcat-populate-prefix/src/hashcat-populate-stamp/hashcat-populate-gitclone-lastrun.txt"
  RESULT_VARIABLE error_code
)
if(error_code)
  message(FATAL_ERROR "Failed to copy script-last-run stamp file: '/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/_deps/hashcat-subbuild/hashcat-populate-prefix/src/hashcat-populate-stamp/hashcat-populate-gitclone-lastrun.txt'")
endif()
