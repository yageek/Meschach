PROJECT(Meschach)

CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

#CMake module inclusion 
INCLUDE (CheckIncludeFiles)
INCLUDE(CheckCXXSourceCompiles)

#### configure.in part #########
####################################
#Add definitions
add_definitions(-std=c99) # AC_PROG_CC_STDC

#Check local prototypes
CHECK_CXX_SOURCE_COMPILES("extern int test (int i, double x);" HAVE_PROTOTYPES)
CHECK_CXX_SOURCE_COMPILES("struct s1 {int (*f) (int a);};\nstruct s2 {int (*f) (double a);};" HAVE_PROTOTYPES_IN_STRUCT)
CHECK_CXX_SOURCE_COMPILES("#include <stdio.h>\n#ifdef __STDC__\n#include <stdlib.h>\n#endif" U_INT_DEF)

#Compute Machine epsilons for double and float values
MESSAGE(STATUS "Compute machine epsilons :")

execute_process(COMMAND ${CMAKE_C_COMPILER} -o macheps ${CMAKE_CURRENT_SOURCE_DIR}/dmacheps.c -w RESULT_VARIABLE ret)

IF(ret EQUAL 0)
execute_process(COMMAND ./macheps OUTPUT_VARIABLE D_MACHEPS)
		MESSAGE(STATUS "Double epsilon : ${D_MACHEPS}")
	ELSE(ret EQUAL 0)
		MESSAGE(FATAL_ERROR "Could not determine the machine double epsilon")
ENDIF(ret EQUAL 0)


execute_process(COMMAND ${CMAKE_C_COMPILER} -o macheps ${CMAKE_CURRENT_SOURCE_DIR}/fmacheps.c -w RESULT_VARIABLE ret)

IF(ret EQUAL 0)
execute_process(COMMAND ./macheps OUTPUT_VARIABLE F_MACHEPS)
		MESSAGE(STATUS "Float epsilon : ${F_MACHEPS}")
	ELSE(ret EQUAL 0)
		MESSAGE(FATAL_ERROR "Could not determine the machine float epsilon")
ENDIF(ret EQUAL 0)

#Compute the maximum int for the platform
MESSAGE(STATUS "Compute the maximul integer value")

execute_process(COMMAND ${CMAKE_C_COMPILER} -o maxint ${CMAKE_CURRENT_SOURCE_DIR}/maxint.c -w RESULT_VARIABLE ret)

IF(ret EQUAL 0)
execute_process(COMMAND ./maxint OUTPUT_VARIABLE M_MAX_INT)
		MESSAGE(STATUS "Maximum int : ${M_MAX_INT}")
	ELSE(ret EQUAL 0)
		MESSAGE(FATAL_ERROR "Could not determine the machine double epsilon")
ENDIF(ret EQUAL 0)
## Not understanding : 'echo checking char '\\0' vs. float zeros'

#Headers presence test
CHECK_INCLUDE_FILES(memory.h HAVE_MALLOC_H)
CHECK_INCLUDE_FILES(complex.h HAVE_COMPLEX_H)
CHECK_INCLUDE_FILES(varargs.h HAVE_VARARGS_H)

#### makefile.in part #########
####################################

add_definitions(-O)

set(HBASE err.h meminfo.h machine.h matrix.h)

set(HLIST ${HBASE} iter.h matlab.h matrix2.h  oldnames.h sparse.h sparse2.h zmatrix.h zmatrix2.h)

set(TORTURE )