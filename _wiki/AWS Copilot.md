---
layout: post
title:
summary: AWS Copliot은 ECS에서 사용할 인스턴스를 쉽게 생성,배포,변경하게 해주는 CLI 툴이다. 
date: 2023-08-21 15:24:20 +0900
updated: 2024-08-14 21:57:57 +0900
tag:
toc: true
public: false
parent:
latex: false
---

* TOC
{:toc}


# [AWS Copilot CLI](https://aws.github.io/copilot-cli/)

AWS Copliot은 ECS에서 사용할 인스턴스를 쉽게 생성,배포,변경하게 해주는 CLI 툴이다. 이번에 [Wooddadda](https://wooddadda.com)에 인프라를 세팅하며 사용해봤다. 이 툴을 사용하지 않으면 정말... 한땀한땀 할게 엄청 많은데, 이걸로 편하게 작업을 할 수 있었다. 기억에 남기기 위해 어떻게 사용했는지 그 과정과 사용했던 명령어들을 남긴다.

## [Concepts](https://aws.github.io/copilot-cli/docs/concepts/overview/)

Copilot CLI는 `Copilot makes it super easy to set up and deploy your containers on AWS - but getting started is only the first step of the journey.`라는 말과 같이 정말 쉽게(??) AWS 인프라를 생성해준다. 하지만 그 쉽다는건 상대적인 거니깐.. 나는 처음 할땐, 상당히 어려웠고 Copilot 페이지를 많이 읽어가며 적응했다. 지금은 prod, dev의 app server를 copilot을 이용해 생성했고 github action으로 배포하는데, 나중에 뒤돌아서 생각해보니 **Concepts** 페이지가 엄청 중요하더라. 거기에 대해 좀 남겨보자.

아래와 다음과 같은 5가지 구성요소로 이루어져 있다.
Applications, Envrionments, Services, Jobs, Pipelines
