INCLUDEPATH += $$PWD

HEADERS += $$PWD/*.h

# Only use the source files without a main function,
# so this file can be used for other programs to 
# use Meschach
SOURCES += \
    $$PWD/arnoldi.c \
    $$PWD/bdfactor.c \
    $$PWD/bkpfacto.c \
    $$PWD/chfactor.c \
    $$PWD/conjgrad.c \
    $$PWD/copy.c \
    $$PWD/err.c \
    $$PWD/extras.c \
    $$PWD/fft.c \
    $$PWD/givens.c \
    $$PWD/hessen.c \
    $$PWD/hsehldr.c \
    $$PWD/init.c \
    $$PWD/iter0.c \
    $$PWD/iternsym.c \
    $$PWD/itersym.c \
    #$$PWD/itertort.c \
    $$PWD/ivecop.c \
    $$PWD/lanczos.c \
    $$PWD/lufactor.c \
    $$PWD/machine.c \
    $$PWD/matlab.c \
    $$PWD/matop.c \
    $$PWD/matrixio.c \
    $$PWD/meminfo.c \
    $$PWD/memory.c \
    $$PWD/memstat.c \
    $$PWD/mfunc.c \
    $$PWD/norm.c \
    $$PWD/otherio.c \
    $$PWD/pxop.c \
    $$PWD/qrfactor.c \
    $$PWD/schur.c \
    $$PWD/solve.c \
    $$PWD/sparse.c \
    $$PWD/sparseio.c \
    $$PWD/spbkp.c \
    $$PWD/spchfctr.c \
    $$PWD/splufctr.c \
    $$PWD/sprow.c \
    $$PWD/spswap.c \
    $$PWD/submat.c \
    $$PWD/svd.c \
    $$PWD/symmeig.c \
    $$PWD/update.c \
    $$PWD/vecop.c \
    $$PWD/version.c \
    $$PWD/zcopy.c \
    $$PWD/zfunc.c \
    $$PWD/zgivens.c \
    $$PWD/zhessen.c \
    $$PWD/zhsehldr.c \
    $$PWD/zlufctr.c \
    $$PWD/zmachine.c \
    $$PWD/zmatio.c \
    $$PWD/zmatlab.c \
    $$PWD/zmatop.c \
    $$PWD/zmemory.c \
    $$PWD/znorm.c \
    $$PWD/zqrfctr.c \
    $$PWD/zschur.c \
    $$PWD/zsolve.c \
    $$PWD/zvecop.c
