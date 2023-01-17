#
#reused from build.sh of https://github.com/solana-labs/bpf-tools

BASE_PATH := $(ADALABS_ROOT_PATH)/GitHub/llvm-project
INSTALL_PATH := /opt/solana/gnat-fsf-12/llvm14

all:init-llvm build-and-install-llvm init-lld build-and-install-lld

# taken from bpf-tools build process
init-llvm:
	cmake -G "Ninja" -S $(BASE_PATH)/llvm -B $(BASE_PATH)/build -DLLVM_TEMPORARILY_ALLOW_OLD_TOOLCHAIN=ON -DLLVM_ENABLE_ASSERTIONS=OFF -DLLVM_ENABLE_PLUGINS=OFF -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=BPF -DLLVM_INCLUDE_EXAMPLES=OFF -DLLVM_INCLUDE_DOCS=OFF -DLLVM_INCLUDE_BENCHMARKS=OFF -DLLVM_INCLUDE_TESTS=OFF -DLLVM_ENABLE_TERMINFO=OFF -DLLVM_ENABLE_LIBEDIT=OFF -DLLVM_ENABLE_BINDINGS=OFF -DLLVM_ENABLE_Z3_SOLVER=OFF -DLLVM_PARALLEL_COMPILE_JOBS=4 -DLLVM_TARGET_ARCH=x86_64 -DLLVM_DEFAULT_TARGET_TRIPLE=x86_64-unknown-linux-gnu -DLLVM_ENABLE_ZLIB=ON -DLIBCLANG_BUILD_STATIC=ON -DCLANG_LINK_CLANG_DYLIB=OFF -DLLVM_BUILD_LLVM_DYLIB=OFF -DLLVM_LINK_LLVM_DYLIB=OFF -DLLVM_ENABLE_LIBXML2=OFF -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_VERSION_SUFFIX=-adalabs-dev -DCMAKE_INSTALL_MESSAGE=LAZY -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DCMAKE_ASM_COMPILER=gcc -DCMAKE_C_FLAGS=" -ffunction-sections -fdata-sections -fPIC -m64" -DCMAKE_CXX_FLAGS=" -ffunction-sections -fdata-sections -fPIC -m64" -DCMAKE_INSTALL_PREFIX=$(INSTALL_PATH) -DCMAKE_ASM_FLAGS=" -ffunction-sections -fdata-sections -fPIC -m64" -DCMAKE_BUILD_TYPE=Release

# taken from bpf-tools build process
init-lld:
	cmake -G "Ninja" -S $(BASE_PATH)/llvm -B $(BASE_PATH)/build -DCMAKE_INSTALL_MESSAGE=LAZY -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DCMAKE_ASM_COMPILER=gcc -DCMAKE_C_FLAGS=" -ffunction-sections -fdata-sections -fPIC -m64" -DCMAKE_CXX_FLAGS=" -ffunction-sections -fdata-sections -fPIC -m64" -DLLVM_CONFIG_PATH=$(BASE_PATH)/build/bootstrap/debug/llvm-config-wrapper -DLLVM_INCLUDE_TESTS=OFF -DCMAKE_CXX_STANDARD=14 -DCMAKE_INSTALL_PREFIX=$(INSTALL_PATH) -DCMAKE_ASM_FLAGS=" -ffunction-sections -fdata-sections -fPIC -m64" -DCMAKE_BUILD_TYPE=Release

build-and-install-llvm:
	cmake --build $(BASE_PATH)/build --target install --config Release --

build-and-install-lld:
	cmake --build $(BASE_PATH)/build --target install --config Release --
