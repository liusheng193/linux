cc=g++
exe=main
obj=main.o	printf1.o
$(exe):$(obj)
	$(cc)	-o	$(exe)	$(obj)
main.o:main.cpp	printf1.h
	$(cc) -c main.cpp
printf1.o:printf1.cpp	printf1.h
	$(cc) -c printf1.cpp
clean:
	rm -fr *.o main

