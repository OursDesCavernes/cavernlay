# Copyright 2014 Julian Ospald <hasufell@posteo.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils eutils git-r3

DESCRIPTION="Torch is a scientific computing framework with wide support for machine learning algorithms."
HOMEPAGE="http://torch.ch/"
EGIT_REPO_URI="https://github.com/torch/torch7.git"
#if [ "${PV%9999}" = "${PV}" ]; then
#	EGIT_COMMIT="Release_v${PV}"
#fi
#EGIT_COMMIT="rc2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug doc openmp"

PYTHON_COMPAT=( python2_7 )

RDEPEND=""
DEPEND="${RDEPEND}
   openmp? ( sys-cluster/openmpi )"


src_configure() {
    local mycmakeargs=("")
    if use debug; then
		local mycmakeargs+=("-DCMAKE_BUILD_TYPE=Debug")
	else
		local mycmakeargs+=("-DCMAKE_BUILD_TYPE=Release")
    fi
	mycmakeargs+=($(cmake-utils_use_with openmp OPENMP))

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
#	dodir "usr/$(get_libdir)/OpenCL/vendors/${PN}"
#	dosym "/usr/$(get_libdir)/${PN}/libcl.so" "usr/$(get_libdir)/OpenCL/vendors/${PN}/libOpenCL.so"
#	dosym "/usr/$(get_libdir)/${PN}/libcl.so" "usr/$(get_libdir)/OpenCL/vendors/${PN}/libOpenCL.so.1"
#	dosym "/usr/$(get_libdir)/${PN}/libcl.so" "usr/$(get_libdir)/OpenCL/vendors/${PN}/libOpenCL.so.1.2"
}

