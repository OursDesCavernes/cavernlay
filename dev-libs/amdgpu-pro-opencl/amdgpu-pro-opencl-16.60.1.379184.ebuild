# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

MULTILIB_COMPAT=( abi_x86_{32,64} )
inherit eutils multilib-build unpacker

DESCRIPTION="Ati precompiled drivers for Radeon Evergreen (HD5000 Series) and newer chipsets"
HOMEPAGE="http://support.amd.com/en-us/kb-articles/Pages/AMDGPU-PRO-Beta-Driver-for-Vulkan-Release-Notes.aspx"
BUILD_VER=16.60-379184

SRC_URI="https://www2.ati.com/drivers/beta/amdgpu-pro-${BUILD_VER}.tar.xz"

RESTRICT="fetch strip"

IUSE="fail"

LICENSE="AMD GPL-2 QPL-1.0"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	app-eselect/eselect-opencl
	x11-drivers/xf86-video-amdgpu
"

DEPEND="${RDEPEND}
"

S="${WORKDIR}/amdgpu-pro-${BUILD_VER}"

pkg_nofetch() {
	einfo "Please download"
	einfo "  - ${PN}_${BUILD_VER}.tar.xz" for Ubuntu 16.04
	einfo "from ${HOMEPAGE} and place them in ${DISTDIR}"
}

xunpack_deb() {
	echo ">>> Unpacking ${1} to ${PWD}"
	unpack ${S}/$1
	unpacker ./data.tar*

	# Clean things up #458658.  No one seems to actually care about
	# these, so wait until someone requests to do something else ...
	rm -f debian-binary {control,data}.tar* $1
}

src_prepare() {
	default


	if use amd64 ; then
	#	xunpack_deb "clinfo-amdgpu-pro_${BUILD_VER}_amd64.deb"

#		xunpack_deb "libopencl1-amdgpu-pro_${BUILD_VER}_amd64.deb"
		xunpack_deb "opencl-amdgpu-pro-icd_${BUILD_VER}_amd64.deb"
		xunpack_deb "libdrm-amdgpu-pro-amdgpu1_2.4.70-379184_amd64.deb"

		mkdir -p ./usr/lib64/OpenCL/vendors/amdgpu-pro
		cp -d ./opt/amdgpu-pro/lib/x86_64-linux-gnu/libamdocl* ./usr/lib64/OpenCL/vendors/amdgpu-pro || die "cp failed"
		sed -i "s|libdrm_amdgpu|libdrm_amdgpo|g" ./usr/lib64/OpenCL/vendors/amdgpu-pro/libamdocl64.so
		ln -s "libamdocl64.so" "./usr/lib64/OpenCL/vendors/amdgpu-pro/libOpenCL.so"
		cp -d ./opt/amdgpu-pro/lib/x86_64-linux-gnu/libdrm_amdgpu.so.1.0.0 ./usr/lib64/libdrm_amdgpo.so.1.0.0
		ln -s "libdrm_amdgpo.so.1.0.0" "./usr/lib64/libdrm_amdgpo.so.1"

		echo "/usr/lib64/OpenCL/vendors/amdgpu-pro/libamdocl64.so" > ./etc/OpenCL/vendors/amdocl64.icd
	fi
	if use x86; then
		die "TODO"
#		xunpack_deb "libopencl1-amdgpu-pro_${BUILD_VER}_i386.deb"
		xunpack_deb "opencl-amdgpu-pro-icd_${BUILD_VER}_i386.deb"
		xunpack_deb "libdrm-amdgpu-pro-amdgpu1_2.4.70-379184_i386.deb"

		mkdir -p ./usr/lib32/OpenCL/vendors/amdgpu-pro
		cp -d ./opt/amdgpu-pro/lib/i386-linux-gnu/* ./usr/lib32/OpenCL/vendors/amdgpu-pro || die "cp failed"

		echo "/usr/lib32/OpenCL/vendors/amdgpu-pro/libamdocl32.so" > ./etc/OpenCL/vendors/amdocl32.icd
	fi

	chmod -x ./etc/OpenCL/vendors/*
	rm -rf ./opt ./Packages ./Release ./amdgpu-pro-install ./*.deb
	use fail && die "Fail use flag"

}

src_install() {
	cp -dR -t "${D}" * || die "Install failed!"
}

