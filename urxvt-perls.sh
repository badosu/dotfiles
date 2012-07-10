#/bin/sh

git clone https://github.com/muennich/urxvt-perls.git
cd urxvt-perls
sudo cp clipboard keyboard-select url-select /usr/lib/urxvt/perl
cd ../
rm -rf urxvt-perls
