FROM docker://registry.fedoraproject.org/fedora:33 AS builder
RUN dnf install -y ruby-devel rubygems make gcc redhat-rpm-config
RUN gem install --install-dir=/usr/share/gems ed25519 bcrypt_pbkdf
RUN cd /usr && tar cf /gems.tar \
      ./share/gems/{doc,gems,specifications}/{bcrypt_pbkdf,ed25519}* \
      ./lib64/gems/ruby/{bcrypt_pbkdf,ed25519}*

FROM docker://registry.fedoraproject.org/fedora-minimal:33
RUN microdnf install -y \
        ansible \
        openssh-clients \
        rubygem-bigdecimal \
        tar \
        vagrant \
        vagrant-libvirt \
        --nodocs --setopt install_weak_deps=0 && \
    microdnf clean all -y
COPY --from=builder /*.tar /tmp/
RUN cd /usr && tar xf /tmp/gems.tar && rm /tmp/gems.tar

RUN mkdir /tmp/vagrant/ && \
    cp /usr/share/vagrant/plugins.json /tmp/vagrant/ && \
    VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1 \
    VAGRANT_HOME=/tmp/vagrant/ \
    vagrant plugin install vagrant-serverspec && \
    cp /tmp/vagrant/plugins.json /usr/share/vagrant/ && \
    cp -r /tmp/vagrant/gems/2.7.3/* /usr/share/vagrant/gems/

CMD [ "/bin/bash" ]
