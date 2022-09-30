# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/luajit-2.0.1/src/project_luajit"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/luajit-2.0.1/src/project_luajit-build"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/luajit-2.0.1"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/luajit-2.0.1/tmp"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/luajit-2.0.1/src/project_luajit-stamp"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/luajit-2.0.1/src"
  "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/luajit-2.0.1/src/project_luajit-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/Users/nkolbas/Documents/personal/school/CSCE-461/project_testing/test_hashcat_plugin/android/test_import/cmake-build-debug/luajit-2.0.1/src/project_luajit-stamp/${subDir}")
endforeach()
