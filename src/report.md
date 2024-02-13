## Part 1. Готовый докер

Установить Docker Engine в Ubuntu https://docs.docker.com/engine/install/ubuntu/

Взять официальный докер образ с nginx и выкачать его при помощи docker pull

![dockerPullNginx](screenshots/dockerPullNginx.png)

Проверить наличие докер образа через docker images

![dockerImages](screenshots/dockerImages.png)

Запустить докер образ через docker run -d [image_id|repository]

![dockerRunNginx](screenshots/dockerRunNginx.png)

Проверить, что образ запустился через docker ps

![dockerPs](screenshots/dockerPS.png)

Посмотреть информацию о контейнере через docker inspect [container_id|container_name]
По выводу команды определить и поместить в отчёт размер контейнера, список замапленных портов и ip контейнера

![size](screenshots/size.png)

![ports](screenshots/ports.png)

![ipAddress](screenshots/ipAddress.png)

Остановить докер образ через docker stop [container_id|container_name]
Проверить, что образ остановился через docker ps

![dockerStop](screenshots/dockerStop.png)

Запустить докер с замапленными портами 80 и 443 на локальную машину через команду run

![runDocker](screenshots/80and443.png)

Проверить, что в браузере по адресу localhost:80 доступна стартовая страница nginx

![checkNginx](screenshots/checkNginx.png)

Перезапустить докер контейнер через docker restart [container_id|container_name]
Проверить любым способом, что контейнер запустился

![dockerRestartAndCheck](screenshots/dockerRestartAndCheck.png)

## Part 2. Операции с контейнером

Прочитать конфигурационный файл nginx.conf внутри докер контейнера через команду exec

![catNginx](screenshots/catNginx.png)

Создать на локальной машине файл nginx.conf

![createNginx](screenshots/createNginx.png)

Настроить в нем по пути /status отдачу страницы статуса сервера nginx

![createNginx2](screenshots/createNginx2.png)

Скопировать созданный файл nginx.conf внутрь докер образа через команду docker cp
Перезапустить nginx внутри докер образа через команду exec

![cpNginx](screenshots/cpNginx.png)

Проверить, что по адресу localhost:80/status отдается страничка со статусом сервера nginx

![checkNginxStatus](screenshots/checkNginxStatus.png)

Экспортировать контейнер в файл container.tar через команду export
Остановить контейнер

![stopDocker](screenshots/stopDocker.png)

Удалить образ через docker rmi [image_id|repository], не удаляя перед этим контейнеры

![rmi](screenshots/rmi.png)

Удалить остановленный контейнер

![rm](screenshots/rm.png)

Импортировать контейнер обратно через команду import
Запустить импортированный контейнер

![importAndRun](screenshots/importRunContainer.png)

![ExecNginx](screenshots/execContainer.png)

Проверить, что по адресу localhost:80/status отдается страничка со статусом сервера nginx

![checkNginxStatus2](screenshots/checkNS2.png)

## Part 3. Мини веб-сервер

Установить на Ubuntu GCC, библиотеку fastcgi и spawn-fcgi

![installGCC](screenshots/installGCC.png)

![installFCGI](screenshots/installfcgi-dev.png)

Написать мини сервер на C и FastCgi, который будет возвращать простейшую страничку с надписью Hello World!

![MyServer](screenshots/my_server.png)

![MyServerCode](<screenshots/my_server code.png>)

Запустить написанный мини сервер через spawn-fcgi на порту 8080

![MyServerStart](<screenshots/my_server start.png>)

Написать свой nginx.conf, который будет проксировать все запросы с 81 порта на 127.0.0.1:8080

![MyServerNginx](screenshots/my_serverNginx.png)

Проверить, что в браузере по localhost:81 отдается написанная вами страничка

![checkMyServer](screenshots/checkMyserver.png)

Положить файл nginx.conf по пути ./nginx/nginx.conf (это понадобится позже)

![cpNginxConf](screenshots/cpNginxConf.png)

## Part 4. Свой докер

Написать свой докер образ, который:

1) собирает исходники мини сервера на FastCgi из Части 3

2) запускает его на 8080 порту

3) копирует внутрь образа написанный ./nginx/nginx.conf

4) запускает nginx.

![dockerfile](screenshots/dockerfile.png)

Собрать написанный докер образ через docker build при этом указав имя и тег

![build](screenshots/build.png)

![scriptMyDocker](screenshots/scriptMyDocker.png)

Проверить через docker images, что все собралось корректно

![checkBuild](screenshots/checkBuild.png)

Запустить собранный докер образ с маппингом 81 порта на 80 на локальной машине и маппингом папки ./nginx внутрь контейнера по адресу, где лежат конфигурационные файлы nginx'а (см. Часть 2)

Проверить, что по localhost:80 доступна страничка написанного мини сервера

![checkMyDocker](screenshots/checkMyDocker.png)

Дописать в ./nginx/nginx.conf проксирование странички /status, по которой надо отдавать статус сервера nginx

![nginxMyDocker](screenshots/nginxMyDocker.png)

Перезапустить докер образ

![runMyDocker](screenshots/runMyDocker.png)

Проверить, что теперь по localhost:80/status отдается страничка со статусом nginx

![checkMyDocker2](screenshots/checkMyDocker2.png)

## Part 5. Dockle

Устанавливаю Dockle для ARM64

![installDockle](<screenshots/install dockle.png>)

Просканировать образ из предыдущего задания через dockle [image_id|repository]

![checkDockleMyDocker](screenshots/checkDockleMyDocker.png)

Исправить образ так, чтобы при проверке через dockle не было ошибок и предупреждений

![DockerfilePart5](screenshots/DockerfilePart5.png)

Добавить переменную DOCKER_CONTENT_TRUST и активировть ее, как было рекомендовано в INFO. Проверим, что переменная экспортирована

![env](screenshots/envDocker_.png)

Собираем образ и запускаем Dockle с принятыми ключами nginx из ошибки CIS-DI-0010

![checkDockleMyDocker2](screenshots/checkDockleMyDocker2.png)

информирование о переменной остается, т.к. новая версия Dockle и что с этим делать пока не понятно. Но это не предупреждение и не ошибка.

## Part 6. Базовый Docker Compose

Установить docker-compose
sudo apt-get install docker-compose

1) Поднять докер контейнер из Части 5 (он должен работать в локальной сети, т.е. не нужно использовать инструкцию EXPOSE и мапить порты на локальную машину)


2) Поднять докер контейнер с nginx, который будет проксировать все запросы с 8080 порта на 81 порт первого контейнера

Замапить 8080 порт второго контейнера на 80 порт локальной машины

![docker-compose.yml](screenshots/docker-compose.png)

![nginxSecondServ](screenshots/nginxconfSS.png)

Остановить все запущенные контейнеры

![dockerPS](screenshots/checkPS.png)

Собрать и запустить проект с помощью команд docker-compose build и docker-compose up

![docker-compose built and up](<screenshots/compose built up.png>)

![docCompUp](screenshots/docCompUp.png)

Проверить, что в браузере по localhost:80 отдается написанная вами страничка, как и ранее

![checkDocker-compose](screenshots/checkDocCompose.png)



