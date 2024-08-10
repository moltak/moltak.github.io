---
layout  : post
title   : clojure web server
summary : clojure에서 서버 구축하기
date    : 2022-11-15 21:59:24 +0900
updated : 2022-11-15 22:02:54 +0900
tag     : clojure lacinia ring reitit integrat
toc     : true
public  : true
parent  : [[Clojure]]
latex   : false
---
* TOC
{:toc}

# lacinia(graphql implementation)
lacinia graphql query -> http serving 하려면 -> pedestal 사용

## lacinia-pedestal
Working from the REPL is important, but ultimately GraphQL exists to provide a web-based API. Fortunately, it is very easy to get your Lacinia application up on the web, on top of the [Pedestal](http://pedestal.io/) web tier, using [Lacinia-Pedestal](https://github.com/walmartlabs/lacinia-pedestal).

## Pedestal
Pedestal is a set of libraries that we use to build services and applications. It runs in the back end and can serve up whole HTML pages or handle API requests.

# ring (python WSGI)
WSGI는 웹 서버와 파이썬 앱 사이의 표준 인터페이스. 
클로저에선 Ring이 담당함. 저수준 인터페이스 (handler, middleware, request, response)를 제공
nodejs의 http 같은거

# reitit (data-driven router)
A fast data-driven router for Clojure(Script).
request, response 간의 타이핑 제공. 라우터를 더 쉽게 작성할 수 있게 해줌.
nodejs express 비슷하려나?

# integrant (Component alternative)
`Component` is a tiny Clojure framework for managing the lifecycle and dependencies of software components which have runtime state.
integrant는 component의 부족한 점을 개선

# 참고문서
[lacinia](https://github.com/walmartlabs/lacinia) \
[lacinia-pedestal](https://lacinia.readthedocs.io/en/latest/tutorial/pedestal.html) \
[Pedestal](http://pedestal.io/) \
[ring](https://github.com/ring-clojure/ring/wiki) \
[reitit](https://github.com/metosin/reitit) \
[integrant](https://github.com/weavejester/integrant) \
[클로저로 웹 서버 애플리케이션 개발을 시작하는 사람들을 위한 Ring 소개서](https://green-labs.github.io/introduce-a-ring) \
[클로저 기술스택 따라잡기 ](https://www.notion.so/greenlabs/00f00e0b4e734f5a926e225886357c17)
