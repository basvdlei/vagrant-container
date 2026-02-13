#!/bin/bash
# Add the following flag to enable debug logging.
# --env "VAGRANT_LOG=debug" \
exec podrunner.sh --utf8 --homedir --libvirtd --ssh-agent -- \
	--rm -it \
	--log-driver none \
	--volume /var/lib:/var/lib:ro \
	--env "CONTAINER_TYPE=vagrant" \
        --env "LIBVIRT_DEFAULT_URI=${LIBVIRT_DEFAULT_URI}" \
	--env "EDITOR=vim" \
	--net host \
	--privileged \
	--entrypoint /usr/bin/vagrant \
	localhost/vagrant-container:41 "$@"
