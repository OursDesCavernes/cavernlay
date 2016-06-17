# Copyright 2014 Julian Ospald <hasufell@posteo.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils eutils git-r3

DESCRIPTION="An automatic OpenCL kernel tuner"
HOMEPAGE="https://github.com/CNugteren/CLTune"
EGIT_REPO_URI="https://github.com/CNugteren/CLTune.git"
if [ "${PV%9999}" = "${PV}" ]; then
	EGIT_COMMIT="${PV}"
else
#	EGIT_COMMIT="HEAD"
	EGIT_BRANCH="development"
fi

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc +shared test examples +opencl"

RDEPEND="virtual/fortran"
DEPEND="${RDEPEND}
   >=dev-util/cmake-2.8.10
   !opencl? ( dev-util/nvidia-cuda-sdk )
   opencl? ( virtual/opencl )
   >=sys-devel/gcc-4.7.0"

#TODO: clang support

src_configure() {
    mycmakeargs=($(cmake-utils_use test TESTS)
	$(cmake-utils_use examples SAMPLES)
	$(cmake-utils_use debug VERBOSE)
	$(cmake-utils_use_use opencl OPENCL)
	$(cmake-utils_use_build shared SHARED_LIBRARY))

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}

