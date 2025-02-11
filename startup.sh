#!/bin/bash
#add steven repository, enable autoupdate for palemoon
echo 'deb http://download.opensuse.org/repositories/home:/stevenpusser/Debian_10/ /' | tee /etc/apt/sources.list.d/home:stevenpusser.list 
curl -fsSL https://download.opensuse.org/repositories/home:stevenpusser/Debian_10/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/home_stevenpusser.gpg > /dev/null
echo 'deb http://download.opensuse.org/repositories/home:/Alexx2000/Debian_10/ /' | sudo tee /etc/apt/sources.list.d/home:Alexx2000.list
curl -fsSL https://download.opensuse.org/repositories/home:Alexx2000/Debian_10/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_Alexx2000.gpg > /dev/null

#adjust chromium shortcut for running
if [ -e "/usr/share/applications/chromium.desktop" ]; then
     sed -i 's|Exec=/usr/bin/chromium %U|Exec=/usr/bin/chromium --no-sandbox %U|g' /usr/share/applications/chromium.desktop
else
echo "No Chromium installed"
fi

#alllow bash script running from thunar
sleep 30
xfconf-query --channel thunar --property /misc-exec-shell-scripts-by-default --create --type bool --set true
