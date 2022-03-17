# Various flags
CXX  = mpic++
LINK = $(CXX)
#CXXFLAGS = -I -Wall -g 
CXXFLAGS = -g -Wall -O3 -fopenmp --std=c++11 -fsanitize=undefined -I/home/mfaysal/asa_opt/include #-I #-Wall -O3 -funroll-loops -pipe 
#CXXFLAGS = -g -Wall -fopenmp #-I #-Wall -O3 -funroll-loops -pipe 
LFLAGS =  -g -fopenmp -Wall -Werror -O3 -fsanitize=undefined -fuse-ld=gold

LIB=-L/home/mfaysal/asa_opt/lib/
LDFLAGS="-Wl,-rpath,/home/mfaysal/asa_opt/lib/"

TARGET  = ompInfomap

HEADER  = Node.h Module.h FileIO.h timing.h global.h
FILES = OmpRelaxmap.cpp Node.cpp Module.cpp FileIO.cpp timing.cpp global.cpp

OBJECTS = $(FILES:.cpp=.o)

$(TARGET): ${OBJECTS}
	$(LINK) $(LFLAGS) $(LIB) $(LDFLAGS) $^ -o  $@ -lasa

all: $(TARGET)

clean:
	rm -f $(OBJECTS)

distclean:
	rm -f $(OBJECTS) $(TARGET)

# Compile and dependency
$(OBJECTS): $(HEADER) Makefile




