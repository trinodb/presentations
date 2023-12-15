# Casos de Uso

-vertical

## Caso 1: SQL em qualquer fonte

<div style="float: left; width: 60%; text-align: left; font-size:24px;">
  <ul>
    <li>O Trino fala o idioma de muitas fontes de dados</li>
    <li>Isso &eacute; gra&ccedil;as &agrave; <em>Server Provider Interface (SPI)</em></li>
    <li>Fontes de dados incluem base de dados, servi&ccedil;os REST, arquivos CSV ou qualquer coisa que possa ser representado de forma tabular.</li>
  </ul>
</div>


<div style="float: left; width: 40%; ">
  <lottie-player src="../../../../assets/animations/sql-on-anything.json" background="transparent"  speed="1"  style="width: 25vw; display: block; margin-left: auto; margin-right: auto;" loop controls autoplay></lottie-player>
</div>

-vertical

## Caso 2: Federa&ccedil;&atilde;o de Consultas

<div style="float: left; width: 60%; text-align: left; font-size:24px;">
  <ul>
   <li>Todos os dados por ser acessador a partir de um ponto &uacute;nico ao inv&eacute;s de voc&ecirc; precisar mov&ecirc;-los para um mesmo local para que voc&ecirc; consiga consult&aacute;-lo</li>
    <li>Ao contr&aacute;rio de outras ferramentas de virtualiza&ccedil;&atilde;o de dados, que delegam totalmente o processamento, o Trino busca as informa&ccedil;&otilde;es para que ele mesmo consiga fazer o processamento</li>
  </ul>
</div>



<lottie-player src="../../../../assets/animations/distributed-federated.json" background="transparent"  speed="1"  style="width: 20vw; display: block; margin-left: auto; margin-right: auto;" loop controls autoplay></lottie-player>

<!-- .element style="float: left; width: 40%;" -->

-vertical

## Caso 3: _Analytics_ em _object storage_

* _Object storage_ &eacute; barato, distribu&iacute;do, e largamento usado para armazenar
  formatos de dados aberto como ORC, Parquet, JSON, e arquivos CSV
* _Data lake_ &eacute; um caso t&iacute;pico de armazenamento de dados em formatos n&atilde;o estruturados
* Antigamento, _data lakes_ eram lentos devido ao motor de execu&ccedil;&atilde;o, representa&ccedil;&atilde;o ineficiente
  e baixa acessibilidade
* Novas tecnologias melhoraram a velocidade e a descoberta de dados, como
  Iceberg, Amundsen e Trino
* O Trino habilita consultas _adhoc_ em grandes _data lakes_ com Petabytes de dados
* _Data Lakehouse_ &eacute; um _Data Lake_ que inclui manuten&ccedil;&otilde;es de performance agendadas,
  governan&ccedil;a de dados e um cat&aacute;logo de dados avan&ccedil;ado

-vertical

## Caso 4: Batch ETL/ELT

* O Trino foi constru&iacute;do como foco em velocidade e, inicialmente, isso atendia boa parte das demandas
* A velocidade do Trino &eacute; resultado de uma soma de fatores, al&eacute;m do fato do Trino evitar
  salvar o estado intermedi&aacute;rio de informa&ccedil;&otilde;es de consultas durante a execu&ccedil;&atilde;o, o que significa
  que uma query pode falhar se uma &uacute;nica task falhar.
* Para queries que executam entre minutos ou segundos, uma reinicializa&ccedil;&atilde;o do cluster n&atilde;o &eacute; um problema
* A medida que as consultas levam horas, poucas pessoas sabem como otimizar as consultas para diminuir falhas
* O Trino, recentemente, apresentou o mecanismo de toler&acirc;ncia a falhas para lidar com grandes _batches_ e
  tarefas que demandam muito recurso de computa&ccedil;&atilde;o.

-vertical

## Caso 5: Ingest&atilde;o e migra&ccedil;&atilde;o de dados

* Um dos cen&aacute;rios t&iacute;picos de uso intensivo de recurso por um job s&atilde;o os de transforma&ccedil;&atilde;o
  durante ingest&atilde;o ou migra&ccedil;&atilde;o de dados
* ETL &eacute; o nome, normalmente, atribu&iacute;do a esse cen&aacute;rio, em que voc&ecirc; extrai(l&ecirc;) dados de
  uma fonte, transforma o dados em outro formato, e carrega (escreve) ele em um destino
* O Trino pode facilmente fazer isso com um SQL `CREATE TABLE AS SELECT`
* Todas as transforma&ccedil;&otilde;es s&atilde;o modeladas com SQL e o Trino
* Com a capacidade de federa&ccedil;&atilde;o do Trino, voc&ecirc; n&atilde;o est&aacute; limitado a apenas uma &uacute;nica fonte
  de dados por vez
* Muitas ferramentas de orquestra&ccedil;&atilde;o como Airflow, Dagster, DolphinScheduler,
  e Prefect s&atilde;o capazes de se integra-se com o Trino permitindo agendamento.

-vertical

## Caso 6: Governan&ccedil;a de dados centralizada

* Considerando que o Trino se torna um ponto &uacute;nico de acesso a m&uacute;ltiplos sistemas na sua plataforma,
  &eacute; importante garantir a implementa&ccedil;&atilde;o de mecanismos de acesso e seguran&ccedil;a
* Essa &eacute; uma grande vantagem do Trino, j&aacute; que ao inv&eacute;s de ter que implementar
  regras de seguran&ccedil;a de acesso para m&uacute;ltiplas pessoas em m&uacute;ltiplos sistemas, o Trino torna-se um
  pontto central entre controle de acesso e seguran&ccedil;a, diminuindo a quantidade de lugares em que
  voc&ecirc; precisa configur&aacute;-lo
* Al&eacute;m de seguran&ccedil;a, o Trino &eacute; capaz de torna-se um ponto dentral de checagem de qualidade de dados
  usando SQL
* O Trino tamb&eacute;m tem sido utilizado como ponto centralizado para gest&atilde;o do ciclo de vida de dados
  e cat&aacute;logo
