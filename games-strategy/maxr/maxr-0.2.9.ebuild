# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit cmake-utils eutils games

DESCRIPTION="Mechanized Assault and Exploration Reloaded"
HOMEPAGE="http://www.maxr.org/"
SRC_URI="http://www.maxr.org/downloads/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated"

DEPEND=">=dev-util/cmake-2.8
	>=sys-devel/gcc-4.6
	media-libs/libsdl2[video]
	media-libs/sdl2-mixer[vorbis]
	media-libs/sdl2-net"
RDEPEND="${DEPEND}"


src_configure() {
    mycmakeargs=(
		$(cmake-utils_use dedicated MAXR_BUILD_DEDICATED_SERVER)
		"-DCMAKE_BUILD_TYPE=Release")

	cmake-utils_src_configure
}

src_compile () {
    cmake-utils_src_compile
}

src_install() {
#	dogamesbin src/${PN}
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/*
	doicon data/maxr.png
	make_desktop_entry maxr "Mechanized Assault and Exploration Reloaded"
    cmake-utils_src_install
#	prepgamesdirs
}
