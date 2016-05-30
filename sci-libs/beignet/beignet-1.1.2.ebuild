# Copyright 2014 Julian Ospald <hasufell@posteo.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils eutils

DESCRIPTION="Beignet is an open source implementation of the OpenCL specification for Intel GPUs"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/Beignet/"
#EGIT_REPO_URI="git://anongit.freedesktop.org/beignet"
SRC_URI=https://01.org/sites/default/files/${P}-source.tar.gz
#if [ "${PV%9999}" = "${PV}" ]; then
#	EGIT_COMMIT="Release_v${PV}"
#fi

MY_P=Beignet-${PV}-Source

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug ocl-icd"

RDEPEND="virtual/opencl"
DEPEND="${RDEPEND}
   ocl-icd? ( dev-libs/ocl-icd )"

S="${WORKDIR}/${MY_P}"

src_configure() {
    if use debug; then
		local mycmakeargs=(-DCMAKE_BUILD_TYPE=Release)
    fi

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodir "usr/$(get_libdir)/OpenCL/vendors/${PN}"
	dosym "/usr/$(get_libdir)/${PN}/libcl.so" "usr/$(get_libdir)/OpenCL/vendors/${PN}/libOpenCL.so"
	dosym "/usr/$(get_libdir)/${PN}/libcl.so" "usr/$(get_libdir)/OpenCL/vendors/${PN}/libOpenCL.so.1"
	dosym "/usr/$(get_libdir)/${PN}/libcl.so" "usr/$(get_libdir)/OpenCL/vendors/${PN}/libOpenCL.so.1.2"
}

