![Logo do GitHub](https://github.com/BeatrizPlacido/Billinho_/blob/main/Logo.png)

<div align="center">
  <a href="#Product-Backlog">Product Backlog</a> •
  <a href="#Estrutura---Entidades-relacionais">Estrutura</a> •
  <a href="#Tecnologias-e-Ferramentas">Tecnologias e Ferramentas</a> 
</div>


# Billinho: Time de Suporte | Quero Educação
O projeto tem como objetivo principal o aprendizado do estagiário que está entrando no time de Suporte Graduação. O objetivo desenvolver um modelo de API de gerenciamento das mensalidades, de forma semelhante ao produto Quero Pago, porém, em menor escala.

## Proposta
> A empresa Quero Educação está desenvolvendo um sistema para ajudar os alunos a gerenciar suas mensalidades! Esse sistema está quase pronto, mas ainda precisa de uma API para expor os dados do sistema para a instituição de ensino, e o seu objetivo neste desafio é justamente desenvolver essa API

## Product Backlog 📜
| Features                                  |Status| 
|-------------------------------------------|------|
|Listagem e criação de Instituição de Ensino|  ✅  |
|Listagem e criação de Alunos               |  ✅  |
|Listagem e criação de Matrículas           |      |
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

## Tecnologias e Ferramentas
![Logo do Rails](https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.stickpng.com%2Fimg%2Ficons-logos-emojis%2Ftech-companies%2Fruby-on-rails-round-logo&psig=AOvVaw0S8hyEDAEJG0PvlDGhBbim&ust=1704332160961000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCKDn6ZuKwIMDFQAAAAAdAAAAABAI)

![Logo do Ruby](https://www.google.com/url?sa=i&url=https%3A%2F%2Ficonscout.com%2Ficons%2Fruby&psig=AOvVaw1nxT_KA-zdc6Ogz_9Qf39p&ust=1704332241236000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCLiG08iKwIMDFQAAAAAdAAAAABAJ)

![Logo do Postman](https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.stickpng.com%2Fimg%2Ficons-logos-emojis%2Ftech-companies%2Fpostman-logo&psig=AOvVaw1MeWjQHhEovNM7u8qdj9xg&ust=1704332295378000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCPDBi9yKwIMDFQAAAAAdAAAAABAc)

![Logo do Json](https://www.google.com/url?sa=i&url=https%3A%2F%2Ffreebiesupply.com%2Flogos%2Fjson-logo%2F&psig=AOvVaw2gNc0Vw3tDKM-piCXh9BC8&ust=1704332366046000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCJiCn4CLwIMDFQAAAAAdAAAAABAD)

![Logo do SQL](https://www.google.com/url?sa=i&url=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3ASql_data_base_with_logo.png&psig=AOvVaw21iUjawO3Q2bxWhPKPs27Z&ust=1704332425525000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCPiK_6GLwIMDFQAAAAAdAAAAABAm)