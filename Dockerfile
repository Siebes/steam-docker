FROM hurricane/dockergui:xvnc
MAINTAINER Siebes

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# Set environment variables

# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99
ENV GROUP_ID=100

# Gui App Name default is "GUI_APPLICATION"
ENV APP_NAME="Steam"

# Default resolution, change if you like
ENV WIDTH=1920
ENV HEIGHT=1080

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

#########################################
##    REPOSITORIES AND DEPENDENCIES    ##
#########################################
RUN echo 'deb http://archive.ubuntu.com/ubuntu trusty main universe restricted' > /etc/apt/sources.list && \
echo 'deb http://archive.ubuntu.com/ubuntu trusty-updates main universe restricted' >> /etc/apt/sources.list

RUN dpkg --add-architecture i386
ENV WINEPREFIX /home/wine/.wine
RUN wget -nc https://dl.winehq.org/wine-builds/Release.key
RUN apt-key add Release.key
RUN apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/
RUN apt-get update
RUN apt-get install -y --install-recommends winehq-stable

# Install Wine Tricks
RUN wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
RUN chmod +x winetricks 
RUN sudo mv -v winetricks /usr/local/bin

# Install
RUN apt-get install -y cabextract
RUN winetricks corefonts

# Fix Perms
RUN chown -R nobody:users /home/wine 

#########################################
##          GUI APP INSTALL            ##
#########################################

COPY startapp.sh /startapp.sh

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################

VOLUME ["/home/wine/.wine/drive_c/Program Files (x86)/Steam", "/games", "/ssdgames"]
EXPOSE 8080
