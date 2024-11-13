FROM jenkins/jenkins:lts
# TODO use alpine ligth image for Jenkins or use image more light

USER root

RUN apt-get update && apt-get install -y lsb-release

RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg

RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y docker-ce-cli

RUN apt-get update && \
    apt-get install -y curl unzip && \
    curl https://releases.hashicorp.com/terraform/1.3.7/terraform_1.3.7_linux_amd64.zip -o terraform.zip && \
    unzip terraform.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform.zip

RUN chmod +x /usr/local/bin/terraform

USER jenkins