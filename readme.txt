------СОДЕРЖИМОЕ АРХИВА--------

Архив archive.tar включает следующие файлы:

readme.txt - текущий документ, описание
puma.service - unit файл systemd, с помощью него осуществляется управление службой, после выполнения скрипта статус можно проверить выполнив systemctl status puma.service, продублирован в каталоге проекта, скриптом копируется оттуда
reprise-1-task - каталог с файлами приложения на Ruby
ruby - конфигурационный файл веб-сервера nginx, им автоматически заменяется стандартный конфигурационный файл, продублирован в каталоге проекта, скриптом копируется оттуда
script.sh - скрипт деплоя

------ЗАПУСК--------

Скрипт запускается в окружении с Debian Buster без предустановленного ПО, на сервере или в Docker контейнере собранном с systemd в качестве системы инициализации. 
archive.tar нужно загрузить на диск любым удобным способом (при помощи scp, rsync, скачав wget-ом с другого сервера). Предварительно требуется выполнить с правами суперпользователя

    apt update && apt install ИСПОЛЬЗУЕМЫЙ_ДЛЯ_ЗАГРУЗКИ_ПАКЕТ


Затем распаковать архив

    tar xvf archive.tar

Перейти в каталог 

    cd archive

Выполнить скрипт, для него установлен бит исполнения

    ./script.sh



В конфигурационном файле nginx задан каталог для статического контента, он отдается напрямую nginx. Убедиться в этом можно обратившись к приложению после того как скрипт закончит работу, затем просмотрев лог доступа
    tail -n 20 /var/log/nginx/access.log 

Приложение запускается на порту 9292, на него выполняет проксирование Nginx. Если у сервера на котором запускался скрипт есть внешний ip адрес, то проверять можно обратившись к нему, если нет, то можно проверять локкально выполнив

    curl -v 0.0.0.0/schedule

В ответе будет html код главной страницы приложения.


Список запущенных сервисов

    netstat -nltp
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:9292            0.0.0.0:*               LISTEN      29553/puma 5.5.0 (t 
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      29524/nginx: master 
tcp6       0      0 :::80                   :::*                    LISTEN      29524/nginx: master 
