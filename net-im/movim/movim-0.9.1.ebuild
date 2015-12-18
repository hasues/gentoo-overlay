# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/movim/movim-0.9.1.ebuild,v 1.7 2015/12/17 10:41:54 hasues Exp $

EAPI=5

inherit eutils gnome2-utils unpacker

DESCRIPTION="P2P Social Networking Client for Movim"
HOMEPAGE="https://movim.eu/"
SRC_URI="http://apt.movim.eu/debian/pool/main/m/${PN}/${PN}_${PV}_amd64.deb"

LICENSE="AGPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

QA_PREBUILT=opt/bin/${PN}
RESTRICT="mirror bindist strip"
S=${WORKDIR}/

RDEPEND="
	sys-apps/dbus
	sys-libs/zlib
	app-arch/bzip2
	dev-libs/libgpg-error
	dev-libs/glib:2
	dev-libs/expat
	dev-libs/atk
	dev-libs/gmp
	dev-libs/nettle
	dev-libs/nss
	dev-libs/nspr
	dev-libs/dbus-glib
	dev-libs/libtasn1
	dev-libs/libffi
	x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXcursor
	x11-libs/gtk+:2
	x11-libs/gdk-pixbuf
	x11-libs/pango
	x11-libs/cairo
	x11-libs/libxcb
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXtst
	x11-libs/libXinerama
	x11-libs/pixman
	x11-libs/libXdmcp
	x11-libs/libXau
	media-gfx/graphite2
	gnome-base/gconf:2
	media-libs/freetype
	media-libs/fontconfig
	media-libs/libpng:0/16
	media-libs/alsa-lib
	media-libs/harfbuzz
	net-print/cups
	net-libs/gnutls
"

QA_PREBUILT="opt/movim/movim"

src_install() {

	# Install the core Application.
	insinto /opt
	doins -r opt/${PN}
	fowners root:users /opt/movim/movim
	fperms 0755 /opt/movim/movim
	dosym /opt/movim/movim /usr/bin/movim
	# Icons
	insinto /usr/share/icons/hicolor
	local scale
	for scale in 22 24 32 48 64 128 256
	do
	  doicon -s ${scale} usr/share/icons/hicolor/${scale}x${scale}/apps/${PN}.png
	done

	# Install Application link
	insinto /usr/share/applications
	domenu usr/share/applications/${PN}.desktop

}

pkg_preinst() {
	gnome2_icon_savelist

	rm -rf "${EROOT}"/usr/share/${PN} #421165
}

pkg_postinst() {
	gnome2_icon_cache_update


}

pkg_postrm() {
	gnome2_icon_cache_update
}
