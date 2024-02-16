---
layout: wiki
title:
summary:
date: 2022-11-15 22:22:34 +0900
updated: 2024-02-16 14:13:36 +0900
tag:
toc: true
public: true
parent:
latex: false
---

- TOC
  {:toc}

# vim 사용

```vim
:messages # 메세지 확인
:history # 내 커멘드 확인
:xmark # 현재 편집중인 md 파일를 브라우저에서 열기
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
