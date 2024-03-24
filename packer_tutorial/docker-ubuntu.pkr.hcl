packer {
  required_plugins {
    docker = {
      version = ">= 1.0.8"
      source = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "ubuntu" {
  image  = "ubuntu:jammy"
  commit = true
}

build {
  name    = "learn-packer"
  sources = [
    "source.docker.ubuntu"
  ]

  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get install -y redis-server",
      "sed -i 's/^supervised no/supervised auto/' /etc/redis/redis.conf",
      "redis-server /etc/redis/redis.conf --daemonize yes"
    ]
  }

  post-processor "docker-tag" {
    repository = "packer/redis-ubuntu"
    tag        = ["1.1"]
  }
}
