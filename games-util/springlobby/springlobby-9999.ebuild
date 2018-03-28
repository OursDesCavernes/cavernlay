# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils eutils flag-o-matic git-r3 wxwidgets

DESCRIPTION="lobby client for spring rts engine"
HOMEPAGE="http://springlobby.info"
EGIT_REPO_URI="https://github.com/OursDesCavernes/springlobby.git"
EGIT_BRANCH="master"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="nomirror"
IUSE="+sound debug libnotify gstreamer"

RDEPEND="
	>=dev-libs/boost-1.35
	=x11-libs/wxGTK-2.8*
	net-misc/curl
	libnotify? (    x11-libs/libnotify )
	sound? (
			media-libs/openal
			media-libs/libvorbis
			media-libs/flac
			media-sound/mpg123
			media-libs/alure
	)
	gstreamer? (    media-libs/gstreamer:1.0 )
"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6.0
"

src_configure() {
	if ! use sound ; then
		mycmakeargs="${mycmakeargs} -DOPTION_SOUND=OFF"
	fi
	if use gstreamer ; then
		mycmakeargs="${mycmakeargs} -DGSTREAMER=ON"
	fi

	mycmakeargs="${mycmakeargs} -DAUX_VERSION=(Gentoo,$ARCH) -DCMAKE_INSTALL_PREFIX=/usr/"
	cmake-utils_src_configure
}

src_compile () {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	# bad
	dodir /usr/share/icons/hicolor/scalable/apps/
	dodir /usr/share/games/applications/
}
