# Sumário
* [Domain Driven Design](#ddd)
* [Arquitetura](#arquitetura)
* [Camadas](#camadas)

## [Arquitetura](#arquitetura)
A arquitetura proposta para esse projeto permite a separação do software em 4 (quatro) camadas.

<img src="https://resocoder.com/wp-content/uploads/2020/03/DDD-Flutter-Diagram-v3.svg" style="display: block; margin-left: auto; margin-right: auto; width: 30%;"/>

## [Camadas](#camadas)

### Presentation
Nessa camada temos todos os widgets que formam a interface que será apresentada para o usuário. Os events são os métodos que podem opcionalmente carregar algum dado não tratado e ativam a lógica dentro do BLoC. O BloC não faz parte desta camada, mas é ele quem executa a lógica baseada nos events e então devolvem states.

### Application
Essa camada tem apenas uma função: orquestrar todos as outras camadas. Não realiza nenhuma regra de negócio, apenas certifica-se que os dados foram validados.

### Domain
Nessa camada, os dados são validados e as regras de negócio são executadas.

### Infrastructure
A camada Infrastructure é o extremo oposto da camada Presentation. Essa camada é responsável por receber dados de APIs, banco de dados e sensores do dispositivo.

## APP
• Flutter 3.3.2