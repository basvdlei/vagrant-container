FROM docker://registry.fedoraproject.org/fedora:31
RUN dnf install -y openssh-clients vagrant vagrant-libvirt
CMD [ "/bin/bash" ]
