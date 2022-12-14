# TERRAFORM - Criação de IaaS no Microsoft Azure

```
- FACULDADE IMPACTA
- Disciplina: Infrastructure and Cloud Architecture
- Professor:  João Victorino
- Turma:      Arquitetura de Soluções Digitais (AS_04 - 2022)
```

## ✔️ Resumo do Projeto
- Este projeto foi desenvolvido como cumprimento da entrega do Trabalho/Atividade "[Terraform IaaS](https://classroom.google.com/u/0/c/NDYwMDUzMjg3NDUx/a/NDg4NzAxOTQ3NTYx)" (03/08/2022)
- Provisionamento de recursos de infraestrutura (IaaC), usando `Terraform`


## 🔨 Funcionalidades do projeto
- Ambiente: **Microsoft Azure**
- Provisionamento: **Terraform**
- Criação de uma máquina virtual, rodando `NGINX` e acessível via `HTTP` (80-TCP)


## 📁 Files:
- `providers.tf`      >>>     Descrição do(s) Providers
- `variables.tf`      >>>     Declaração de variáveis
- `main.tf`           >>>     Bloco Principal (Resources)
- `output.tf`         >>>     Saídas após a aplicar o Plano de Execução 


## 💻 Outputs:
- Endereço IP (público)
- Nome do Resource Group
- Chave SSH/TLS Privada
