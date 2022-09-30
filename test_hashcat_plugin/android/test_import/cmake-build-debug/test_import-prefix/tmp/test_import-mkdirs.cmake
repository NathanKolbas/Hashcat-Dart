# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/test_import-prefix/src/test_import"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/test_import-prefix/src/test_import-build"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/test_import-prefix"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/test_import-prefix/tmp"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/test_import-prefix/src/test_import-stamp"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/test_import-prefix/src"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/test_import-prefix/src/test_import-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/test_import-prefix/src/test_import-stamp/${subDir}")
endforeach()
