cmake_minimum_required(VERSION 3.6)
project(lab3)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(SOURCE_FILES_G1 gen1.cpp)
add_executable(lab3g1.o ${SOURCE_FILES_G1})

set(SOURCE_FILES_G2 gen2.cpp)
add_executable(lab3g2.o ${SOURCE_FILES_G2})

set(SOURCE_FILES_G3 gen3.cpp)
add_executable(lab3g3.o ${SOURCE_FILES_G3})