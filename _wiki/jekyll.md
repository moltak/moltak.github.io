---
layout  : post
title   : 지킬 학습
summary : 기계인간님의 테마 변경 시도
date    : 2024-02-18 17:07:51 +0900
updated : 2024-02-23 12:58:42 +0900
tag     : 
toc     : true
public  : true
parent  : 
latex   : false
resource: 4886C368-6CB9-47E2-AC11-ABB7DF2A1B49
---

* TOC
{:toc}

지킬 테마를 변경하고 싶어서 학습하는 지킬
[링크를 학습중](https://jekyllrb.com/docs/step-by-step/01-setup/)
 
## raw tag 를 사용하자
이 문서를 작성하며 liquid 문법을 사용하면서 문제가 발생했다. 예제 코드를 작성하면서 liquid tag를 써야했는데, 그런 경우 liquid compiler가 에러를 반환한다. 내 예제 코드에 정의되지 않은 변수가 추가된건데. 그걸 해결하기 위해 아래처럼 raw tag를 이용한다.

<img width="144" alt="image" src="https://github.com/moltak/moltak.github.io/assets/1638639/9f162986-fb14-4df8-9178-4f64ffa06db2">



## 2. Liquid
https://jekyllrb.com/docs/step-by-step/02-liquid/

### 2.1 Objects
{% raw %}
```
Objects tell Liquid to output predefined variables as content on a page. Use double curly braces for objects: {{ and }}.

For example, {{ page.title }} displays the page.title variable.
```
{% endraw %}

{% raw %}
변수를 출력하게 해주는 객체. duble culry braces `{{}}` 사용
{% endraw %}


### 2.2 Tags
{% raw %}
```
Tags define the logic and control flow for templates. Use curly braces and percent signs for tags: {% and %}.

For example:

{% if page.show_sidebar %}
  <div class="sidebar">
    sidebar content
  </div>
{% endif %}
```
{% endraw %}

{% raw %}
로직과 컨트를 제어하는 태그. `{%`와 `%}`로 감싸진다.
{% endraw %}

### Filters
{% raw %}
```
Filters change the output of a Liquid object. They are used within an output and are separated by a |.

For example:

{{ "hi" | capitalize }}
```
{% endraw %}
filter는 liquid object output을 변경한다. `|`로 구분된다.

### 2.3 Front Matter
Jekyll이 Liquid를 처리하게 하려면 `front matter`를 추가한다.

html 앞부분에 `---`로 시작하는 아래 내용을 추가한다.

```html
---
# front matter tells Jekyll to process Liquid
---
```

실제론 이렇게 보인다.

{% raw %}
```html
---
---
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Home</title>
  </head>
  <body>
    <h1>{{ "Hello World!" | downcase }}</h1>
  </body>
</html>
```
{% endraw %}

## 4. Layouts
```
Layouts are templates that can be used by any page in your site and wrap around page content. They are stored in a directory called _layouts.
```
Layouts은 사이트의 모든 페이지에서 사용될 수 있는 템플릿이다. 페이지 컨텐츠를 감싸고 있다. `_layouts` 디렉토리에 저장된다.

{% raw %}
```html
<!-- _layouts/default.html -->
<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <title>{{ page.title }}</title>
  </head>
  <body>
    {{ content }}
  </body>
</html>
```
{% endraw %}
위 코드를 보면 `content`라는 변수가 있고 이를 html이 감싸고 있다. `content`는 speical 변수이며 페이지의 내용이 들어간다.

layout을 사용하기 위해서 아래처럼 `front matter`에 `layout`을 추가한다.

{% raw %}
```html
---
layout: default
title: Home
---
<h1>{{ "Hello World!" | downcase }}</h1>
```
{% endraw %}
위처럼 `front matter`를 추가 후 내용을 추가하면 `content`에 hello world 가 들어간다.

## 5. Includes
include 추가하기
https://jekyllrb.com/docs/step-by-step/05-includes/
