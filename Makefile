
CC = gcc
VERSION = 
CFLAGS = -g -O2
LIBS = 
INSTALL=/bin/install -c
prefix=/usr/local
bindir=$(prefix)${exec_prefix}/bin
FLAGS=$(LDFLAGS) $(CPPFLAGS) $(CFLAGS) -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\" -DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\" -DPACKAGE_URL=\"\" -DSTDC_HEADERS=1 -D_FILE_OFFSET_BITS=64 -DUSE_XATTR=1
OBJ=common.o command-line-args.o ssh.o fingerprint.o files.o filesigning.o xattr.o cgi.o check-hash.o find.o memcached.o
EXE=hashrat

all: $(OBJ) main.c
	@cd libUseful-2.1; $(MAKE)
	gcc $(FLAGS) -o$(EXE) $(OBJ) main.c libUseful-2.1/libUseful-2.1.a $(LIBS) 

common.o: common.h common.c
	gcc $(FLAGS) -c common.c

fingerprint.o: fingerprint.h fingerprint.c
	gcc $(FLAGS) -c fingerprint.c

files.o: files.h files.c
	gcc $(FLAGS) -c files.c

filesigning.o: filesigning.h filesigning.c
	gcc $(FLAGS) -c filesigning.c

find.o: find.h find.c
	gcc $(FLAGS) -c find.c

check-hash.o: check-hash.h check-hash.c
	gcc $(FLAGS) -c check-hash.c

xattr.o: xattr.h xattr.c
	gcc $(FLAGS) -c xattr.c

ssh.o: ssh.h ssh.c
	gcc $(FLAGS) -c ssh.c

cgi.o: cgi.h cgi.c
	gcc $(FLAGS) -c cgi.c

memcached.o: memcached.h memcached.c
	gcc $(FLAGS) -c memcached.c

command-line-args.o: command-line-args.h command-line-args.c
	gcc $(FLAGS) -c command-line-args.c

check:
	@./check.sh


clean:
	-rm -f *.o */*.o */*.a */*.so $(EXE)
	-rm config.log config.status */config.log */config.status
	-rm -r autom4te.cache */autom4te.cache

distclean:
	-rm -f *.o */*.o */*.a */*.so $(EXE)
	-rm config.log config.status */config.log */config.status Makefile */Makefile
	-rm -r autom4te.cache */autom4te.cache


install:
	-mkdir -p $(DESTDIR)$(prefix)/bin
	cp -f $(EXE) $(DESTDIR)$(prefix)/bin
