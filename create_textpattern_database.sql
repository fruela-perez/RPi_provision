CREATE DATABASE `textpattern`;
CREATE USER 'textpattern' IDENTIFIED BY '1234';
GRANT USAGE ON *.* TO 'textpattern'@localhost IDENTIFIED BY '1234';
GRANT USAGE ON *.* TO 'textpattern'@'%' IDENTIFIED BY '1234';
GRANT ALL privileges ON `textpattern`.* TO 'textpattern'@localhost;
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'textpatterns'@localhost; 
