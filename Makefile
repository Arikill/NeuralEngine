cc:=g++
std:=c++17
optim:=-Ofast
target:=main
incl:=-I/opt/homebrew/Cellar/eigen/3.4.0_1/include/eigen3

all: $(target)
$(target): $(target).cc
	$(cc) -std=$(std) $(optim) $(incl) $(target).cc -o $(target)

clean:
	$(RM) $(target)
