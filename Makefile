cc:=g++
std:=c++17
optim:=-Ofast
target:=main

all: $(target)
$(target): $(target).cc
	$(cc) -std=$(std) $(optim) $(target).cc -o $(target)

clean:
	$(RM) $(target)
