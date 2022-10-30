# ПРАКТИКА ПО DOCKER

## Требования
- Docker v20.10.18;
- MySQL v8.0.30-0;

## Подготовка
Добавить возможность удаленного доступа к MySQL. Для этого скорректировать файл /etc/mysql/mysql.conf.d/mysqld.cnf.
Найти в нем строку bind-address = 127.0.0.1 и заменить на bind-address = 0.0.0.0
Перезапустить сервис MySQL
```bash
systemctl restart mysql
```

Создать БД, пользователя и назначить ему привелегии 

```sql
mysql> CREATE DATABASE wordpress;
mysql> CREATE USER wordpress@'%' IDENTIFIED BY '<your-password>';
mysql> GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON wordpress.* TO TO wordpress@'%';
mysql> FLUSH PRIVILEGES;
mysql> quit
```
> Вместо <your-password> ввести пароль для БД

После создания БД и пользователя добавить настройки в файл wp-config ([ОПИСАНИЕ ТУТ](https://ubuntu.com/tutorials/install-and-configure-wordpress#6-configure-wordpress-to-connect-to-the-database)).

## Сборка образа
```bash
docker build -t <image_name> .
```
> Вместо <image_name> ввести свое имя образа

## Запуск контейнера
```bash
docker run --name <container_name> -td -p 80:80 <image_name>
```
> Вместо <container_name> ввести свое имя контейнера, а вместо <image_name> - имя образа, созданного на предыдущем шаге
