---
layout  : wiki
title   : raycast extension 만들기
summary : wiki에 사용할 이미지 쉽게 업로드하기 
date    : 2024-02-19 13:20:58 +0900
updated : 2024-02-19 13:26:29 +0900
tag     : github,raycast
toc     : true
public  : true
parent  : 
latex   : false
resource: 38549EEE-942B-436C-912D-E8417922B3D5
---
* TOC
{:toc}

# blog에 이미지 올리기 쉽게하기 
현재는 블로그에 이미지를 올리기위해 종립님의 방법을 쓰고 있다. github issue에 이미지를 올리고 그 링크를 쓰는건데. 생각보다 좀 귀찮다.
요새 alfred 대신 raycast를 사용하는데 익스텐션 만들기가 쉽더라. 이걸 이용해서 해보면 좋을거 같다.

https://developers.raycast.com/

아래 plugin을 이용하면 클립보드의 image를 imagekit에 업로드해주고 링크를 반환해준다. 이걸로 시작해보면 좋을거 같다.
https://github.com/raycast/extensions/tree/acd1f0cbac7cb661dee4db0f2e802622e17b1c18/extensions/imagekit-uploader/src
![imagekit](https://ik.imagekit.io/djcholw5z/WQiVuNhahf4a1yG_IF3H7X3u6fJl5gWBt4GH1hTQIgU.png)

