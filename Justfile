clear:
	rm -f libimageprocessing.so imageprocessing.a imageprocessing.o opencv-odin-demo main

object:
	gcc -c -Wall -Werror -fpic -I/usr/include/opencv4 -I/usr/include/opencv4/opencv2 `pkg-config --libs opencv4` -lstdc++ imageprocessing.cpp

static: object
	ar rcs imageprocessing.a imageprocessing.o

shared: object
	gcc -shared -o libimageprocessing.so imageprocessing.o

build_c: shared
	gcc -Wall -I/usr/include/opencv4 -I/usr/include/opencv4/opencv2 -I./ -o main main.c -L./ -limageprocessing `pkg-config --libs opencv4` -lstdc++

run_c: build_c
	LD_LIBRARY_PATH=$(pwd)/ ./main

build_odin: shared static
	odin build ../opencv-odin-demo -extra-linker-flags:"`pkg-config --libs opencv4` -lstdc++"

run_odin: build_odin
	./opencv-odin-demo