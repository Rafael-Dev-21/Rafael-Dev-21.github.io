---
layout: post
title: Programando Uma Batalha RPG em Python
date: 2023-02-04 22:32:00
description: >-
  Nesse post eu irei ensinar-lhe a escrever um simples jogo de batalha por
  turnos em python, inspirado em meu projeto de "O mesmo jogo: em várias
  linguagens de programação".
math: false
categories:
  - tutorial/programação
  - programação/python
  - jogos
tags:
  - python
  - rpg
  - batalha por turnos
  - programação
  - jogos
  - jogo baseado em texto
image: /uploads/capa-batalha-python.png
---
## Introdução

Você já jogou um daqueles RPGs eletrônicos onde você é um sujeito armado praticando genocídio com a população local de monstros? Realmente, esse tipo de jogo costuma ser difícil de pegar o jeito, com alguns títulos bastante complexos, mas com o tempo você já domina as estratégias necessárias para enfrentar os inimigos. Até você ficar forte o suficiente para apenas ficar apertando o botão de ataque sem parar, o que geralmente leva a um game over quando você encontra o primeiro inimigo minimamente competente.

Um jogo nesse estilo é estupidamente complexo, com vários sistemas conectados, que afetam um ao outro mas rodam sem saber da existência dos outros (o que costuma resultar em códigos também complexos). Mas a base do seu sistema de combate é bem simples, flexível, e pode ser adaptada para qualquer linguagem de programação!

Para provar o último ponto do parágrafo anterior, eu criei um projeto no mínimo ambicioso, programar eu mesmo esse sistema no máximo de linguagens de programação o possível. Você pode conferir meu progresso aqui: [https://github.com/rafael-dev-21/batalha-rpg](https://github.com/rafael-dev-21/batalha-rpg){: target="_blank" rel="noopener noreferrer"}. Eu vou ensinar o passo a passo de algumas dessas versões, começando por python. Todo código está sobre a licença GPL 3.0, e esse artigo está sobre creative commons sharealike.

Sem mais enrolação, vamos lá!

## Atores

Jogos são grandes simulações interativas. Essas simulações costumam ser compostas por vários objetos. Alguns representam o ambiente. Outros representam coisas com qual o jogador interagem, e ainda outras que interagem com o outros objetos. Eu costumo chamar esses últimos de entidades ou atores.

O objeto que me refiro é o da programação orientada a objetos? Bem, sim e não. Você não precisa de orientação a objetos para usar esses objetos, mas a orientação a objetos foi criada para facilitar esses tipos de simulação (a primeira linguagem poo se chamava simula).

Já falei o suficiente, vamos ao código.

```python
# batalha.py, arquivo único, licença

import random # nossa única dependência, o método random.randrange

# Ator
class Ator:
  def __init__(self, nome, vida, ataque, auto_piloto):
    self.nome = nome
    self.vida = vida
    self.ataque = ataque
    self.auto_piloto = auto_piloto
  
  def dano(self):
    "calcula o dano"
    return self.ataque + random.randrange(0, self.ataque)
  
  def toma_hit(self, dano):
    "ator foi ferido"
    self.vida -= dano
  
  def atacar(self, alvo):
    "atacar alvo"
    dano = self.dano()
    print(f"{self.nome} atacou {alvo.nome}, causando {dano} de dano")
    alvo.toma_hit(dano)
  
  def mostrar(self):
    "imprime ficha do ator"
    print("-" * 16)
    print(self.nome)
    print("-" * 16)
    print(" vida: " + str(self.vida))
    print("-" * 16) 
```

Uma classe curta e simples, como deveria ser (coff coff). Não tem muito que explicar, esse ator é bem simples se comparado ao de alguma simulação normal, possuindo apenas o nescessário para funcionar. É possível extendê-lo com mais atributos e um sistema de nível, mas isso fica a cargo do leitor ou de um futuro artigo (não prometo nada, hehe).

Já podemos ir para o ciclo do jogo, mas primeiro irei fazer duas funções utilitárias para organizar nosso código.

## Utilitários

Nossa primeira função utilitária imprime a introdução do jogo. Nesse caso é apenas um cabeçalho, mas poderia ter informações de direitos autorais e uma ajuda.

```python
def intro():
  print("#" + "=" * 14 + "#")
  print("# BATALHA  RPG #")
  print("#" + "=" * 14 + "#")
```

A segunda função Imprime um menu e retorna a escolha do jogador. Minha função não lida com o caso do jogador escolher uma opção inválida, o jogo apenas ignora e o jogador perde a vez. O leitor é livre para fazer como quiser.

```python
def menu():
  print("1) atacar")
  print("2) analizar")
  return int(input("? "))
```

## Ciclo de Jogo

Primeiro, uma função `turno`, que representa o que o jogador/máquina faz naquele turno. Se a versão do python da máquina do leitor permitir, você pode trocar o `if elif` por um `match case`.

```python
def turno(ator, alvo):
  if ator.auto_piloto:
    ator.atacar(alvo)
  else:
    ator.mostrar()
    opcao = menu()
    if opcao == 1:
      ator.atacar(alvo)
    elif opcao == 2:
      alvo.mostrar()
```

Segundo, uma função `batalha`, que recebe o jogador e a máquina como entrada e armazena eles nas variáveis a e b. enquando b está vivo, roda um turno e troca o valor de a e b. No último turno, a mata b e os dois trocam de valor, então o vencedor está agora armazenado em b. Por fim, uma mensagem de vitória é impressa.

```python
def batalha(jogador, maquina):
  a, b = jogador, maquina
  while a.vida > 0:
    turno(a, b)
    a, b = b, a
  print(b.nome + " venceu.")
```

## Juntando Tudo

Agora nós executamos o código. Para isso testamos se estamos em um arquivo que foi executado (`__main__`), ou uma biblioteca. Nós separamos o código interno em uma função `main` para evitar variáveis fantasma no escopo global.

```python
def main():
  jogador = Ator("Você", 100, 10, False)
  maquina = Ator("Goblin", 60, 6, True)
  
  intro()
  batalha(jogador, maquina)



if __name__ == "__main__":
  main()
```

Agora basta rodar o programa e jogar o jogo.

```terminal
$ python batalha.py
```

![jogo rodando]({{ page.image }})

## Conclusão

Espero que esse artigo tenha sido didático. Existem muitas formas de expandir esse jogo. Adicionar diferentes tipos de personagens, cada lado ter mais de um personagem, ou até mesmo um inventário. Isso fica a cargo do leitor ou de um possível futuro artigo (he he). Nos vemos por aí.