FROM docker://registry.fedoraproject.org/fedora:32
RUN dnf install -y openssh-clients vagrant vagrant-libvirt
RUN dnf install -y ansible
RUN dnf install -y ruby rubygems
ENV VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1
RUN vagrant plugin install vagrant-serverspec

CMD [ "/bin/bash" ]
