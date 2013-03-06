PROJECT(Meschach)

CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules)
#CMake module inclusion 
INCLUDE (CheckIncludeFiles)
INCLUDE(CheckCXXSourceCompiles)
INCLUDE(CheckHeaderSTDC)

#### configure.in part #########
####################################
#Add definitions
check_header_stdc()
#Check local prototypes
CHECK_CXX_SOURCE_COMPILES("extern int test (int i, double x);" HAVE_PROTOTYPES)
CHECK_CXX_SOURCE_COMPILES("struct s1 {int (*f) (int a);};\nstruct s2 {int (*f) (double a);};" HAVE_PROTOTYPES_IN_STRUCT)
CHECK_CXX_SOURCE_COMPILES("#include <stdio.h>\n#ifdef __STDC__\n#include <stdlib.h>\n#endif" U_INT_DEF)

#Headers presence test
CHECK_INCLUDE_FILES(memory.h HAVE_MEMORY_H)
CHECK_INCLUDE_FILES(malloc.h HAVE_MALLOC_H)
CHECK_INCLUDE_FILES(complex.h HAVE_COMPLEX_H)
CHECK_INCLUDE_FILES(varargs.h HAVE_VARARGS_H)

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

#Compile Options
OPTION(COMPLEX "incorporate complex functions" OFF)
OPTION(SPARSE  "incorporate sparse matrix functions" OFF)
OPTION(VUNROLL "unroll low level loops on vectors" OFF)
OPTION(MUNROLL "unroll low level loops on matrices" OFF)
OPTION(SEGMENTED " single precision" OFF)
OPTION(REAL_FLT "float" OFF)
OPTION(REAL_DBL "double precision (default)" ON)

# Generate Headers
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/machine.h.in ${CMAKE_CURRENT_SOURCE_DIR}/machine.h)

#### makefile.in part #########
####################################

add_definitions("-O -DINCLUDE_DIRECTORIES=${CMAKE_REQUIRED_INCLUDES}")

set(HBASE err.h meminfo.h machine.h matrix.h)

set(HLIST ${HBASE} iter.h matlab.h matrix2.h  oldnames.h sparse.h sparse2.h zmatrix.h zmatrix2.h)

set(LIST_1 copy.c err.c matrixio.c memory.c vecop.c matop.c pxop.c 
	submat.c init.c otherio.c machine.c matlab.c ivecop.c version.c 
	meminfo.c memstat.c)

set(LIST_2 lufactor.c bkpfacto.c chfactor.c qrfactor.c solve.c hsehldr.c 
	givens.c update.c norm.c hessen.c symmeig.c schur.c svd.c fft.c 
	mfunc.c bdfactor.c)

set (LIST_3 sparse.c sprow.c sparseio.c spchfctr.c splufctr.c 
	spbkp.c spswap.c iter0.c itersym.c iternsym.c)

set (OLD_LIST onjgrad.c lanczos.c arnoldi.c)

file(GLOB_RECURSE all_source_files *.c)
file(GLOB_RECURSE all_source_headers *.h)

add_library(meschach ${all_source_files})


