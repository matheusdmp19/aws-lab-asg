# Aws Lab - ASG

## Objetivo

O objetivo desse repositório é ter um modelo em terraform para subir um auto scalling group da aws que colete métricas de utilização de memória pelo cloud watch agent e utilizar essas métricas para escalonamento baseados em memória.

## Requisitos

- terraform
- acess key e secret key da aws exportadas como variável de ambiente

## Configurando o ambiente

    terraform init

## Subindo ambiente

    terraform apply

## Destruindo ambiente

    terraform destroy

## Comandos úteis

Formatar arquivos .tf de forma recursiva

    terraform fmt --recursive

Validar sintaxes de recursos nos arquivos

    terraform validade

Planejar alterações antes de aplicar

    terraform plan
