# Copyright 2014 Julian Ospald <hasufell@posteo.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils eutils git-r3

DESCRIPTION="OpenCL library to train deep convolutional networks"
HOMEPAGE="http://deepcl.hughperkins.com/"
EGIT_REPO_URI="https://github.com/hughperkins/DeepCL.git"
if [ "${PV%9999}" = "${PV}" ]; then
	EGIT_COMMIT="v${PV}"
else
	EGIT_COMMIT="HEAD"
fi

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug doc jpeg internal-lua cog prototyping png maintainer test"

PYTHON_COMPAT=( python2_7 python3_4 )

RDEPEND="virtual/fortran"
DEPEND="${RDEPEND}
	sci-libs/easycl
	jpeg? ( virtual/jpeg )
	!internal-lua? ( >=dev-lang/lua-5.1 )
	sci-libs/clblas
	>=dev-util/cmake-2.8.7"

CMAKE_REMOVE_MODULES="yes"
CMAKE_REMOVE_MODULES_LIST="build_EasyCL build_clBLAS"

PATCHES=( "${FILESDIR}"/${P}-remove_internal_easycl_clbas.patch )


src_prepare() {
	epatch "${PATCHES}"

	echo "include_directories(/usr/include/easycl)">>${S}/CMakeLists.txt
}

src_configure() {
    mycmakeargs=("-DMAINTAINER_OPTIONS=ON"
		$(cmake-utils_use_build jpeg JPEG_SUPPORT)
		$(cmake-utils_use_build internal-lua INTERNAL_LUA)
		"-DCMAKE_BUILD_TYPE=Release")
#    if use debug; then
#		mycmakeargs+=("-DCMAKE_BUILD_TYPE=Debug")
#	else
#		mycmakeargs+=("-DCMAKE_BUILD_TYPE=Release")
#    fi

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}

