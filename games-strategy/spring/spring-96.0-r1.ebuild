# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} = *rc ]]; then
	GIT_ECLASS="git-2"
	EGIT_REPO_URI="git://github.com/spring/spring.git"
	EGIT_BRANCH="release"
elif [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-2"
	EGIT_REPO_URI="git://github.com/spring/spring.git"
	EGIT_BRANCH="develop"
else
	SRC_URI="mirror://sourceforge/springrts/${PN}_${PV}_src.tar.lzma"
fi
KEYWORDS="~x86 ~amd64 ~ia64"

inherit cmake-utils games

CFLAGS="-O2 -pipe"
CXXFLAGS=$CFLAGS

CMAKE_VERBOSE="OFF"


DESCRIPTION="A 3D multiplayer real-time strategy game engine"
HOMEPAGE="http://springrts.com"
S="${WORKDIR}/${PN}_${PV}"

LICENSE="GPL-2"
SLOT="${PV}"
IUSE="+ai +java +default headless dedicated test-ai debug -custom-march -custom-cflags +tcmalloc -lto test"
RESTRICT="nomirror strip"
#PREFIX="$PREFIX/$SLOT"

REQUIRED_USE="
	|| ( default headless dedicated )
	java? ( ai )
"

GUI_DEPEND="
	media-libs/devil[jpeg,png,opengl,tiff,gif]
	>=media-libs/freetype-2.0.0
	>=media-libs/glew-1.6
	media-libs/libsdl2[X,opengl]
	x11-libs/libXcursor
	media-libs/openal
	media-libs/libvorbis
	media-libs/libogg
	virtual/glu
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
	app-arch/p7zip
	>=dev-util/cmake-2.6.0
	tcmalloc? ( dev-util/google-perftools )
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

	# Custom march may break online play
	if use custom-march ; then
		ewarn "\e[1;31m*********************************************************************\e[0m"
		ewarn "You enabled Custom-march! ('custom-march' USE flag)"
		ewarn "It may break online play."
		ewarn "If so, disable it before doing a bugreport."
		ewarn "\e[1;31m*********************************************************************\e[0m"

		mycmakeargs="${mycmakeargs} -DMARCH_FLAG=$(get-flag march)"
	else
		mycmakeargs="${mycmakeargs} -DMARCH_FLAG=generic"
	fi

	cmake-utils_src_configure
}

src_compile () {
	cmake-utils_src_compile
}

src_install () {
	cmake-utils_src_install

	prepgamesdirs
}

