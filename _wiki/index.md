---
layout: wikiindex
title: wiki
toc: true
public: true
comment: false
regenerate: true
---

## wiki items

- [[vim]]
  - [[vimwiki_usage]]
  - [[viminit]]
- [[언어]]
  - [[Clojure]]
- [[독서]]
  - [[역행자]]
- [[인프라]]
  - [[AWS Copilot]]
- [[/code]]
  - [[/code/graphql]]
  - [[/code/tmux]]
  - [[/code/clojure]]
    - [[/code/clojure/http]]
    - [[/code/clojure/기본문법]]
- [[/work]]
  - [[/work/2022]]
- [[arc-browser]]
- [[jekyll]]
- [[raycast_image]]

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
