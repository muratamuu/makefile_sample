#
# OS/ARCH
#
ifeq ($(OS), Windows_NT)
OSDEF = WINDOWS
else
UNAME = $(shell uname)
ifeq ($(UNAME), Linux)
OSDEF = LINUX
endif
ifeq ($(UNAME), Darwin)
OSDEF = MACOSX
endif
endif

#
# target
#
TARGET = a.out

#
# source file
#
SRCCPP = main.cpp
SRCC =
MAKEFILE = makefile

SRCS = $(SRCCPP) $(SRCC)
OBJS = $(SRCCPP:.cpp=.o) $(SRCC:.c=.o)
DEPENDFILES = $(SRCCPP:.cpp=.d) $(SRCC:.c=.d)

#
# compile parameter
#
CC = g++
CFLAGS = -g -O2 -Wall -std=c++11
LDFLAGS =
#CFLAGS = -g -O2 -Wall -fprofile-arcs -ftest-coverage
INCDIR =
LIBDIR =
LIBS =
#LIBS = -lgcov -lpthread

#
# shell comannd
#
RM = rm -rf
#RM = del

# definition
.SUFFIXES: .cxx .cpp .c .o .h .d
.PHONY: clean all echo check-syntax

#
# Rules
#
all: $(TARGET)

echo:
	@echo 'OSDEF:$(OSDEF)'
	@echo 'TARGET:$(TARGET)'
	@echo 'SRCS:$(SRCS)'
	@echo 'OBJS:$(OBJS)'

$(TARGET): $(OBJS)
	@echo 'Making $(TARGET)...'
	-@ $(CC) $(LDFLAGS) -o $@ $^ $(LIBDIR) $(LIBS)

.c.o:
	$(CC) $(CFLAGS) -MMD -c $< $(INCDIR) -o $@

.cpp.o:
	$(CC) $(CFLAGS) -MMD -c $< $(INCDIR) -o $@

clean:
	-@ $(RM) $(TARGET) $(DEPENDFILES) $(OBJS) *.d *.o *.obj *~ *.~* *.BAK

check-syntax:
	$(CC) $(CFLAGS) -fsyntax-only $(CHK_SOURCES)

# source and header file dependent
-include $(DEPENDFILES)
