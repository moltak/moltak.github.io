---
layout:  post
title:   vim 알게된거 추가하기
summary:
date:    2022-11-15 22:22:34 +0900
updated: 2024-08-13 20:38:33 +0900
tag:     vim
toc:     true
public:  true
parent:
latex:   false
---

* TOC
{:toc}

# vim 사용

```vim
:messages # 메세지 확인
:history # 내 커멘드 확인
:xmark # 현재 편집중인 md 파일를 브라우저에서 열기
\ww # vimwiki index로 이동
```

# CMD+S를 사용하고 싶다

[이 문서에선](https://stackoverflow.com/questions/40990454/how-to-map-mac-command-key-in-vim) vim+terminal에선 사용이 안된다고 하고 있다. 나는 vimr을 통해 vim을 사용하므로 해당 키를 쓸 수 있음.

아래와 같이 vimrc에 추가한다.

```vim
nnoremap <D-s> :w<CR>
```

# xmark가 vimr에서 작동되지 않는다.

```vim
119:127: execution error: System Events에 오류 발생: osascript에 보조 접근이 허용되지 않습니다. (-1719)
```

이런 메세지가 발생. vimr의 보안 설정을 바꿔주면 된다.
환경설정 -> 개인정보보 보안 -> 손쉬운 사용 -> vimr 을 켜주자

# CMD+/를 사용해서 주석처리 하고 싶다

[commentery/vim](https://github.com/tpope/vim-commentary)을 사용하자. 아래 명령어를 사용할 수 있다.

```vim
gcc
gc
gcap
```

# keybinding 확인하기
vimwiki, coc, ultisnips를 세팅하고 보니 markdown에서 tab이 원하는대로 작동하지 않는 문제를 발견

coc의 키 binding에 보면 아래와 같이 해결하는 방법이 가이드되어있다.

```
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
```
위 커맨드를 입력해보면 아래 이미지와 같이 겹치는 키가 보인다.
<img width="697" alt="image" src="https://github.com/moltak/moltak.github.io/assets/1638639/ecae46f5-0f9f-446e-a43e-b388f3ad55df">

이를 해결하기 위해 위에 적힌 것 처럼, ultisnips, vimwiki의 키 바인딩을 확인하고, 겹치는 것을 없애주면 된다.

[ultisnips](https://github.com/moltak/dotfiles/blob/b1bec91b4296622b03f2d4ba2e0aedbbdfed9427/nvim/vim-include/set-ultisnips.vim#L6)
[vimwiki](https://github.com/moltak/dotfiles/blob/b1bec91b4296622b03f2d4ba2e0aedbbdfed9427/nvim/vim-include/set-vimwiki.vim#L22)

# method 문서 열기
K 로 문서를 열 수 있다
![](./assets/images/vgbssadZuQ7xEkaa1YfK-vBLcrklsqHXwgn8WduATGE.png)
