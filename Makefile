AR=      /usr/bin/ar
RANLIB=  /usr/bin/ar ts
CC = gcc
THELIB = libtuntap.a
INC = -I. \
      -I/usr/include/ \
      -I/usr/local/include

CFLAGS= -fPIC -O0 ${INC} -DUnix -g -Wall -static

detected_OS := $(shell uname 2>/dev/null || echo Unknown)

FILES = tuntap.c tuntap_log.c tuntap-unix.c
LIB_OBJS = tuntap.o tuntap_log.o tuntap-unix.o

ifeq ($(detected_OS),Linux)
    CFLAGS   +=   -D_GNU_SOURCE
    FILES    += tuntap-unix-linux.c
    LIB_OBJS += tuntap-unix-linux.o
endif

ifeq ($(detected_OS),OpenBSD)
    FILES += tuntap-unix-openbsd.c
    FILES += tuntap-unix-bsd.c
    LIB_OBJS += tuntap-unix-openbsd.o
    LIB_OBJS += tuntap-unix-bsd.o
endif
ifeq ($(detected_OS),NetBSD)
    FILES += tuntap-unix-netbsd.c
    FILES += tuntap-unix-bsd.c
    LIB_OBJS += tuntap-unix-netbsd.o
    LIB_OBJS += tuntap-unix-bsd.o
endif
ifeq ($(detected_OS),FreeBSD)
    FILES += tuntap-unix-freebsd.c
    FILES += tuntap-unix-bsd.c
    LIB_OBJS += tuntap-unix-openbsd.o
    LIB_OBJS += tuntap-unix-bsd.o
endif
ifeq ($(detected_OS),Darwin)
    FILES += tuntap-unix-darwin.c
    FILES += tuntap-unix-bsd.c
    LIB_OBJS += tuntap-unix-darwin.o
    LIB_OBJS += tuntap-unix-bsd.o
endif
ifeq ($(detected_OS),DragonFly)
    FILES += tuntap-unix-freebsd.c
    FILES += tuntap-unix-bsd.c
    LIB_OBJS += tuntap-unix-freebsd.o
    LIB_OBJS += tuntap-unix-bsd.o
endif

all: 	$(LIB_OBJS)
	$(AR) rc $(THELIB) $?
	$(RANLIB) $(THELIB)
	@echo $(detected_OS)
clean:
	rm $(THELIB) $(LIB_OBJS)

check:
distdir:
install:
installcheck:
uninstall:
distclean:
