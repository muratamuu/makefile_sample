
#
# target
#
TARGET = a.out

#
# source file
#
SRCCPP = main.cpp
SRCC =
SRCH =

SRCS = $(SRCCPP) $(SRCC)
OBJS = $(SRCCPP:.cpp=.o) $(SRCC:.c=.o)
MAKEFILE = Makefile
DEPENDFILE = depend.inc

#
# compile parameter
#
CC = g++
CFLAGS = -g -O2 -Wall -std=c++0x
LDFLAGS =
#CFLAGS = -g -O2 -Wall -fprofile-arcs -ftest-coverage
INCDIR =
LIBDIR =
LIBS =
#LIBS = -lgcov

#
# shell comannd
#
TAR = tar czfv
RM = rm -rf
#RM = del

# definition
.SUFFIXES: .cxx .cpp .c .o .h
.PHONY: clean all depend echo

#
# Rules
#
all: depend $(TARGET)

echo:
	@echo 'TARGET:$(TARGET)'
	@echo 'SRCS:$(SRCS)'
	@echo 'OBJS:$(OBJS)'

$(TARGET): $(OBJS)
	@echo 'Making $(TARGET)...'
	-@ $(CC) $(LDFLAGS) -o $@ $^ $(LIBDIR) $(LIBS)

.c.o:
	$(CC) $(CFLAGS) -c $< $(INCDIR)

.cpp.o:
	$(CC) $(CFLAGS) -c $< $(INCDIR)

depend:
	-@ $(RM) $(DEPENDFILE)
	-@ $(CC) $(CFLAGS) -MM -MG $(SRCS) > $(DEPENDFILE)

clean:
	-@ $(RM) $(TARGET) $(DEPENDFILE) *.o *.obj *~ *.~* *.BAK

tar:
	-@ $(TAR) $(TARGET).tar.gz $(SRCS) $(SRCH) $(MAKEFILE)

# source and header file dependent
-include $(DEPENDFILE)
