# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/movim/movim-0.9.1.ebuild,v 1.7 2015/12/17 10:41:54 hasues Exp $
# https://discordapp.com/api/download/canary?platform=linux&format=tar.gz
EAPI=5

inherit eutils gnome2-utils unpacker

DESCRIPTION="Discord Gaming Messenger"
HOMEPAGE="https://discordapp.com/"
SRC_URI="https://discordapp.com/api/download?platform=linux&format=tar.gz -> $P.tar
  ptb? ( https://discordapp.com/api/download/ptb?platform=linux&format=tar.gz -> $P-ptb.tar )
  canary? ( https://discordapp.com/api/download/canary?platform=linux&format=tar.gz -> $P-canary.tar )"

LICENSE="DISCORD"
SLOT="0.0.15"
KEYWORDS="~amd64"
IUSE="ptb canary"
REQUIRED_USE="canary? ( !ptb ) ptb? ( !canary )"
RESTRICT="mirror bindist strip"
S=${WORKDIR}/

RDEPEND="
	sys-libs/zlib
	x11-libs/gtk+:3
	>=dev-libs/atk-2.18.0
	>=x11-libs/pango-1.38.1
	x11-libs/gdk-pixbuf:2
	media-libs/freetype:2
	media-libs/fontconfig:1.0
	dev-libs/glib:2
	>=x11-libs/cairo-1.14.6
	>=sys-apps/dbus-1.10.8
	>=x11-libs/libXi-1.7.5
	>=x11-libs/libXcursor-1.1.14
	>=x11-libs/libXdamage-1.1.4
	>=x11-libs/libXrandr-1.5.0
	>=x11-libs/libXcomposite-0.4.4
	>=x11-libs/libXext-1.3.3
	>=x11-libs/libXfixes-5.0.1
	>=x11-libs/libXrender-0.9.9
	>=x11-libs/libX11-1.6.3
	>=x11-libs/libXtst-1.2.2
	>=x11-libs/libXScrnSaver-1.2.2
	>=x11-libs/libXinerama-1.1.3
	gnome-base/gconf:2
	>=dev-libs/nss-3.23
	>=dev-libs/nspr-4.12
	>=media-libs/alsa-lib-1.0.29
	>=net-print/cups-2.1.3
	>=dev-libs/expat-2.1.1
	canary? ( sys-libs/libcxx )"

# Determine the package contents based on use flag.
QA_PREBUILT="Discord"
if use canary
then
  QA_PREBUILT="DiscordCanary"
elif use ptb
then
  QA_PREBUILT="DiscordPTB"
fi

src_unpack() {

  # Depending on the release version, unpack the appropriate package.
  if use canary
  then
    unpack $P-canary.tar
  elif use ptb
  then
    unpack $P-ptb.tar
  else
    unpack $P.tar
  fi

}

src_install() {
echo $QA_PREBUILT
	# Install the core Application.
	dodir /opt/${PN}
	insinto /opt/${PN}
	doins -r ${QA_PREBUILT}/*
	fowners root:users /opt/${PN}
	fperms 0755 /opt/${PN}
	exeinto /opt/${PN}
	doexe ${QA_PREBUILT}/${QA_PREBUILT}
	dosym /opt/${PN}/${QA_PREBUILT} /usr/bin/discord
	# Icons
	#insinto /usr/share/icons/hicolor/256x256
	doicon -s 256 ${QA_PREBUILT}/discord.png
	# Install Application link
	insinto /usr/share/applications
	# Make sure to change the desktop file based on the version of the client.
	if use ptb
	then
          sed -i.bak -e 's/\/usr\/share/\/opt/' ${QA_PREBUILT}/discord-ptb.desktop
          domenu ${QA_PREBUILT}/discord-ptb.desktop
        elif use canary
        then
          sed -i.bak -e 's/\/usr\/share/\/opt/' ${QA_PREBUILT}/discord-canary.desktop
          domenu ${QA_PREBUILT}/discord-canary.desktop
        else
          sed -i.bak -e 's/\/usr\/share/\/opt/' ${QA_PREBUILT}/discord.desktop
          domenu ${QA_PREBUILT}/discord.desktop
        fi

}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	
	# Explain to the users where their configuration data lives:
	if use canary
	then
          elog "User configuration data resides in ~/.config/discordcanary."
        elif use ptb
        then
          elog "User configuration data resides in ~/.config/discordptb."
        else
          elog "User configuration data resides in ~/.config/discord."
        fi
	
}

pkg_postrm() {
	gnome2_icon_cache_update
}
