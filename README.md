![Logo do GitHub](https://github.com/BeatrizPlacido/Billinho_/blob/main/Images/Logo.png)

<div align="center">
  <a href="#Product-Backlog">Product Backlog</a> •
  <a href="#Estrutura---Entidades-relacionais">Estrutura</a> •
  <a href="#Tecnologias-e-Ferramentas">Tecnologias e Ferramentas</a> 
</div>


# Billinho: Time de Suporte | Quero Educação
O objetivo é desenvolver um modelo de API de gerenciamento das mensalidades, de forma semelhante ao produto Quero Pago, porém, em menor escala. 

## Proposta
> A empresa Quero Educação está desenvolvendo um sistema para ajudar os alunos a gerenciar suas mensalidades! Esse sistema está quase pronto, mas ainda precisa de uma API para expor os dados do sistema para a instituição de ensino, e o seu objetivo neste desafio é justamente desenvolver essa API

## Product Backlog
| Features                                  |Status| 
|-------------------------------------------|------|
|Listagem e criação de Instituição de Ensino|  ✅  |
|Listagem e criação de Alunos               |  ✅  |
|Listagem e criação de Matrículas           |  ✅  |
|Listagem de Faturas                        |  ✅  |



## Estrutura - Entidades relacionais
### Instituição de Ensino
| Campo | Tipo | Restrições                    |
|-------|------|-------------------------------|
|nome   |Text  |Not null, único                |
|cnpj   |Text  |Somente números, único         |
|tipo   |Text  |Universidade, Escola ou Creche |

### Aluno
| Campo          | Tipo  | Restrições                      |
|----------------|-------|---------------------------------|
|nome            |Text   |Not null, único                  |
|cpf             |Text   |Not null, somente números, único |
|data_nascimento |Date   |                                 |
|telefone_celular|Integer|                                 |
|genero          |Text   |Not null, M ou F                 |
|meio_pagamento  |Text   |Not null, Boleto ou Cartão       |


### Matrícula
| Campo           | Tipo  | Restrições        |
|-----------------|-------|-------------------|
|valor_total_curso|Decimal|Not null, >0       |
|qtd_faturas      |Integer|Not null, >=1      |
|vencimento_fatura|Integer|Not null, >=1, <=31|
|nome_curso       |Text   |Not null           |
|instituição_id   |FK     |Not null           |
|aluno_id         |FK     |Not null           |

### Fatura
| Campo         | Tipo  | Restrições                                                     |
|---------------|-------|----------------------------------------------------------------|
|valor_fatura   |Decimal|Not null                                                        |
|data_vencimento|Date   |Not null                                                        |
|matricula_id   |FK     |Not null                                                        | 
|status         |Text   |Not null, Aberta, Atrasada ou Paga, sendo o valor default Aberta|



