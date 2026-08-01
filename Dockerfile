FROM ubuntu:22.04

# Устанавливаем необходимые пакеты
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        openssh-server \
        sudo \
        python3 \
        python3-pip \
        curl \
        wget \
        unzip \
        net-tools \
        systemctl \
        && \
    useradd -m -s /bin/bash vagrant && \
    echo "vagrant:vagrant" | chpasswd && \
    echo "vagrant ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    mkdir -p /var/run/sshd /home/vagrant/.ssh && \
    chmod 700 /home/vagrant/.ssh && \
    sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    ssh-keygen -A 2>/dev/null

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]