FROM ubuntu:18.04

# Update apt packages
RUN apt update
RUN apt upgrade -y

# Install vim
RUN apt install vim -y
RUN apt-get install -y apache2
RUN service apache2 start
RUN apt-get install curl -y
COPY hospital-web /var/www/html



# Install python 3.7
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt install python3.7 -y

# Make python 3.7 the default
RUN echo "alias python=python3.7" >> ~/.bashrc
RUN export PATH=${PATH}:/usr/bin/python3.7
RUN /bin/bash -c "source ~/.bashrc"

# Install pip
RUN apt install python3-pip -y
RUN python3 -m pip install --upgrade pip

#install mongodb
RUN echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu/ xenial/mongodb-org/3.4 multiverse" |  tee /etc/apt/sources.list.d/mongodb-3.4.list

RUN apt install -y mongodb
#RUN mkdir -p /data/db
#RUN chown -R mongodb:mongodb /data/db
#ADD var/lib/mongodb/mongodb.conf /etc/mongodb.conf
#ADD mongodb.pem /etc/ssl/certs/mongodb.pem

#VOLUME ["/data/db"]
#EXPOSE 27017
#ENTRYPOINT ["/usr/bin/mongod", "--config", "/etc/mongodb.conf"]
#
#RUN apt-get install systemd -y
RUN service mongodb start
# install Python modules needed by the Python app
COPY requirement.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirement.txt

# copy files required for the app to run
RUN mkdir /usr/src/app/hospitalmanagement
COPY hospitalmanagement  /usr/src/app/hospitalmanagement
RUN mkdir /usr/src/app/hospitalweb
COPY hospitalweb  /usr/src/app/hospitalweb

COPY manage.py  /usr/src/app/


# tell the port number the container should expose
EXPOSE 8000 8100

# run the application
# RUN pwd
# RUN cd /usr/src/app
# CMD ["python3", "manage.py", "migrate"]
# CMD ["python3", "manage.py", "runserver"]
