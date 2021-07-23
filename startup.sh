#!/bin/bash
#add steven repository, enable autoupdate for palemoon
echo 'deb http://download.opensuse.org/repositories/home:/stevenpusser/Debian_10/ /' | tee /etc/apt/sources.list.d/home:stevenpusser.list 
curl -fsSL https://download.opensuse.org/repositories/home:stevenpusser/Debian_10/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/home_stevenpusser.gpg > /dev/null

echo 'deb http://download.opensuse.org/repositories/home:/Alexx2000/Debian_10/ /' | sudo tee /etc/apt/sources.list.d/home:Alexx2000.list
curl -fsSL https://download.opensuse.org/repositories/home:Alexx2000/Debian_10/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_Alexx2000.gpg > /dev/null

#set default root password
echo root:${VNCPASS} | sudo chpasswd

if [ -n "${USER_NAME}" ] || [ "${USER_NAME}"!='none' ]
 then
  useradd -m -p $(openssl passwd -1 ${USER_PASSWORD}) -s /bin/bash -G sudo ${USER_NAME}
  sudo usermod -a -G root ${USER_NAME}
  export HOME=/home/${USER_NAME}
  echo ${USER_PASSWORD} | sudo -u ${USER_NAME} -S cp /tmp/xfce4-panel.xml /home/${USER_NAME}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
  cp /root/capslock_toggle.sh /home/${USER_NAME}/capslock_toggle.sh
  #echo ${USER_PASSWORD} | sudo -u ${USER_NAME} -S chown ${USER_NAME}:0 /home/${USER_NAME}/capslock_toggle.sh
  echo "cd /home/${USER_NAME}" >> ~/.bashrc
  sudo -u ${USER_NAME} startxfce4
 else
  echo "Running as root"
  cp /tmp/xfce4-panel.xml /root/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
  startxfce4
fi

#adjust chromium shortcut for running
if [ -e "/usr/share/applications/chromium.desktop" ]
 then
  sed -i 's|Exec=/usr/bin/chromium %U|Exec=/usr/bin/chromium --no-sandbox %U|g' /usr/share/applications/chromium.desktop
 else
  echo "No Chromium installed"
fi

#allow bash script running from thunar
sleep 15
xfconf-query --channel thunar --property /misc-exec-shell-scripts-by-default --create --type bool --set true