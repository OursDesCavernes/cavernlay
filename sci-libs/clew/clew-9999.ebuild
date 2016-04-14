# Copyright 2014 Julian Ospald <hasufell@posteo.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils eutils git-r3

DESCRIPTION="The OpenCL Extension Wrangler Library"
HOMEPAGE="https://github.com/martijnberger/clew"
EGIT_REPO_URI="https://github.com/martijnberger/clew.git"
if [ "${PV%9999}" = "${PV}" ]; then
	EGIT_COMMIT="${PV}"
else
	EGIT_COMMIT="HEAD"
fi

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug doc +shared test"

RDEPEND="virtual/fortran"
DEPEND="${RDEPEND}
   virtual/opencl
   >=dev-util/cmake-2.8.4"


src_configure() {
    mycmakeargs=($(cmake-utils_use_build test TESTS) $(cmake-utils_use_build shared SHARED_LIBRARY))

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}

