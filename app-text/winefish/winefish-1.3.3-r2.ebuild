# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools eutils xdg-utils

MY_PV=${PV/%[[:alpha:]]/}

DESCRIPTION="LaTeX editor based on Bluefish"
HOMEPAGE="https://github.com/viettug/winefish"
SRC_URI="https://github.com/viettug/winefish/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="spell"

RDEPEND="
	>=dev-libs/libpcre-6.3
	>=x11-libs/gtk+-2.4:2
	spell? ( app-text/aspell )
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/${P}-desktop.patch
	"${FILESDIR}"/${P}-doc.patch
	"${FILESDIR}"/${P}-memset.patch
	"${FILESDIR}"/${P}-nostrip.patch
	"${FILESDIR}"/${P}-version.patch
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf --disable-update-databases
}

src_install() {
	emake install DESTDIR="${D}" docdir=/usr/share/doc/${PF}/html
	dodoc AUTHORS CHANGES README ROADMAP THANKS TODO
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
