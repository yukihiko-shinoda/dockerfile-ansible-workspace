# @see https://docs.docker.com/engine/examples/running_ssh_service/#build-the-image
FROM python:3.8.0-alpine3.10
RUN apk add --no-cache openssh
# pexpect: requirement for Ansible expect module on host side
# @see https://docs.ansible.com/ansible/latest/modules/expect_module.html
RUN pip install --no-cache-dir pexpect
# Impotant! different from example because default of PermitRootLogin setting is commented out!
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
# @see https://github.com/atmoz/sftp/issues/55#issuecomment-254800521
 && ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \
 && ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
EXPOSE 22
# @see https://docs.docker.com/engine/examples/running_ssh_service/#environment-variables
COPY ./entrypoint.sh /usr/bin/entrypoint
RUN chmod +x /usr/bin/entrypoint
CMD ["entrypoint"]
