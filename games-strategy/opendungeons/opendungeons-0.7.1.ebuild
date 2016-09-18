# Copyright 2014 Julian Ospald <hasufell@posteo.de>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils eutils

MY_PN=OpenDungeons

DESCRIPTION="An open source, real time strategy game based on the Dungeon Keeper series"
HOMEPAGE="http://opendungeons.github.io/"
IFS="."
__TMP=(${PV})
unset IFS
MY_PV="${__TMP[0]}.${__TMP[1]}"
unset __TMP
SRC_URI="ftp://download.tuxfamily.org/${PN}/${MY_PV}/${P}.tar.xz"

LICENSE="GPL-3 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="debug test"

RDEPEND=">=dev-games/cegui-0.8.0[ogre,opengl]
	>=dev-games/ogre-1.9.0[freeimage,ois,opengl]
	dev-games/ois
	>=dev-libs/boost-1.55.0
	media-libs/freetype:2
	media-libs/glew
	>=media-libs/libsfml-2
	media-libs/libsndfile
	media-libs/openal
	virtual/jpeg
	virtual/opengl"
#	games-strategy/opendungeons-data

DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-games/ogre[double-precision]"


#CMAKE_IN_SOURCE_BUILD=1

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use test OD_BUILD_TESTING)
		$(cmake-utils_use test BUILD_TESTING)
		$(cmake-utils_use test OD_TREAT_WARNINGS_AS_ERRORS)
		$(cmake-utils_use debug OD_ENABLE_WARNINGS)
		-DOD_DATA_PATH=/usr/share/${MY_PN}
		-DOD_BIN_PATH=/usr/bin/
		-DOD_SHARE_PATH=/usr/share
		)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	doicon "${FILESDIR}"/${PN}.svg
	make_desktop_entry ${MY_PN} ${PN} ${PN}
}

