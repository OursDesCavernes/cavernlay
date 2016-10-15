# Copyright 2014 Julian Ospald <hasufell@posteo.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils eutils git-r3

DESCRIPTION="Easy to run kernels using OpenCL"
HOMEPAGE="https://github.com/hughperkins/EasyCL"
EGIT_REPO_URI="https://github.com/hughperkins/EasyCL.git"
if [ "${PV%9999}" = "${PV}" ]; then
	EGIT_COMMIT="v${PV}"
else
	EGIT_COMMIT="HEAD"
fi

LICENSE="MPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug doc +clew test internal-lua"

RDEPEND="virtual/fortran"
DEPEND="${RDEPEND}
   !clew? ( virtual/opencl )
   clew? ( sci-libs/clew )
   internal-lua? ( >=dev-lang/lua-5.1 )
   >=dev-util/cmake-2.8.4"

CMAKE_REMOVE_MODULES="yes"
CMAKE_REMOVE_MODULES_LIST="build_clew"

PATCHES=( "${FILESDIR}"/${P}-clew.patch )

src_configure() {
    mycmakeargs=($(cmake-utils_use_build test TESTS)
		$(cmake-utils_use_use clew CLEW)
		$(cmake-utils_use internal-lua PROVIDE_LUA_ENGINE))

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}

