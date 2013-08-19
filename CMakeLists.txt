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

#Compile Options
OPTION(COMPLEX_OPTION "incorporate complex functions" OFF)
OPTION(SPARSE_OPTION  "incorporate sparse matrix functions" OFF)
OPTION(VUNROLL_OPTION  "unroll low level loops on vectors" OFF)
OPTION(MUNROLL_OPTION  "unroll low level loops on matrices" OFF)
OPTION(SEGMENTED_OPTION  "single precision" OFF)
OPTION(REAL_FLT_OPTION  "float" OFF)
OPTION(REAL_DBL_OPTION  "double precision (default)" ON)
OPTION(ANDROID_COMPILE "compile for android" ON) 

if(COMPLEX_OPTION)
	set(COMPLEX 1)
endif(COMPLEX_OPTION)

if(SPARSE_OPTION)
	set(SPARSE 1)
endif(SPARSE_OPTION)

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

set (ZLIST1 zmachine.c zcopy.c zmatio.c zmemory.c zvecop.c zmatop.c znorm.c zfunc.c )

set (ZLIST2 zlufctr.c zsolve.c zmatlab.c zhsehldr.c zqrfctr.c zgivens.c  zhessen.c zschur.c)

set (OLD_LIST onjgrad.c lanczos.c arnoldi.c)

set(TORTURE torture.c sptort.c ztorture.c memtort.c itertort.c  mfuntort.c iotort.c)

set (sources_files ${LIST_1} ${LIST_2})

if(SPARSE_OPTION)
	set(sources_files ${sources_files} ${LIST_3})
endif(SPARSE_OPTION )

if(COMPLEX_OPTION)
	set (sources_files ${sources_files} ${ZLIST1} ${ZLIST2})
endif(COMPLEX_OPTION)

add_library(meschach ${sources_files})


