FROM docker://registry.fedoraproject.org/fedora:33 AS builder
RUN dnf install -y ruby-devel rubygems make gcc redhat-rpm-config
RUN gem install --install-dir=/usr/share/gems ed25519 bcrypt_pbkdf
RUN cd /usr/share/gems && tar cf /gems.tar {doc,gems,specifications}/{bcrypt_pbkdf,ed25519}*
RUN cd /usr/lib64/gems && tar cf /libs.tar ruby/{bcrypt_pbkdf,ed25519}*

FROM docker://registry.fedoraproject.org/fedora-minimal:33
RUN microdnf install -y openssh-clients tar vagrant vagrant-libvirt \
        --nodocs --setopt install_weak_deps=0 && \
    microdnf clean all -y
COPY --from=builder /*.tar /tmp/
RUN ( cd /usr/share/gems && tar xf /tmp/gems.tar )
RUN ( cd /usr/lib64/gems && tar xf /tmp/libs.tar )

CMD [ "/bin/bash" ]
