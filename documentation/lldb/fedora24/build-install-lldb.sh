# These are needed to build lldb
sudo dnf install doxygen libedit-devel libxml2-devel python-argparse python-devel readline-devel swig xz

cd $HOME
wget http://releases.llvm.org/3.9.1/cfe-3.9.1.src.tar.xz
wget http://releases.llvm.org/3.9.1/llvm-3.9.1.src.tar.xz
wget http://releases.llvm.org/3.9.1/lldb-3.9.1.src.tar.xz

tar -xf llvm-3.9.1.src.tar.xz
mkdir llvm-3.9.1.src/tools/clang
mkdir llvm-3.9.1.src/tools/lldb
tar -xf cfe-3.9.1.src.tar.xz --strip 1 -C llvm-3.9.1.src/tools/clang
tar -xf lldb-3.9.1.src.tar.xz --strip 1 -C llvm-3.9.1.src/tools/lldb
rm cfe-3.9.1.src.tar.xz
rm lldb-3.9.1.src.tar.xz
rm llvm-3.9.1.src.tar.xz

mkdir llvmbuild
cd llvmbuild
cmake -DCMAKE_BUILD_TYPE=Release -DLLDB_DISABLE_CURSES=1 -DLLVM_LIBDIR_SUFFIX=64 -DLLVM_ENABLE_EH=1 -DLLVM_ENABLE_RTTI=1 -DLLVM_BUILD_DOCS=0 ../llvm-3.9.1.src

make -j $(($(getconf _NPROCESSORS_ONLN)+1))
sudo make install
cd ..
rm -r llvmbuild
rm -r llvm-3.9.1.src

# Remove the no longer needed packages 
sudo dnf remove doxygen libedit-devel libxml2-devel readline-devel swig
sudo dnf clean all
