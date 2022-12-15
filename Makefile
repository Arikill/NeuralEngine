cc:=g++
std:=c++17
target:=main

all: $(target)
$(target): $(target).cc
	$(cc) -std=$(std) $(target).cc -o $(target)

clean:
	$(RM) $(target)
