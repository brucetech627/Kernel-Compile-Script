# Kernel Clonning Script

git clone https://github.com/brucetech627/kernel_xiaomi_sweet storm
cd storm
git clone --depth=1 -b master https://github.com/MASTERGUY/proton-clang clang
git clone --depth=1 https://github.com/stormbreaker-project/AnyKernel3 -b sweet AnyKernel
cd ..
# Start Build

bash run.sh
