PROJECT(Meschach)

CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

#CMake module inclusion 
INCLUDE (CheckIncludeFiles)
INCLUDE(CheckCXXSourceCompiles)


#Add definitions
add_definitions(-std=c99) # AC_PROG_CC_STDC

#Check local prototypes
CHECK_CXX_SOURCE_COMPILES("extern int test (int i, double x);" HAVE_PROTOTYPES)
CHECK_CXX_SOURCE_COMPILES("struct s1 {int (*f) (int a);};\nstruct s2 {int (*f) (double a);};" HAVE_PROTOTYPES_IN_STRUCT)
CHECK_CXX_SOURCE_COMPILES("#include <stdio.h>\n#ifdef __STDC__\n#include <stdlib.h>\n#endif" U_INT_DEF)

#Compute Machine epsilons for double and float values
MESSAGE(STATUS "Compute machine epsilons :")

execute_process(COMMAND ${CMAKE_C_COMPILER} -o macheps ${CMAKE_CURRENT_SOURCE_DIR}/dmacheps.c -w RESULT_VARIABLE ret)

MESSAGE(STATUS "Return": '%{ret}'")

#IF(ret EQUAL 0)
#execute_process(COMMAND ./macheps OUTPUT_VARIABLE dmacheps)
#		MESSAGE(STATUS "Double epsilon : '%{dmacheps}'")
#ENDIF(ret EQUAL 0)

#Headers presence test
CHECK_INCLUDE_FILES(memory.h HAVE_MALLOC_H)
CHECK_INCLUDE_FILES(complex.h HAVE_COMPLEX_H)
CHECK_INCLUDE_FILES(varargs.h HAVE_VARARGS_H)