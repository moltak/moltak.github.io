---
layout: postindex
title: wiki
toc: true
public: false
comment: false
regenerate: true
---

## wiki items

- [[learn_vim]]
  - [[viminit]]
  - [[vimwiki]]
- [[독서]]
  - [[역행자]]
- [[인프라]]
  - [[AWS Copilot]]
- [[code]]
    - [[clojure web server]]
    - [[clojure 기본문법]]
- [[work]]
  - [[work/2022]]
  - [[work/2024]]
- [[make_raycast_extension]]
- [[음악]]
  - [[classic]]
- 일기
  - [[2024]]
- learning
  - [[svelte]]
  - [[jekyll]]
- [[포스팅할 때 쉽게 이미지 업로드하기]]

---

## blog posts

<div>
    <ul>
{% for post in site.posts %}
    {% if post.public != false %}
        <li>
            <a class="post-link" href="{{ post.url | prepend: site.baseurl }}">
                {{ post.title }}
            </a>
        </li>
    {% endif %}
{% endfor %}
    </ul>
</div>
