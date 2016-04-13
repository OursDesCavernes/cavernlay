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
IUSE="debug doc jpeg internal-lua python test"

PYTHON_COMPAT=( python2_7 python3_4 )

RDEPEND="virtual/fortran"
DEPEND="${RDEPEND}
   jpeg? ( virtual/jpeg )
   !internal-lua? ( dev-lang/lua )
   python? ( dev-lang/python )
   sci-libs/clblas
   >=dev-util/cmake-2.8.7"


src_configure() {
    local mycmakeargs=("-DMAINTAINER_OPTIONS=ON")
    if use debug; then
		local mycmakeargs+=("-DCMAKE_BUILD_TYPE=Debug")
	else
		local mycmakeargs+=("-DCMAKE_BUILD_TYPE=Release")
    fi
	mycmakeargs+=($(cmake-utils_use_build jpeg JPEG_SUPPORT))
	mycmakeargs+=($(cmake-utils_use_build internal-lua INTERNAL_LUA))
	mycmakeargs+=($(cmake-utils_use_build python PYTHON_WRAPPERS))

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
#	dodir "usr/$(get_libdir)/OpenCL/vendors/${PN}"
#	dosym "/usr/$(get_libdir)/${PN}/libcl.so" "usr/$(get_libdir)/OpenCL/vendors/${PN}/libOpenCL.so"
#	dosym "/usr/$(get_libdir)/${PN}/libcl.so" "usr/$(get_libdir)/OpenCL/vendors/${PN}/libOpenCL.so.1"
#	dosym "/usr/$(get_libdir)/${PN}/libcl.so" "usr/$(get_libdir)/OpenCL/vendors/${PN}/libOpenCL.so.1.2"
}

