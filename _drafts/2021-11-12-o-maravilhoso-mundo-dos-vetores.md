---
layout: post
title: O maravilhoso mundo dos vetores!
date: 2023-02-04 03:00:00
comments: true
description: >-
  Imagine um segmento de reta, e que ele tem módulo direção e sentido, e agora o
  use para calcular movimento, posição, direção, dimensões, etc.
categories:
  - matemática
  - física
  - programação
tags:
  - matemática
  - programação
  - javascript
  - vetores
  - geometria analítica
  - física
usemathjax: true
toc: true
ads: true
math: true
last_modified_at: 2023-02-04 19:39:00
image: /assets/images/vetor-5x3.png
---
## Definições

![Um vetor 5x 3y](/assets/images/vetor-5x3.png "[5, 3], um vetor em coordenadas cartesianas."){: .tofigure}

<dl>
  <dt>P: O que são?</dt>
  <dd>
    <p><strong>R:</strong> Um segmento de reta dotado de módulo (tamanho), direção (horizontal, vertical, etc.) e sentido (para qual das pontas).</p>
  </dd>
  <dt>P: Para que servem?</dt>
  <dd>
    <p><strong>R:</strong> Para representar grandezas vetoriais, grandezas que tem além de tamanho, tem direção e sentido, como velocidade, aceleração, posição, direção, rotação, dimensões…</p>
  </dd>
</dl>

## Usos

Alguns usos dos vetores.

### No mundo da física

Vetores tem grande utilidade na física, permitindo realizar cálculos de trajeto e velocidade, eu não sou tão bom em física, mas sei que a gravidade é um vetor:
 \\\[\\begin\{bmatrix\}0 \\\\ 9,8 \\\\ 0\\end\{bmatrix\}\\\]

### No mundo dos jogos

Os vetores são muito úteis na programação de jogos por abstrair certas dinâmicas, como movimento e orientação.

## Coordenadas

Os vetores podem ser representados de diversas formas em diferentes modelos de coordenadas, vamos as duas mais comuns.

### Cartesianas

Nesse modelo temos uma coordenada x e uma y. x é horizontal e y é vertical. pode ser extendida para 3d com uma coordenada z para a