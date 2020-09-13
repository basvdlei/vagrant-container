FROM docker://registry.fedoraproject.org/fedora:32
RUN dnf install -y openssh-clients vagrant vagrant-libvirt
RUN dnf install -y ansible
CMD [ "/bin/bash" ]
