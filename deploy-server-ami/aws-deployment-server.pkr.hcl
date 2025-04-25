packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "sg-deploy-server" {
  ami_name      = "sg-week1-capstone-deploy-server"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami    = "ami-0e449927258d45bc4"
  ssh_username  = "ec2-user"
}

build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.sg-deploy-server"
  ]

  provisioner "shell" {
    inline = [
      "sudo yum install -y yum-utils",
      "sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo",
      "sudo yum -y install packer",
      "sudo yum -y install terraform",
      "sudo yum -y install git",
      "curl -LO \"https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl\"",
      "sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl",
    ]
  }

  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
  }

  post-processor "shell-local" {
    inline = ["export TF_VAR_deploy_server_id=$(jq -r '.builds[-1].artifact_id | split(\":\") | .[1]' manifest.json)", "echo $TF_VAR_deploy_server_id"]
  }
}
