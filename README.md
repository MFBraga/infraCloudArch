# DOCKER - Instanciando contêiners com Docker-Compose

```
- FACULDADE IMPACTA
- Disciplina: Infrastructure and Cloud Architecture
- Professor:  João Victorino
- Turma:      Arquitetura de Soluções Digitais (AS_04 - 2022)
```

## ✔️ Resumo do Projeto
- Este projeto foi desenvolvido como cumprimento da entrega do Trabalho/Atividade "[Docker](https://classroom.google.com/u/0/c/NDYwMDUzMjg3NDUx/a/NTM4OTA0MDg3NTQ2)" (17/08/2022)
- Criação da REDE BRIDGE `bridge_aula04` (user-defined bridge), para assegurar comunicação entre ambos os contêiners
- Execução de contêiner `NGINX`, com mapeamento da porta 80-TCP (HTTP) para acesso via host, e associação a rede `bridge_aula04`
- Execução de contêiner `MySQL`, com mapeamento da porta 3306-TCP para acesso via host, e associação a rede `bridge_aula04`


## 📁 Files:
- `docker-compose.yml`              >>>     Arquivo de especificação do `Docker-Compose`
- `Dockerfile`                      >>>     Build de nova imagem `nginx:stable-alpine`, com a instalação do `mysql-client`
- `99-script.sh`                    >>>     Testes de validação da comunicação de rede entre `NGINX` e `MySQL`
- `mysql-init-files/schema.sql`     >>>     Inserção de Tabela + Dados no `MySQL`


## 💻 Outputs:
- mysqladmin ping -h mysql_aula04 -u mauricio --password=password
- mysql -h mysql_aula04 -u mauricio --password=password -D impacta -e "select * from students"

## 
```
curl -s http://localhost:80
```
