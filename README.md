# ПРАКТИКА ПО DOCKER

## 1. Требования
- Docker v20.10.18;
- MySQL v8.0.30-0;

## 2. Подготовка

### 2.1. Настройка MySQL
Добавить возможность удаленного доступа к MySQL. Для этого скорректировать файл /etc/mysql/mysql.conf.d/mysqld.cnf.
Найти в нем строку bind-address = 127.0.0.1 и заменить на bind-address = 0.0.0.0
Перезапустить сервис MySQL
```bash
systemctl restart mysql
```

### 2.2. Создание БД
Создать БД, пользователя и назначить ему привелегии 

```sql
mysql> CREATE DATABASE wordpress;
mysql> CREATE USER wordpress@'%' IDENTIFIED BY '<your-password>';
mysql> GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON wordpress.* TO wordpress@'%';
mysql> FLUSH PRIVILEGES;
mysql> quit
```
> Вместо <your-password> ввести пароль для БД

### 2.3. Создание конфигурационного файла для подключения Wordpress к БД
После создания БД и пользователя добавить настройки в файл wp-config ([ОПИСАНИЕ ТУТ](https://ubuntu.com/tutorials/install-and-configure-wordpress#6-configure-wordpress-to-connect-to-the-database)).

### 2.4. (опиционально) Настройка Docker для запуска без sudo
Добавить текущего пользователя в группу docker:
```bash
sudo gpasswd -a $USER docker
```
Выполнить регистрацию пользователя в новой группе
```bash
newgrp docker
```
## 3. Сборка образа
```bash
docker build -t <image_name> .
```
> Вместо <image_name> ввести свое имя образа

## 4. Запуск контейнера
```bash
docker run --name <container_name> -td -p 80:80 <image_name>
```
> Вместо <container_name> ввести свое имя контейнера, а вместо <image_name> - имя образа, созданного на предыдущем шаге
