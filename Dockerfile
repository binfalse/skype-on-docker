#
# based on https://www.dustri.org/b/running-skype-in-docker.html
#

FROM debian:stable
MAINTAINER Martin Scharm "docker-skype@binfalse.de"

# Skype is i386 only
RUN dpkg --add-architecture i386

# Create a docker:docker user
RUN useradd -m -d /home/docker docker && \
    mkdir -p /var/run/sshd \
             /root/.ssh /home/docker/.ssh
# Install dependencies:
#  openssh-server as we connect to the container via SSH
#  wget to download skype
#  xauth for x forwarding
RUN apt-get update && apt-get install -y --no-install-recommends \
        openssh-server \
        wget \
        xauth

# Install Skype
RUN wget http://download.skype.com/linux/skype-debian_4.3.0.37-1_i386.deb -O /usr/src/skype.deb && \
    echo 'a820e641d1ee3fece3fdf206f384eb65e764d7b1ceff3bc5dee818beb319993c  /usr/src/skype.deb' | sha256sum -c
RUN dpkg -i /usr/src/skype.deb || true
RUN apt-get install -fy && rm /usr/src/skype.deb

# Configure SSH stuff
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config
COPY authorized_keys /root/.ssh/
COPY authorized_keys /home/docker/.ssh/

# Exposes the ssh port
EXPOSE 22

# Start ssh services.
CMD ["/usr/sbin/sshd", "-D"]
