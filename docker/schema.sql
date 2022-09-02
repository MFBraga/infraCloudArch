-- create database
CREATE DATABASE IF NOT EXISTS impacta;

-- create user for database
CREATE USER IF NOT EXISTS 'mauricio'@'localhost' IDENTIFIED BY 'password';
GRANT CREATE, ALTER, INDEX, LOCK TABLES, REFERENCES, UPDATE, DELETE, DROP, SELECT, INSERT ON `impacta`.* TO 'mauricio'@'localhost';

-- 
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
ALTER USER 'mauricio'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';

-- create table
USE impacta;
CREATE TABLE IF NOT EXISTS students(
    ra INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(50)
);

-- insert values
INSERT INTO students VALUES (2201495, 'Mauricio Braga', 'mauricio.braga@aluno.faculdadeimpacta.com.br');

FLUSH PRIVILEGES;