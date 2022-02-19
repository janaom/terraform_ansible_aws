# terraform_aws
terraform code for the AWS task



The #terraform fmt command is used to rewrite Terraform configuration files to a canonical format and style. 

If there is an error, run:
#terraform state list | grep null
#terraform taint null_resource.grafana_update[0]
#terraform apply -auto-approve


sudo vi /etc/ansible/hosts -> to add 
"[hosts]
localhost
[hosts:vars]
ansible_connection=local
ansible_python_interpreter=/usr/bin/python3"


sudo vi /etc/ansible/ansible.cfg -> to add "host_key_checking = False"


sudo systemctl status grafana -> to check if grafana was removed

aws ec2 wait instance-status-ok --instance-ids i-[AMI] --region [region]

ansible-playbook -i aws_hosts --private-key /home/jana/.ssh/id_rsa playbooks/main.playbook.yml
