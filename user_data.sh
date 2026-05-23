#!/bin/bash
echo "Hello world since bash" > ~/message.txt
yum update -y
yum install httpd -y
systemctl enable httpd
systemctl start httpd