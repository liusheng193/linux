cc=g++
exe=main
obj=main.o	printf1.o
$(exe):$(obj)
	$(cc)	-fprofile-arcs -ftest-coverage -o	$(exe)	$(obj)
main.o:main.cpp	printf1.h
	$(cc) -fprofile-arcs -ftest-coverage -c main.cpp
printf1.o:printf1.cpp	printf1.h
	$(cc) -fprofile-arcs -ftest-coverage -c printf1.cpp
clean:
	rm -fr *.o main

