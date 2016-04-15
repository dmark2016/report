#!/bin/sh

cd m5
scons -j4 NO_FAST_ALLOC=False CC=/usr/bin/gcc-4.8 CXX=/usr/bin/g++-4.8 EXTRAS=../prefetcher build/ALPHA_SE/m5.opt
