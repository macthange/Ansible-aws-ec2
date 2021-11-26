#!/bin/bash

###############################################################################################################
#Asumption  about Ansible Master/Controle Machine                                                             #
# 1) install Ansline AWS-EC2Plugin                                                                            #
# ansible-galaxy collection install amazon.aws                                                                #
#                                                                                                             #
# 2) Follwing entry added in /etc/ansible/ansible.cfg                                                         #
# [inventory]                                                                                                 #
# enable_plugins = aws_ec2, host_list, script, auto, yaml, ini, toml#                                         #
#                                                                                                             #
# 3) folwing pachnages are installaed on Ansible Master/Controle Machine                                      #
#sudo yum install -y python3                                                                                  #
#sudo pip3 install --user boto3                                                                               #
#3) Aws cli is installed                                                                                      #
#4) AWS IAM  user key and id configured with default profile or using IAM role attched to controler host      #
#5) allow agent forwarding enable check bellow file                                                           #
# ssh ~/.ssh/config                                                                                           #
# Host *                                                                                                      #
#  ForwardAgent yes                                                                                           #
#6) ansible-vault encrypt ec2_user.pem  ##  password will be given as input in ansible command                #
#                                                                                                             #
#                                                                                                             #
###############################################################################################################


ansible-playbook --private-key ec2_user.pem --ask-pass -i inventory_aws_ec2.yml playbook.yml --extra-var git_branch=dev