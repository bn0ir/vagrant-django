add-apt-repository -y ppa:chris-lea/node.js
apt-get update && apt-get upgrade -y
apt-get install -y nginx libgdbm-dev libncurses5-dev automake libtool bison libffi-dev nginx-extras git libpq-dev nodejs g++ postgresql python-pip python-dev python-imaging libpng-dev libjpeg-dev

#install tty.js
npm install -g tty.js

#create postgresql user and db
sudo -u postgres psql -c "CREATE USER vagrant WITH PASSWORD 'vagrant';"
sudo -u postgres createdb --owner=vagrant vagrant

#change pg_hba.conf
rsync /vagrant/config/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
chown postgres:postgres /etc/postgresql/9.3/main/pg_hba.conf
service postgresql restart

#create app dirs
mkdir /vagrant/logs
mkdir /vagrant/app

#set nginx configs
rsync -av /vagrant/config/nginx /etc/nginx/nginx.conf
rsync -av /vagrant/config/uwsgi.nginx /etc/nginx/sites-available/uwsgi
ln -s /etc/nginx/sites-available/uwsgi /etc/nginx/sites-enabled/uwsgi
rm /etc/nginx/sites-enabled/default

#set tty.js configs
mkdir /home/vagrant/.tty.js
rsync -av /vagrant/config/config.tty.js /home/vagrant/.tty.js/config.json
