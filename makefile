
#
# target
#
TARGET = a.out

#
# source file
#
SRCCPP =
SRCC = main.c
SRCH =

SRCS = $(SRCCPP) $(SRCC)
OBJS = $(SRCCPP:.cpp=.o) $(SRCC:.c=.o)
MAKEFILE = Makefile
DEPENDFILE = Make.depend

#
# compile parameter
#
CC = g++
OPTS =
INCLUDES =
CFLAGS = -g -O2 -Wall -std=c++0x
#CFLAGS = -g -O2 -Wall -fprofile-arcs -ftest-coverage
LDFLAGS =
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
	-@ $(CC) $(OPTS) -o $@ $^ $(LIBS)

.c.o:
	$(CC) $(CFLAGS) $(INCLUDES) -c $<

.cpp.o:
	$(CC) $(CFLAGS) $(INCLUDES) -c $<

depend:
	-@ $(RM) $(DEPENDFILE)
	-@ g++ -MM -MG $(SRCS) > $(DEPENDFILE)

clean:
	-@ $(RM) $(TARGET) $(DEPENDFILE) *.o *.obj *~ *.~* *.BAK

tar:
	-@ $(TAR) $(TARGET).tar.gz $(SRCS) $(SRCH) $(MAKEFILE)

# source and header file dependent
-include $(DEPENDFILE)
