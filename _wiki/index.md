---
layout: postindex
title: wiki
toc: true
public: false
comment: false
regenerate: true
---

## wiki items

- [[vim 알게된거 추가하기]]
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
- [[arc-browser]]
- [[jekyll]]
- [[raycast_image]]
- [[음악]]
  - [[classic]]

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
