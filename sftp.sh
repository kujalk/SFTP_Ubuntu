#!/bin/bash
sudo apt install openssh-server -y
sudo apt install ssh -y
sudo useradd -p $(openssl passwd -crypt Hello@12) sftp_user01 #max of 8 characters for password
sudo mkdir -p /var/sftp/public/folder1
sudo chown root:root /var/sftp/public
sudo chmod 755 /var/sftp/public
sudo chown sftp_user01:sftp_user01 /var/sftp/public/folder1

sudo echo "
Include /etc/ssh/sshd_config.d/*.conf

ChallengeResponseAuthentication no
PrintMotd no
Subsystem	sftp	/usr/lib/openssh/sftp-server
Port 22 
Match User sftp_user01
ForceCommand internal-sftp 
PasswordAuthentication yes 
ChrootDirectory /var/sftp/public
PermitTunnel no
AllowAgentForwarding no 
AllowTcpForwarding no
X11Forwarding no
" > /etc/ssh/sshd_config

sudo systemctl restart sshd