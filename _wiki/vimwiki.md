---
layout  : post
title   : vimwiki
summary : 
date    : 2024-08-10 17:36:34 +0900
updated : 2024-08-23 15:14:06 +0900
tag     : vim
toc     : true
public  : true
parent  : 
latex   : false
resource: 96F2F82F-CC8B-4FD3-B02E-01EBFB9B09E8
---
* TOC
{:toc}

# 빔위키 써보자

기계인간님의 빔위키를 보며 나도 써보자고 마음먹은지 어언.... 2년
세팅은 이미 좀 했지만 잘 안쓰다가 시간이 남아 해보기로했다.

내 vim 세팅들과 wiki 세팅이 혼재되어 있었고 기계인간님의 세팅을 그대로 가져다 쓰다보니 너무 많은 기능이 있어서 사용이 어려웠다. 

vimwiki에만 집중하도록 설정을 많이 삭제했고 시간을 내서 많이 수정했다. 지금은 이렇게 쓴다. (계속 업데이트 중)

#### 1. 기본 빔위키 세팅
  - 사실 기본 빔 위키 세팅이랄게 없다. 내 wiki 디렉토리에 _wiki를 디렉토리를 만들고 vimwiki 설정해둔게 끝

#### 2. 지킬 설정 
  - 이게 제일 어려웠다.
  - 지킬을 잘 모르는데 기계인간님의 코드가 너무 많아서 설정하는데 애먹었음.
  - 지금 세팅은 지킬 기본으로 원복시키고 조금씩 나에게 맞춰서 수정하는 중이다.
  - 지금 사용하는 테마는 지킬의 기본 테마인 minima를 사용하고 있다. (잘 작동한다.)
  - 이제 다른 테마도 적용할 수 있겠지.. 커스텀도 가능할테고

#### 3. 가장 좋은 점
  - 이제 글을 빠르게 쓸 수 있다는 것
  - vim을 켜고 `\ww` 를 눌러 wiki index 로 이동 (startify도 물론 쓰고 있음)
  - vim 설정을 거의 껐고 markdown, wiki 설정만 남겨둠. 어차피 다른거 잘 안하더라..
  - 하지만 ultisnips와 copilot은 못 빼지

#### 4. 파일 다운로드
지금은 raycast의 extension을 이용해서 이미지를 업로드하고 링크를 가져오고 있다. 그런데 무료로 사용하기엔 용량 제한도 있어서 계속 사용하기엔 좀 찝찝하다. 
기계인간님의 코드를 따라해서 나도 [image download]({{ site.github }}/blob/master/tool/save-images.sh)를 만들었다. 
이제 이미지를 다운로드 받고 저장하므로 이미지 파일을 잃어버리지 않게 되었다.
 
> [[포스팅할 때 쉽게 이미지 업로드하기]]에서 캠쳐 후 매우 쉽게 이미지를 업로드하는 방법을 소개하고 있다.


#### 5. 내부 문서 링크
vimwiki에서는 내부 문서를 링크할 때 `[[[[파일명]]]]`으로 링크를 걸 수 있다. 이게 너무 편하다. 하지만 지킬에서는 이렇게해서는 링크가 연결되지 않는다. 이걸 도와줄 스크립트를 간단히 작성해봤다. 아래와 같이 [[]] 일때 a 태그로 감싸주는 스크립트를 만들어보자. (gpt 한테 부탁했고 5분도 안걸려서 내 블로그에 적용했다.)
```javascript
<script type="text/javascript">
  document.addEventListener("DOMContentLoaded", function() {
    // 전체 페이지의 텍스트 노드를 탐색하여 [[content]] 패턴을 찾기 위한 함수
    function replaceContentWithLink(node) {
      // 텍스트 노드인지 확인
      if (node.nodeType === Node.TEXT_NODE) {
        // 정규식을 사용하여 [[content]] 패턴을 검색
        const regex = /\[\[([^\]]+)\]\]/g;
        let match;
        let lastIndex = 0;
        const fragments = [];

        // 패턴이 여러 번 나타날 수 있으므로 while 루프를 사용
        while ((match = regex.exec(node.textContent)) !== null) {
          // 매치 이전의 텍스트와 매치된 부분을 추가
          fragments.push(document.createTextNode(node.textContent.slice(lastIndex, match.index)));
          lastIndex = regex.lastIndex;

          // a 태그를 생성하여 링크로 변환
          const anchor = document.createElement("a");
          anchor.href = `/wiki/${match[1]}`; // 여기서 [[content]]의 내용을 href로 사용
          anchor.textContent = match[1]; // 링크의 텍스트도 동일하게 설정

          fragments.push(anchor);
        }

        // 마지막 매치 이후의 텍스트를 추가
        fragments.push(document.createTextNode(node.textContent.slice(lastIndex)));

        // 현재 텍스트 노드를 부모에서 제거하고, 변환된 노드를 삽입
        const parent = node.parentNode;
        fragments.forEach(fragment => {
          parent.insertBefore(fragment, node);
        });
        parent.removeChild(node);
      }
      // 텍스트 노드가 아닌 경우, 자식 노드에 대해 재귀적으로 탐색
      else {
        node.childNodes.forEach(replaceContentWithLink);
      }
    }

    // body 내부의 모든 텍스트 노드에 대해 작업을 수행
    replaceContentWithLink(document.body);
  });
</script>
```

위 코드를 post.html에 추가하고 (난 include 구문을 이용했음) 이제 내부 문서를 링크할 때 [[]]로 감싸주면 자동으로 링크가 걸린다. 너무 편하다.

#### 5. 랜덤으로 포스트 열기
기계인간님의 위키 기능 중 작성된 포스트를 랜덤으로 여는 기능이 가장 좋아보였다. 수백개의 글을 갖고 있으며 그걸 자주 읽는다는 기계인간님의 습관이 너무 부러웠고 나도 그렇게 해보고 싶었다. (아직은 글이 없으므로 별로 필요없지만...?) 나도 그 기능을 꼭 적용해보고 싶었다. 

jekyll은 plugin을 통해 자동으로 sitemap.xml 을 생성할 수 있는데 이걸 이용하면 쉽게 구현할 수 있을 것 같다.
sitemap.xml을 읽고 random 함수를 통해 랜덤으로 포스트를 열어주는 스크립트를 작성해서 random.html 에 추가해봤다.

```js
<script type="text/javascript">
  document.addEventListener("DOMContentLoaded", function() {
    fetch('/sitemap.xml')
      .then(response => response.text())
      .then(data => {
        const parser = new DOMParser();
        const xmlDoc = parser.parseFromString(data, "application/xml");

        const urls = Array.from(xmlDoc.getElementsByTagName("loc")).map(loc => loc.textContent);

        const randomUrl = urls[Math.floor(Math.random() * urls.length)];

        window.location.href = randomUrl;
      })
      .catch(error => {
        console.error('Error fetching sitemap:', error);
      });
  });
</script>
```
잘 작동한다!
<br/>

<div style="text-align: center;">
  <video style='border: 1px solid #000;' src="/assets/images/wiki_intro.mp4" width="400" controls></video>
</div>

