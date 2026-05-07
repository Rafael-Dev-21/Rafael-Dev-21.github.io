---
title: Batalha rpg em prolog
date:
categories:
  - jogos
  - tutorial
tags:
  - prolog
  - rpg
  - batalha por turnos
  - programação
  - jogos
  - jogo baseado em texto
  - programacao
  - programação lógica
  - lógica
  - predicados
layout: post
last_modified_at:
description: 'Nesse post eu sigo recriando o mesmo jogo de rpg em várias linguagens de programação, mas dessa vez em prolog, uma linguagem de programação lógica.'
comments: true
math: false
toc: true
---

Yohoho, a quanto tempo! Como vocês estão? (Como se tivesse alguém lendo esse blog). Bem, eu andei lendo uma coisa ou outra. Toda essa leitura eventualmente me levou a tentar aprender lógica formal. Primeiro de proposições, então de predicados. Se você, caro leitor, não nerd quanto eu você provavelmente não entendeu nada do que eu escrevi nem a relação disso tudo com o título. Se eu tivesse que chutar, eu diria que você clicou por causa das palavras «batalha» e «rpg» no título, ou porque ficou curioso sobre o que raios é prolog. Se você realmente clicou por causa do prolog, provavelmente somos da mesma ala do hospicio.

Esse post implementa o mesmo jogo que [um artigo anterior](/2023/02/04/programando-uma-batalha-rpg-em-python), e faz parte de [um projeto maior](https://github.com/Rafael-Dev-21/batalha-rpg).

Voltando ao tópico. Estudar sobre lógica me levou a aprender sobre [cláusulas de Horn (em inglês)](https://em.wikipedia.org/wiki/Horn_clause). Uma cláusula de Horn é uma cláusula lógica em que, pelo menos uma de suas proposições, é verdadeira. Imagine assim, você tem uma suposição, e para ela ser verdadeira, várias outras devem ser verdadeiras primeiro.

```
tem_penas E pia E bota_ovo ENTÃO é_pássaro.
```
Também pode ser escrito como:
```
é_passaro SE tem_penas E pia E bota_ovo.
```

Só que, e isso é interessante, tem um jeito mais eficiente de escrever isso. É ai que a cláusula de horn entra.
```
NÃO tem_penas OU NÃO pia OU NÃO bota_ovo OU é_pássaro.
```
Você nega todas as suposições da qual depende, e conectas elas com OU, e coloca a suposição no fim. Se estiver confuso, calma, respire, tente entender como a lógica funciona antes de continuar o artigo.

Pronto?

Isso funciona porque o OU e E funcionam por curto circuito. Aqui vai um exemplo mais simples:
```
é_homem ENTÃO é_mortal.
NÃO é_homem OU é_mortal.
```
Isso é chamado de «regra» nesse ramo da lógica. Também tem fatos. Um fato só é assumido ser verdadeiro.

Por quê eu estou falando de cláusulas de Horn? Ora, por um motivo bem simples: elas são [Turing-Completas (em inglês)](https://en.wikipedia.org/wiki/Turing_completeness). Você pode executar quase qualquer algoritmo usando cláusulas Horn apenas.

## Legal, mas e Prolog?

Prolog é uma linguagem de programação declarativa. Mais especificamente, uma linguagem de programação lógica. Programação lógica usa-se apenas de predicados e inferência. Um predicado é uma função que retorna verdadeiro ou falso. Inferência é o processo do programa tentar chegar a uma conclusão baseado em seu conhecimento. Prolog usa cláusulas Horn.

```prolog
homem(socrates). % um fato

mortal(X) :- homem(X). % uma regra
```
Em prolog, um símbolo começando em letra minúscula é chamado de símbolo, e um em letra maiúscula ou _ é uma variável. Programação prolog é divida em bases de conhecimento e pesquisas. Bases de conhecimento são arquivos de código contendo fatos e regras. Pesquisas são realizadas num loop interativo no terminal. Por exemplo, usando o swi-prolog (uma versão popular de prolog):

``` bash
$ swipl
?- 
```

Esse `?-` é onde vamos inserir pesquisas.
```prolog
?- consult('mortal.pl').
true.
?-
```

Nós estamos consultando a base de conhecimento que acabamos de definir (você está acompanhando com o código, não é?). Também poderiamos ter passado ela como argumento para o swipl:

```bash
$ swipl mortal.pl
?- 
```

Agora podemos fazer uma pesquisa:

```prolog
?- mortal(X).
  X = socrates,
  true.
```

O programa consultou nossa base de conhecimento, e chegou a uma conclusão. Prolog usa um algoritmo chamado unificação. Unificação é um algoritmo que tenta tornar todas as expressões em iguais. Unificação tem três tipos de entidades. Constantes só podem ser iguais a elas mesmas. Variavéis, podem ser presas (bound) ou soltas (unbound). Ao unificar duas variáveis soltas, uma vira um apelido da outra. Ao unificar uma variável solta com uma constante ou estrutura, ela se torna presa a essa constante ou estrutura. Variáveis presas só se unificam se o valor unificado for o mesmo que a variável já tem. Estruturas tem um nome e parâmetros. Uma estrutura só unifica se ambos tiverem o mesmo nome e se todos os parâmetros também unificam. Se tudo correr bem, o programa unifica e conclui, se não ocorre uma falha.

Em caso de falha, o prolog usa outro algoritmo chamado backtracking. É o mesmo algoritmo usado em bots de xadrez. A medida que o programa vai avançando, ele vai armazenando pontos de decisão. Se ocorrer uma falha, o programa volta no último ponto de decisão, soltando as variáveis que foram presas após esse ponto, e tenta a outrs alternativa. Ele continua até conseguir, retornando um sucesso. Se não conseguir, ele retorna uma falha. Prolog funciona em partes como uma linguagem de programação e em partes como um banco de dados.

Eu conheço prolog desde que começei a programar na minha pré-adolescência, mas nunca dei muita atenção. Recentemente, com meu crescente interesse em lógica e em inteligência artifical clássica, eu comecei a estudar mais sobre prolog. Curiosidade: prolog, assim como lisp, foi durante muito tempo a linguagem padrão para se programar inteligências artificiais. Lisp era mais comum na América do Norte e Prolog no Japão e na Europa. Ambas ainda são bastante usadas para isso hoje em dia, sobretudo nos chamados sistemas especialistas.

## Legal, mas e Batalha RPG?

Tudo começou quando eu decidi dar algumas ajustadas nesse meu blog, e acabei relendo o post de [batalha rpg em python que eu escrevi em 2023](https://rafael-dev-21.github.io/2023/02/04/programando-uma-batalha-rpg-em-python).

Relendo esse post, me veio aos poucos a ideia de seguir meu próprio tutorial e implementar esse jogo em prolog. Esse é um «jogo» bem simples, onde o jogador duela até a morte com um goblin. Não deveria ser tão complicado, não é?

### Preliminares

Primeiro, vamos criar uma regra anônima no começo da base de conhecimento para importar a biblioteca `random`, para gerar números aleátorios. Sim, você pode criar regras anônimas, mas elas só são recomendadas para algumas coisas.

```prolog
:- use_module(library(random)).
```

## Ator

Depois, definimos dois fatos, jogador e máquina. Eles vão armazenar os valores default do jogador e do goblin em forma de estruturas.

```prolog
jogador(ator('Você', 100, 10, false)).
maquina(ator('Goblin', 60, 6, true)).
```

Agora, vamos definir alguns predicatos adicionais para extrair um valor de um ator. Em prolog, o jeito de retornar um valor de uma regra é definindo ele como um dos parâmetros.

```prolog
nome(ator(Nome, _, _, _), Nome).
vida(ator(_, Vida, _, _), Vida).
ataque(ator(_, _, Ataque, _), Ataque).
auto_piloto(ator(_, _, _, AutoPiloto), AutoPiloto).
```

As regra `dano` e `toma_hit` serão usados para combate. `toma_hit` retorna um novo ator ao invés de modificar o primeiro.

```prolog
dano(ator(_, _, Ataque, _), Dano) :-
    random_between(0, Ataque, Extra),
    Dano is Ataque + Extra.

toma_hit(ator(Nome, Vida, Ataque, AutoPiloto), Dano, ator(Nome, NovaVida, Ataque, AutoPiloto)) :-
    NovaVida is max(0, Vida - Dano).
```

O predicato de ataque define um fluxo completo de lógica. Unifica dano, imprime mensagem e unifica um novo alvo, mantendo o original imutável.

```prolog
atacar(Ator, Alvo, NovoAlvo) :-
    dano(Ator, Dano),
    nome(Ator, AtorNome),
    nome(Alvo, AlvoNome),
    write(AtorNome), write(' atacou '), write(AlvoNome), write(' causando '), write(Dano), write(' de dano'), nl,
    toma_hit(Alvo, Dano, NovoAlvo).
```

Mostrar é bem auto evidente e sem mistérios. Apenas imprime informação em formato agradável.

```prolog
mostrar(ator(Nome, Vida, _, _)) :-
    write('----------------'), nl,
    write(Nome), nl,
    write('----------------'), nl,
    write('vida: '), write(Vida), nl,
    write('----------------'), nl.
```

### Utilitários

Agora os predicados de suporte!

`intro` imprime um cabeçalho bonito para o jogo.

```prolog
intro :-
    write('#==============#'), nl,
    write('# BATALHA  RPG #'), nl,
    write('#==============#'), nl.
```

O `menu` usa uma técnica chamada recursão para loop. Enquanto o usuárip não digitar algo válido, ele continua chamando a si mesmo.

```prolog
menu(Opcao) :-
   write('Você vê um goblin'), nl,
   write('1) Atacar'), nl,
   write('2, Analisar'), nl,
   write('? '),
   read_line_to_string(user_input, Input),
   (catch(atom_number(Input, Opcao), _, fail), member(Opcao, [1, 2]) -> true;
        write('Opção inválida! Tente novamente.'), nl, menu(Opcao)).
```

Este predicato, `checar_vida`, verifica se alguém morreu e unifica um vencedor. Ele usa o predicado `fail` para tentar outro turno.

```prolog
checar_vida(Ator, Alvo, Vencedor) :-
    (vida(Ator, AtorVida), AtorVida =< 0 -> Vencedor = Alvo;
     vida(Alvo, AlvoVida), AlvoVida =< 0 -> Vencedor = Ator;
     fail).
```

### Batalha!!

Agora a batalha, o coração e cérebro do jogo.

`turno` é o predicado mais complexo. Ele:
1. Verifica se alguém já morreu
2. Caso o ator seja ia, ataca e passa vez
3. Casp ator, mostra estado, pede input, executa ação e passa turno

```prolog
turno(Ator, Alvo, Vencedor) :-
    (checar_vida(Ator, Alvo, Vencedor) -> true;
     auto_piloto(Ator, true) ->
        atacar(Ator, Alvo, NovoAlvo),
        turno(NovoAlvo, Ator, Vencedor);
     auto_piloto(Ator, false) ->
        mostrar(Ator),
        menu(Opcao),
        (Opcao = 1 -> atacar(Ator, Alvo, NovoAlvo);
         Opcao = 2 -> mostrar(Alvo), NovoAlvo = Alvo),
        turno(NovoAlvo, Ator, Vencedor)).
```

`batalha/2` inicia o loop e imprime vencedor. O cut (`!`) previne backtracking após vitória. Sem ele, o prolog poderia tentar encontrar novas soluções para o jogo mesmo após terminar.

```prolog
batalha(Jogador, Maquina) :-
    turno(Jogador, Maquina, Vencedor),
    nome(Vencedor, Nome),
    write(Nome), write(' venceu!'), nl,
    !.
```

`go/0` é o ponto de entrada do jogo, e apenas amarra tudo que fizemos até agora.

```prolog
go :-
    jogador(Jogador),
    maquina(Maquina),
    intro,
    batalha(Jogador, Maquina).
```

## Programa Completo

Aqui todo o programa completo para aqueles que pularam até o fim.

```
:- use_module(library(random)).

jogador(ator('Você', 100, 10, false)).
maquina(ator('Goblin', 60, 6, true)).

nome(ator(Nome, _, _, _), Nome).
vida(ator(_, Vida, _, _), Vida).
ataque(ator(_, _, Ataque, _), Ataque).
auto_piloto(ator(_, _, _, AP), AP).

dano(ator(_, _, Ataque, _), Dano) :-
	random_between(0, Ataque, Extra),
	Dano is Ataque + Extra.

toma_hit(ator(Nome, Vida, Ataque, AutoPiloto), Dano, ator(Nome, NovaVida, Ataque, AutoPiloto)) :-
	NovaVida is max(0, Vida - Dano).

atacar(Ator, Alvo, NovoAlvo) :-
	nome(Ator, AtorNome),
	nome(Alvo, AlvoNome),
	dano(Ator, Dano),
	write(AtorNome), write(' atacou '), write(AlvoNome), write(', causando '), write(Dano), write(' de dano'), nl,
	toma_hit(Alvo, Dano, NovoAlvo).

mostrar(ator(Nome, Vida, _, _)) :-
	write('----------------'), nl,
	write(Nome), nl,
	write('----------------'), nl,
	write('vida: '), write(Vida), nl,
	write('----------------'), nl.

intro :-
	write('#==============#'), nl,
	write('# BATALHA  RPG #'), nl,
	write('#==============#'), nl.

menu(Opcao) :-
	write('Você vê um goblin'), nl,
	write('1) atacar'), nl,
	write('2) analizar'), nl,
	write('? '),
	read_line_to_string(user_input, Input),
	(catch(atom_number(Input, Opcao), _, fail), member(Opcao, [1, 2]) -> true;
		write('Opção inválida! Tente novamente.'), nl, menu(Opcao)).

checar_vida(Ator, Alvo, Vencedor) :-
	(vida(Ator, VidaAtor), VidaAtor =< 0 -> Vencedor = Alvo;
	 vida(Alvo, VidaAlvo), VidaAlvo =< 0 -> Vencedor = Ator;
	 fail).

turno(Ator, Alvo, Vencedor) :-
	(checar_vida(Ator, Alvo, Vencedor) -> true;
	 auto_piloto(Ator, true) ->
	 	atacar(Ator, Alvo, NovoAlvo),
		turno(NovoAlvo, Ator, Vencedor);
	 auto_piloto(Ator, false) ->
	 	mostrar(Ator),
		menu(Opcao),
	 	(Opcao = 1 -> atacar(Ator, Alvo, NovoAlvo);
		 Opcao = 2 -> mostrar(Alvo), NovoAlvo = Alvo),
		turno(NovoAlvo, Ator, Vencedor)).

batalha(Jogador, Maquina) :-
	turno(Jogador, Maquina, Vencedor),
	nome(Vencedor, Nome),
	write(Nome), write(' venceu!'), nl,
	!.

go :-
	jogador(Jogador),
	maquina(Maquina),
	intro,
	batalha(Jogador, Maquina).
```

## Testando o jogo

Chegou a hora de tirar proveito do nosso esforço!

```bash
$ swipl
Welcome to SWI-Prolog (threaded, 32 bits, version 9.3.17)
SWI-Prolog comes with ABSOLUTELY NO WARRANTY. This is free software.
Please run ?- license. for legal details.

For online help and background, visit https://www.swi-prolog.org
For built-in help, use ?- help(Topic). or ?- apropos(Word).

?- consult('batalha.pro').
true.

?- go.
#==============#
# BATALHA  RPG #
#==============#
----------------
Você
----------------
vida: 100
----------------
Você vê um goblin
1) atacar
2) analizar
? 1
Você atacou Goblin, causando 19 de dano
Goblin atacou Você, causando 8 de dano
----------------
Você
----------------
vida: 92
----------------
Você vê um goblin
1) atacar
2) analizar
? 2
----------------
Goblin
----------------
vida: 41
----------------
Goblin atacou Você, causando 7 de dano
----------------
Você
----------------
vida: 85
----------------
Você vê um goblin
1) atacar
2) analizar
? 1
Você atacou Goblin, causando 15 de dano
Goblin atacou Você, causando 9 de dano
----------------
Você
----------------
vida: 76
----------------
Você vê um goblin
1) atacar
2) analizar
? 1
Você atacou Goblin, causando 20 de dano
Goblin atacou Você, causando 6 de dano
----------------
Você
----------------
vida: 70
----------------
Você vê um goblin
1) atacar
2) analizar
? 1
Você atacou Goblin, causando 14 de dano
Você venceu!
true.

?- halt.
```

## Conclusões

Bem, esse artigo só levou um dois anos para concluir após abandoná-lo em 2024 ou 2025. Mas ele não podia permanecer abandonado! Aqui demonstro o poder de prolog, e ainda é uma demostração bem pequena!

Comentem o que acharam, tentem expadir esse jogo vocês mesmos, tem uma olhada no [repo](https://github.com/Rafael-Dev-21/batalha-rpg), e se vocês quiserem uma real demonstração do poder de prolog, confiram [power of prolog (em inglês)](https://www.metalevel.at/prolog).
