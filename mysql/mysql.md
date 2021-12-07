# Mysql - Mariadb

>Open Mysql - Mariadb 

```sql
mysql || or mysql -D asterisk || or mysql -uroot -p 
```
> show **databases**

    show databases;
    >>>     +--------------------+
            | Database           |
            +--------------------+
            | asterisk           |
            | asteriskcdrdb      |
            | information_schema |
            | mysql              |
            | performance_schema |
            +--------------------+
> use ***databases***

    use mysql;
> show info **`users`**

    SELECT User, Host, Password FROM mysql.user;
    
    +-------------+-----------+-------------------------------------------+
    | User        | Host      | Password                                  |
    +-------------+-----------+-------------------------------------------+
    | root        | localhost |                                           |
    | freepbxuser | localhost | *955992FADA4B07FBC09480B85EB0B53E3C5F9D7E |
    +-------------+-----------+-------------------------------------------+

>Then create your user and password with the following

    CREATE USER ‘someuser’@’%’ IDENTIFIED BY ‘somepassword’;

>Define from where the resource can connect , we’ll use anywhere

    GRANT USAGE ON *.* TO 'someuser'@'someipaddress' IDENTIFIED BY 'somepassword'; 
    GRANT SELECT ON asteriskcdrdb.* TO 'someuser'@'someipaddress' identified by 'somepassword';
    <>> or
    grant select on asteriskcdrdb.* TO ‘someuser’@’%’;

>Finally apply the new permissions with

    FLUSH PRIVILEGES;

>You can then test with something like mysql workbench

    mysql -u someuser -h pbx_ip -p


## Centos 7:
```sh
    iptables -A INPUT -s localhost -p tcp --destination-port 3306 -j ACCEPT
    iptables -A INPUT -s 192.168.1.25 -p tcp --destination-port 3306 -j ACCEPT
    iptables -A INPUT -p tcp -m tcp --dport 3306 -j ACCEPT
    firewall-cmd --permanent --add-port=3306/tcp
    iptables-save
    iptables-save | grep 3306
    Ubuntu
    ufw allow 3306/tcp
    ufw reload
```

```sh
fwconsole stop
mysqldump asteriskcdrdb > asteriskcdrdb_export.sql
ls -alh
```

# **`Note that:`**
- infor databases asterisk freepbx
```sh
    vim /etc/freepbx.conf

    $amp_conf['AMPDBUSER'] = 'freepbxuser';
    $amp_conf['AMPDBPASS'] = 'e2b4b16877124e80b3d261e7dcc31398';
    $amp_conf['AMPDBHOST'] = 'localhost';
    $amp_conf['AMPDBNAME'] = 'asterisk';
    $amp_conf['AMPDBENGINE'] = 'mysql';
    $amp_conf['datasource'] = ''; //for sqlite3
```
Beside you can change password default or foget
>Create a secure 20-character password with the command below.

    < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c20
    root@a3955c85e50e:~# HhKnrTBV8do5Byna6GRu
After >>>

    update user set password = password('HhKnrTBV8do5Byna6GRu') where user = 'freepbxuser';
