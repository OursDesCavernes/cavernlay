# Copyright 2014 Julian Ospald <hasufell@posteo.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils eutils git-r3

DESCRIPTION="The tuned OpenCL BLAS library"
HOMEPAGE="https://github.com/CNugteren/CLBlast"
EGIT_REPO_URI="https://github.com/CNugteren/CLBlast.git"
if [ "${PV%9999}" = "${PV}" ]; then
	EGIT_COMMIT="${PV}"
else
	EGIT_COMMIT="HEAD"
fi

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug doc +shared test tuners examples"

RDEPEND=""
DEPEND="${RDEPEND}
   >=dev-util/cmake-2.8.10
   virtual/opencl
   >=sys-devel/gcc-4.7.0"

#TODO: clang support

src_configure() {
    mycmakeargs=($(cmake-utils_use test TESTS)
	$(cmake-utils_use examples SAMPLES)
	$(cmake-utils_use tuners TUNERS)
	$(cmake-utils_use_build shared SHARED_LIBRARY))

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}

