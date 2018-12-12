cd libmempool/
make
make install

cd ../libraries/libmlx4-1.2.1mlnx1/
./autogen.sh
CFLAGS="-Wno-error" ./configure --prefix=/usr/
make
make install

apt -y install libnl-dev
cd ../libibverbs-1.2.1mlnx1/
./autogen.sh
CFLAGS="-Wno-error" LIBS="-lmempool -lrt" ./configure --prefix=/usr/
make
make install

cd ../librdmacm-1.1.0mlnx/
./autogen.sh
./configure --prefix=/usr/
make
make install
