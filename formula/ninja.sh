pkg_set summary "Small build system for use with gyp or CMake"
pkg_set webpage "https://ninja-build.org"
pkg_set git.url "https://github.com/ninja-build/ninja.git"
pkg_set src.url "https://github.com/ninja-build/ninja/archive/v1.11.0.tar.gz"
pkg_set src.sha "3c6ba2e66400fe3f1ae83deb4b235faf3137ec20bd5b08c29bfc368db143e4c6"
pkg_set license "Apache-2.0"
pkg_set dep.pkg "python"

build() {
    run python3 configure.py --bootstrap --verbose --with-python=python3
    run install_bins ninja
}
