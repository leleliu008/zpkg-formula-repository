pkg_set summary "Highly capable, feature-rich programming language"
pkg_set webpage "https://www.perl.org"
pkg_set git.url "https://github.com/perl/perl5.git"
pkg_set src.url "https://www.cpan.org/src/5.0/perl-5.34.0.tar.xz"
pkg_set src.sha "82c2e5e5c71b0e10487a80d79140469ab1f8056349ca8545140a224dbbed7ded"
pkg_set license "GPL-1.0-or-later"
pkg_set bsystem "gmake"
pkg_set binbstd "yes"

if [ "$NATIVE_OS_KIND" = linux ] ; then
    #pkg_set dep.pkg "gcc"
    :
fi

build() {
    export  CFLAGS="$(printf '%s\n'  "$CFLAGS" | sed -e 's|--static||g' -e 's|-static||g')"
    export LDFLAGS="$(printf '%s\n' "$LDFLAGS" | sed -e 's|--static||g' -e 's|-static||g')"

    run ./Configure \
        -des \
        -Dprefix=$PACKAGE_INSTALL_DIR \
        -Dcc="'$CC'" \
        -Dar="'$AR'" \
        -Dnm="'$NM'" \
        -Dccflags="'$CFLAGS'" \
        -Dldflags="'$LDFLAGS'" \
        -Dcppflags="'$CPPFLAGS'" \
        -Dlibs="'-lpthread -ldl -lm -lcrypt -lutil -lc'" \
        -Dusenm=false \
        -Duseshrplib=true \
        -Dusedl=true \
        -Duselargefiles \
        -Dusethreads &&
    gmakew &&
    gmakew install
}
