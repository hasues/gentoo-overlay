# gentoo-overlay
A repo to contain ebuilds I wanted for my own use.

Currently includes:
* ~~Movim (https://github.com/edhelas/movim)~~
	* This no longer functions due to Movim removing the binaries and changing their focus to pure mobile.
* AAFM (https://github.com/sole/aafm)
* Keepassc (http://raymontag.github.io/keepassc/)
* Libpurple Matrix.org IM plugin (https://github.com/matrix-org/purple-matrix#readme)
* syncthing (https://syncthing.net/) (Newer version than in Gentoo...to be removed once Gentoo matches this version)
* syncthing-gtk (https://github.com/syncthing/syncthing-gtk) Desktop syncthing client using Python and GTK
* Discord Gaming Messenger (https://discordapp.com)
        * Noting the way releases work for Discord, it will be necessary from time to time to cleanup /usr/portage/distfiles and re-run `ebuild discord-9999 digest` when an update is released.