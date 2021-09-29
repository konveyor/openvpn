# OpenVPN
This repo is used to provide an OpenVPN image for crane in order to permit API tunneling.

The RPMS here come from Fedora with the following changes:
- Docs have been disabled in pkcs11-helper to elliminate a string of unavailable build dependencies.
- Unavailable optional cmocka and automake-archive BuildRequires have been removed from openvpn.
