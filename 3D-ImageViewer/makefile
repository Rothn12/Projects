# makefilecomment
CC = g++
CFLAGS = -c -MMD
LFLAGS = -lX11
SOURCES = main.cpp gcontext.cpp x11context.cpp image.cpp shape.cpp line.cpp triangle.cpp matrix.cpp row.cpp drawbase.cpp viewcontext.cpp
OBJECTS = $(SOURCES:.cpp=.o)
EXECUTABLE = main

all: $(EXECUTABLE) $(SOURCES)

$(EXECUTABLE): $(OBJECTS)
	$(CC) -o $@ $(OBJECTS) $(LFLAGS)

-include *.d

%.o: %.cpp
	$(CC) $(CFLAGS) $<

clean:
	rm -f $(EXECUTABLE)
	rm -f $(OBJECTS)
	rm -f *.d