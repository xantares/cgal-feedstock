#!/bin/sh

mkdir -p build && cd build

# needs qt5 for imageio
cmake \
  -DCMAKE_FIND_ROOT_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DWITH_CGAL_ImageIO=OFF -DWITH_CGAL_Qt5=OFF \
  ..
make install -j${CPU_COUNT}


# language bindings are in a separate repo without releases
git clone https://github.com/CGAL/cgal-swig-bindings.git
cd cgal-swig-bindings
mkdir -p build && cd build

cmake \
  -DCMAKE_FIND_ROOT_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DBUILD_JAVA=OFF \
  ..
make install -j${CPU_COUNT}
DYLD_FALLBACK_LIBRARY_PATH=${PREFIX}/lib ctest --output-on-failure -j${CPU_COUNT}

