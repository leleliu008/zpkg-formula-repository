pkg_set summary "Bourne-Again SHell, a UNIX command interpreter"
pkg_set webpage "https://www.gnu.org/software/bash"
pkg_set git.url "https://git.savannah.gnu.org/git/bash.git"
pkg_set src.url "https://mirrors.tuna.tsinghua.edu.cn/gnu/bash/bash-5.0.tar.gz"
pkg_set src.sha "b4a80f2ac66170b2913efbfb9f2594f1f76c7b1afd11f799e22035d63077fb4d"
pkg_set version "5.0.16"
pkg_set license "GPL-3.0-or-later"
pkg_set depends "readline"
pkg_set bsystem "configure"

prepare() {
    while read patchitem
    do
        unset PATCH_ITEM_INDEX
        unset PATCH_ITEM_SHA256

        PATCH_ITEM_INDEX="$( printf '%s\n' "$patchitem" | cut -d ' ' -f1)"
        PATCH_ITEM_SHA256="$(printf '%s\n' "$patchitem" | cut -d ' ' -f2)"

        fetch "https://ftp.gnu.org/gnu/bash/bash-5.1-patches/bash51-$PATCH_ITEM_INDEX" --output-dir="$MY_CACHE_DIR/fix/$PACKAGE_NAME"

        patch -p1 < "$MY_CACHE_DIR/fix/$PACKAGE_NAME/bash51-$PATCH_ITEM_INDEX"
    done <<EOF
001 ebb07b3dbadd98598f078125d0ae0d699295978a5cdaef6282fe19adef45b5fa
002 15ea6121a801e48e658ceee712ea9b88d4ded022046a6147550790caf04f5dbe
003 22f2cc262f056b22966281babf4b0a2f84cb7dd2223422e5dcd013c3dcbab6b1
004 9aaeb65664ef0d28c0067e47ba5652b518298b3b92d33327d84b98b28d873c86
005 cccbb5e9e6763915d232d29c713007a62b06e65126e3dd2d1128a0dc5ef46da5
006 75e17d937de862615c6375def40a7574462210dce88cf741f660e2cc29473d14
007 acfcb8c7e9f73457c0fb12324afb613785e0c9cef3315c9bbab4be702f40393a
008 f22cf3c51a28f084a25aef28950e8777489072628f972b12643b4534a17ed2d1
009 e45cda953ab4b4b4bde6dc34d0d8ca40d1cc502046eb28070c9ebcd47e33c3ee
010 a2c8d7b2704eeceff7b1503b7ad9500ea1cb6e9393faebdb3acd2afdd7aeae2a
011 58191f164934200746f48459a05bca34d1aec1180b08ca2deeee3bb29622027b
012 10f189c8367c4a15c7392e7bf70d0ff6953f78c9b312ed7622303a779273ab98
013 c7acb66df435d284304c16ca83a5265f9edd9368612095b01a733d45c77ed5ad
014 6a4ee0c81b437b96279a792c1efcec4ba56f009195a318083db6b53b096f83d0
015 1b37692ef1f6cc3dcec246773443276066e6b1379868f8c14e01f4dfd4df80f0
016 8899144f76a5db1fb41a89ed881c9f19add95728dd71db324f772ef225c5384f
EOF
}

build() {
    configure \
        --without-curses \
        --without-bash-malloc \
        --disable-profiling \
        --enable-readline \
        --enable-select \
        --enable-history \
        --enable-static-link
}
