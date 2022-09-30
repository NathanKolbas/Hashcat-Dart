# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/native_sub/src/hashcat"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/native_sub/src/hashcat-build"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/native_sub"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/native_sub/tmp"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/native_sub/src/hashcat-stamp"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/native_sub/src"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/native_sub/src/hashcat-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/native_sub/src/hashcat-stamp/${subDir}")
endforeach()
