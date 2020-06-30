# Ansible Role: jenkins
*`roles/services/jenkins`*

An ansible role that provisions a system that can act as a [jenkins master](https://www.jenkins.io/)

## Purpose

This role will setup the repo for *jenkins* and install it. It will then start it and create an *admin* user for it. This role expects a box that has `python3` installed.  

TODO_LIST:
  - TODO: Change the jenkins jobs to be templates instead of files.

## How To Use

### Variables (Defaults)

- `jenkins_repo_key`  
    Default = `https://pkg.jenkins.io/debian-stable/jenkins.io.key`  
    Self-explanatory
- `jenkins_repo`  
    Default = `deb https://pkg.jenkins.io/debian-stable binary/`  
    Self-explanatory
- `jenkins_home`  
    Default = `/var/lib/jenkins`  
    The default location for *jenkins* files. In case I need it to be defined mounted somewhere.  
- `jenkins_java_options`  
    Default = `-Djenkins.install.runSetupWizard=false`  
    `JAVA_VARS` that are in needed. For now , making sure the *SetupWizard* doesn't start.
- `jenkins_user`  
    Default = `jenkins`  
    The *user* under which all `jenkins` operations run.
- `jenkins_init_file`  
    Default = `/etc/default/jenkins`  
    The *source* script where all the `init` entries are taken from for starting *jenkins*
- `jenkins_username_password_credentials`  
   Default = `[]`  
   The credentials to be used for *Github* plugins.
- `jenkins_secret_text_credentials`  
   Default = `[]`  
   The credentials to be used for *Github API* plugins.
- `jenkins_ssh_credentials`  
   Default = `[]`  
   The credentials to be used for `ssh` actions. Primarily for packer.
- `jenkins_plugins`  
   Default = `[]`  
   The plugins we want on the jenkins server.

### Variables (Required)

- `jenkins_admin_user` and `jenkins_admin_pass`  
   Default = `admin`  
   The credentials for the initial *admin* user of the *jenkins* instance. They **should be overriden**

### files

- `jobs/*xml`  
   The jobs we want our jenkins server to have.  
   TODO: This should be changed into a template because it should be configure through variables.

### templates

- `init.groovy.d_basic-security.groovy.j2`  
  The file that's needed according to [these instructions](https://jenkins.programmingpedia.net/en/tutorial/7562/jenkins-groovy-scripting) in order to setup the *admin* user without needing the `initialAdminPassword` file.
- `github-plugin-configuration.xml.j2`  
  This file is setting the connection details of the _GitHub API_
- `init.groovy.d_credentials.groovy.j2`  
  This file contains the script that creates the Global credentials we need in our jenkins.

## Playbooks

An example playbook could be like this:
```yaml
---
- name: "Setup jenkins"
  hosts: jenkins
  become: yes
  become_method: sudo
  roles:
    - jenkins
  vars:
    jenkins_admin_user: 'username'
    jenkins_admin_pass: 'password'
```
