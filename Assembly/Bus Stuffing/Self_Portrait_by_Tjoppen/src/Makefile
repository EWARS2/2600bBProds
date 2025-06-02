BINNAME=Self_Portrait
AUTHOR=Tjoppen
DISTNAME=${BINNAME}_by_${AUTHOR}
DISTFILES=README
SRCFILES=Makefile main.asm bmpconv.c palette.h idolbild.bmp
BINARY=build/pal.bin

all: build/idolbild.asm
	mkdir -p build
	dasm main.asm -f3 -DPAL=1 -DFPS=50 -obuild/pal.bin

build/bmpconv: bmpconv.c
	mkdir -p build
	gcc -std=c99 -Wall -pedantic -fopenmp bmpconv.c -o build/bmpconv

build/%.asm: %.bmp build/bmpconv
	build/bmpconv $< build/quant-$< > $@

clean:
	rm -rf build ${DISTNAME} ${DISTNAME}.zip

run: all
	stella -grabmouse 0 ${BINARY}

dist: all
	rm -rf ${DISTNAME} ${DISTNAME}.zip
	mkdir -p ${DISTNAME}
	mkdir -p ${DISTNAME}/src
	if [ -n "${DISTFILES}" ] ; then cp ${DISTFILES} ${DISTNAME} ; fi
	cp ${SRCFILES} ${DISTNAME}/src
	cp ${BINARY} ${DISTNAME}/${DISTNAME}.bin

	zip -r ${DISTNAME}.zip ${DISTNAME}

	cp vcs.h macro.h ${DISTNAME}/src
	cd ${DISTNAME}/src && make run

download: all
	stty -F /dev/ttyUSB0 115200
	harmonycart ${BINARY}
