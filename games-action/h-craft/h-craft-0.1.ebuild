# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

SRC_URI="http://data.oursdescavernes.fr/${P}.tar.xz"
KEYWORDS="~x86 ~amd64 ~ia64"

inherit cmake-utils games

#CFLAGS="-O2 -pipe"
#CXXFLAGS=$CFLAGS

CMAKE_VERBOSE="OFF"


DESCRIPTION="A 3D space hovercraft racer"
HOMEPAGE="http://h-craft"
S="${WORKDIR}/${PN}_${PV}"

LICENSE="GPL-2"
SLOT="${PV}"
IUSE=""
RESTRICT=""
#PREFIX="$PREFIX/$SLOT"

#REQUIRED_USE="|| ( default headless dedicated )	java? ( ai )"

GUI_DEPEND="
	media-libs/devil[jpeg,png,opengl,tiff,gif]
	>=media-libs/freetype-2.5.5
	media-libs/libsdl2[X,opengl]
	>=media-libs/libvorbis-1.3.5
	>=media-libs/libogg-1.3.1
	>=media-libs/openal-1.15.1-r2
	virtual/opengl
"

RDEPEND="
	>=dev-libs/boost-1.35
	>=sys-libs/zlib-1.2.5.1[minizip]
	media-libs/devil[jpeg,png]
	java? ( virtual/jdk )
	default? ( ${GUI_DEPEND} )
"

DEPEND="${RDEPEND}
	>=sys-devel/gcc-4.2
	>=dev-util/cmake-2.6.0
"

### where to place content files which change each spring release (as opposed to mods, ota-content which go somewhere else)
#VERSION_DATADIR="${GAMES_DATADIR}/${PN}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with tcmalloc)
		$(cmake-utils_use_build dedicated spring-dedicated)
		$(cmake-utils_use_build headless spring-headless)
		$(cmake-utils_use_build default spring-legacy)
		"-DPRD_BINDIR=bin/${P}"
		"-DPIXMAPS_DIR=share/pixmaps/${P}"
		"-DMIME_DIR=share/mime/${P}"
		"-DLIBDIR=lib/${P}"
		"-DDATADIR=share/games/spring/${P}"
		"-APPLICATIONS_DIR=share/applications/${P}"
	)

	cmake-utils_src_configure
}

src_compile () {
	cmake-utils_src_compile
}

src_install () {
	cmake-utils_src_install

	prepgamesdirs
}

