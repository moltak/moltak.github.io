---
layout  : wiki
title   : 지킬 학습
summary : 기계인간님의 테마를 변경하자!
date    : 2024-02-18 17:07:51 +0900
updated : 2024-02-18 17:42:59 +0900
tag     : 
toc     : true
public  : true
parent  : 
latex   : false
resource: 4886C368-6CB9-47E2-AC11-ABB7DF2A1B49
---
* TOC
{:toc}

# 지킬 테마를 변경하고 싶어서 학습하는 지킬
johngrib.github.io/

## Liquid
https://jekyllrb.com/docs/step-by-step/02-liquid/

### Objects
```
Objects tell Liquid to output predefined variables as content on a page. Use double curly braces for objects: {{ and }}.

For example, {{ page.title }} displays the page.title variable.
```
변수를 출력하게 해주는 객체. duble culry braces `{{}}` 사용

### Tags
```
Tags define the logic and control flow for templates. Use curly braces and percent signs for tags: {% and %}.

For example:

{% if page.show_sidebar %}
  <div class="sidebar">
    sidebar content
  </div>
{% endif %}
```
로직과 컨트를 제어하는 태그. `{%`와 `%}`로 감싸진다.

### Filters
```
Filters change the output of a Liquid object. They are used within an output and are separated by a |.

For example:

{{ "hi" | capitalize }}
```
filter는 liquid object output을 변경한다. `|`로 구분된다.

### Front Matter
Jekyll이 Liquid를 처리하게 하려면 `front matter`를 추가한다.

html 앞부분에 `---`로 시작하는 아래 내용을 추가한다.

```html
---
# front matter tells Jekyll to process Liquid
---
```

실제론 이렇게 보인다.

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


