# gentoo-overlay
A repo to contain ebuilds I wanted for my own use.

Currently includes:
* AAFM (https://github.com/sole/aafm)
* Keepassc (http://raymontag.github.io/keepassc/)
* Libpurple Matrix.org IM plugin (https://github.com/matrix-org/purple-matrix#readme)
* **Broken: will fox later** Discord Gaming Messenger (https://discordapp.com)
        * Noting the way releases work for Discord, it will be necessary from time to time to cleanup /usr/portage/distfiles and re-run `ebuild discord-9999 digest` when an update is released.
        * This is going to be split into separate ebuilds to track the three different versions of Discord in the future.