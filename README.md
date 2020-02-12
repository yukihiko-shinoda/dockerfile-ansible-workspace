<!-- markdownlint-disable no-trailing-punctuation -->
# What is Ansible Workspace?
<!-- markdownlint-enable no-trailing-punctuation -->

## No longer maintained

Author tryed to separate Ansible Runner and Ansible workspace following micro service design to simplify each container when develop batch task like deployment job. However, author felt only a quite few benifit:

- Workspace have to run sshd service
  - When follow "One process per container" principle, workspace container can't do anything else.
- Building single container for batch task is not so complicated
  - Author thought that the task building container will be easy. however, setting up dependency of batch task is not so complicated task.
- The convenience of local complate outweighs that of having remote
  - More important than task building container is to spend much time when test because all resource is remote from Ansible container so not only Ansible but test process also have to access to remote host to check the result of playbook.

---

Ansible is also useful for creating something like batch process and little bit more maintainable than other setup tools like Shell Script.
[Ansible Runner](https://hub.docker.com/r/ansible/ansible-runner) is suitable for this purpose.
However, when it needs to set up more tools, Ansible Runner image is based on CentOS,
and there are already much tools and libraries in image.
It's better to isolate image between Ansible and workspace.

This container is intended to work with
The image is purposefully light-weight and only containing the dependencies necessary to be connected by Ansible.
It’s intended to be overridden.

# How to use this image

```yaml
---
version: '3.2'
services:
  operator:
    container_name: operator
    depends_on:
      - workdir
    environment:
      RUNNER_PLAYBOOK: playbook.yml
      ANSIBLE_SSH_PASS: p@ssW0rd
    image: ansible/ansible-runner

  workdir:
    container_name: workdir
    environment:
      SSH_PASSWORD: p@ssW0rd
    image: futureys/ansible-workspace
```
