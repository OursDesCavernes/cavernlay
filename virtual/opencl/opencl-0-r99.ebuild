# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit multilib-build

DESCRIPTION="Virtual for OpenCL implementations"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
CARDS=( fglrx nvidia intel amdgpu)
IUSE="${CARDS[@]/#/video_cards_} mesa"

DEPEND=""
# intel-ocl-sdk is amd64-only
RDEPEND="app-eselect/eselect-opencl
	mesa? ( >=media-libs/mesa-9.1.6[opencl,${MULTILIB_USEDEP}] )
	video_cards_fglrx? (
		>=x11-drivers/ati-drivers-12.1-r1 )
	video_cards_nvidia? (
		>=x11-drivers/nvidia-drivers-290.10-r2 )
	abi_x86_64? ( !abi_x86_32? ( dev-util/intel-ocl-sdk ) )
	video_cards_intel? (
		dev-libs/beignet )
	video_cards_amdgpu? (	
		dev-libs/amdgpu-pro-opencl )"
