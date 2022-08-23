FROM nginx:stable-alpine
MAINTAINER mauricio.braga@aluno.faculdadeimpacta.com.br

RUN apk update
RUN apk add mysql-client