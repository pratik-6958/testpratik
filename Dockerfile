FROM 	ubuntu
RUN apt update -y && apt install -y apache2 zip unzip wget
WORKDIR /var/www/html
run wget https://www.free-css.com/assets/files/free-css-templates/download/page296/carvilla.zip
run unzip carvilla.zip
run cp -rvf carvilla/* .
run rm -rf carvilla.zip carvilla
CMD ["apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
