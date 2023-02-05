---
layout: post
title: Programando Uma Batalha RPG em Python
date: 2023-02-04 00:00:00
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

Nossa primeira função utilitária 

## Ciclo de Jogo

## Juntando Tudo

## Conclusão