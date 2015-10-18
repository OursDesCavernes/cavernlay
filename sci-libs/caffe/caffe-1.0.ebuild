# Copyright 2014 Julian Ospald <hasufell@posteo.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils eutils git-r3

DESCRIPTION="Caffe is a deep learning framework made with expression, speed, and modularity in mind."
HOMEPAGE="http://caffe.berkeleyvision.org/"
EGIT_REPO_URI="https://github.com/BVLC/caffe.git"
#if [ "${PV%9999}" = "${PV}" ]; then
#	EGIT_COMMIT="Release_v${PV}"
#fi
EGIT_COMMIT="rc2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug doc opencl python python-layer lmdb leveldb opencv"

PYTHON_COMPAT=( python2_7 )

RDEPEND="sci-libs/hdf5"
DEPEND="${RDEPEND}
   opencv? ( >media-libs/opencv-2.4 )
   >dev-libs/boost-1.55
   sys-libs/libunwind
   dev-libs/protobuf
   dev-cpp/glog
   dev-cpp/gflags
   lmdb? ( dev-db/lmdb )
   app-arch/snappy
   leveldb? ( dev-libs/leveldb )
   sci-libs/hdf5
   || ( sci-libs/openblas
   sci-libs/atlas
   sci-libs/mkl )
   opencl? ( virtual/opencl )"


src_configure() {
    local mycmakeargs=("-DBLAS=open")
    if use debug; then
		local mycmakeargs+=("-DCMAKE_BUILD_TYPE=Debug" "-DUSE_TIMER=ON")
	else
		local mycmakeargs+=("-DCMAKE_BUILD_TYPE=Release" "-DUSE_TIMER=OFF")
    fi
	mycmakeargs+=($(cmake-utils_use_use opencl OPENCL))
	mycmakeargs+=($(cmake-utils_use_use opencl CLGEMM))
	mycmakeargs+=($(cmake-utils_use_build python))
	mycmakeargs+=($(cmake-utils_use_build python-layer python_layer))
	mycmakeargs+=($(cmake-utils_use_use lmdb LMDB))
	mycmakeargs+=($(cmake-utils_use_use leveldb LEVELDB))
	mycmakeargs+=($(cmake-utils_use_use opencv OPENCV))
	mycmakeargs+=($(cmake-utils_use_build doc docs))

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
#	dodir "usr/$(get_libdir)/OpenCL/vendors/${PN}"
#	dosym "/usr/$(get_libdir)/${PN}/libcl.so" "usr/$(get_libdir)/OpenCL/vendors/${PN}/libOpenCL.so"
#	dosym "/usr/$(get_libdir)/${PN}/libcl.so" "usr/$(get_libdir)/OpenCL/vendors/${PN}/libOpenCL.so.1"
#	dosym "/usr/$(get_libdir)/${PN}/libcl.so" "usr/$(get_libdir)/OpenCL/vendors/${PN}/libOpenCL.so.1.2"
}

