#!/bin/bash

#Создание каталога под проект
mkdir -p /root/project 
cp -r reprise-1-task/* /root/project/

#Обновление информации о доступных пакетах
apt update

#Установка curl, компилятора, procps на случай если используется docker 
apt install -y rsync gnupg2 curl gcc g++ make  procps 
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2.69D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby
gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

#Импорт gpg ключей и установка ruby version manager
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
curl -sSL https://get.rvm.io | bash -s stable --ruby
source /usr/local/rvm/scripts/rvm
rvm version
rvm get stable --autolibs=enable
usermod -a -G rvm root

#Установка ruby
rvm install ruby-2.6
rvm --default use ruby-2.6
ruby --version

#Установка bundler и гемов из Gemfile с его помощью
gem update --system
cd /root/project/
gem install bundler
bundle install

#Установка и запуск nginx
apt install -y nginx
systemctl start nginx
systemctl enable nginx
mv /etc/nginx/sites-enabled/default /tmp/
mv ruby /etc/nginx/sites-enabled/
nginx -s reload

#Копирование unit-а systemd, которым запускается приложение
mv puma.service /etc/systemd/system/puma.service 
systemctl daemon-reload
systemctl start puma.service
systemctl enable puma.service
systemctl status puma.service
echo "Done"
