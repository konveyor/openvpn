FROM quay.io/centos/centos:stream8 AS builder
ADD . .
RUN dnf -y install dnf dnf-plugins-core rpm-build
RUN rpm -ivh *.rpm
RUN dnf config-manager --set-enabled powertools
RUN dnf builddep -y pkcs11-helper*
RUN rpmbuild -ba /root/rpmbuild/SPECS/pkcs11-helper.spec
RUN dnf -y install /root/rpmbuild/RPMS/x86_64/pkcs11-helper*
RUN dnf builddep -y openvpn*
RUN rpmbuild -ba /root/rpmbuild/SPECS/openvpn.spec

FROM registry.access.redhat.com/ubi8:latest
COPY --from=builder /root/rpmbuild/RPMS/x86_64/pkcs11-helper-1* ./
COPY --from=builder /root/rpmbuild/RPMS/x86_64/openvpn-2* ./
RUN dnf -y update && dnf -y install socat stunnel *.rpm && dnf clean all
RUN rm -f *.rpm
