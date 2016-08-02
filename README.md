# pass_app

This application enables U 2 manage ur pass perfectly.

## Installation

```
$ cd /opt
$ git clone https://github.com/lapis-zero09/pass_app.git
$ sqlite3 info.db
sqlite> CREATE TABLE data(service txt not null, id txt not null, pass txt not null);
sqlite> CREATE TABLE user(name txt not null, pass txt not null);
sqlite> INSERT INTO user values("user_name", "password")

$ sudo chown root info.db
$ sudo chown root pass.rb
$ sudo chmod 600 info.db
$ sudo chmod 710 pass.rb
```

and edit your bash_profile or zshrc

```
echo "alias pass='sudo ruby /opt/pass_app/pass.rb'" >> ~/.zshrc
```
