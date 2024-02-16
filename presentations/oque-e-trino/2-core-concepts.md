# Conceitos Chave

-vertical

## Fonte de Dados

* Qualquer sistema que permita que o Trino possa consultar dados
* Dado deve permitir ser representado em formato tabular
* Base de dados, arquivos em sistema de armazendo de objetos entre outros, APIs Rest entre outros.

-vertical

## Cat&aacute;logo

* &Eacute; a abstra&ccedil;&atilde;o que permite que uma fonte de dados conecte-se ao Trino
* Permite que uma fonte de dados seja consultada
* Usa o nome do cat&aacute;logo para acessar a fonte de dados
* Cat&aacute;logo pode ter 1 ou mais schemas
* Define um conector espec&iacute;fico.

-vertical

## Conector

* &Eacute; um plugin no Trino
* Funciona como camada de tradu&ccedil;&atilde;o entre o Trino e a fonte de dados
* Representa a fonte de dados de forma tabular

 