# Notion 문서 읽기 & 이미지 다운로드

## 개요
Notion 데이터베이스에서 블로그 포스트를 읽어오고, 포스트에 포함된 이미지를 로컬로 다운로드하는 워크플로우.

## Notion 데이터베이스 정보
- **Database page**: `a4f81063c4344aaea7cab2cbebe08f4a`
- **Data source (collection)**: `collection://78df2a3d-8461-4bfe-86be-0d20b92da540`
- **Public 포스트만 가져올 것**: `Public: __YES__` 필터 사용

## 워크플로우

### 1단계: Notion에서 포스트 목록 조회
```
mcp_fnf-notion_notion-query-data-sources로 Public == __YES__ 인 포스트 조회
```

### 2단계: 개별 포스트 내용 가져오기
```
mcp_fnf-notion_notion-fetch(id="{page_id}") 로 각 포스트의 마크다운 콘텐츠 가져오기
```

### 3단계: 마크다운 변환
Notion 마크다운 → 블로그용 `.mdx` 변환 시 제거/변환할 것:
- `<image>` 태그 → `![alt](./local-image.png)` 형식으로 변환
- `<table_of_contents>` 제거
- `{color="..."}` 제거
- `<empty-block/>` 제거
- `<synced_block>` 제거
- `<span>` 제거
- `{{url}}` 래퍼 제거
- 저자의 캐주얼한 한국어 톤 유지

### 4단계: 이미지 다운로드

Notion 이미지는 AWS S3 signed URL로 제공된다. Notion fetch 결과에서 이미지 URL을 추출하면 다음과 같은 형태:

```
https://prod-files-secure.s3.us-west-2.amazonaws.com/{workspace_id}/{image_uuid}/{filename}?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential={credential}%2F{date_short}%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date={date_long}&X-Amz-Expires=3600&X-Amz-Security-Token={token}&X-Amz-Signature={signature}&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject
```

**중요**: S3 signed URL은 1시간 후 만료됨. 만료 시 Notion 페이지를 다시 fetch해서 새 URL 획득 필요.

#### Python 다운로드 스크립트 템플릿

```python
#!/usr/bin/env python3
"""Download Notion images for blog posts using S3 signed URLs."""

import urllib.request
import os
import ssl

# Disable SSL verification for S3 signed URLs
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

BASE = "https://prod-files-secure.s3.us-west-2.amazonaws.com/{workspace_id}"
BLOG = "/home/khhh/fun/blog/src/content/blog"
COMMON_PARAMS = "X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"


def build_url(uuid, filename, sig, cred, date, token):
    """S3 signed URL 조립.
    
    Args:
        uuid: 이미지 UUID (Notion 내부 ID)
        filename: 원본 파일명 (e.g. "image.png", "Untitled.png")
        sig: X-Amz-Signature 값
        cred: X-Amz-Credential 키 (e.g. "ASIAZI2LB466...")
        date: X-Amz-Date 값 (e.g. "20260129T122817Z")
        token: X-Amz-Security-Token 값 (URL-encoded)
    """
    date_short = date[:8]  # "20260129"
    return (
        f"{BASE}/{uuid}/{filename}?{COMMON_PARAMS}"
        f"&X-Amz-Credential={cred}%2F{date_short}%2Fus-west-2%2Fs3%2Faws4_request"
        f"&X-Amz-Date={date}"
        f"&X-Amz-Expires=3600"
        f"&X-Amz-Security-Token={token}"
        f"&X-Amz-Signature={sig}"
    )


# 포스트별 인증 정보와 이미지 목록
# auth: (credential, date, token) — Notion fetch 결과의 이미지 URL에서 추출
# images: [(uuid, orig_filename, signature, local_name), ...]
IMAGES = {
    "post-directory-name": {
        "auth": ("CREDENTIAL", "DATE", "TOKEN"),
        "images": [
            ("image-uuid", "image.png", "signature-hex", "descriptive-local-name.png"),
        ],
    },
}


def download():
    total = sum(len(v["images"]) for v in IMAGES.values())
    done = 0
    failed = 0
    for post_dir, config in IMAGES.items():
        cred, date, token = config["auth"]
        out_dir = os.path.join(BLOG, post_dir)
        os.makedirs(out_dir, exist_ok=True)
        for uuid, filename, sig, local_name in config["images"]:
            url = build_url(uuid, filename, sig, cred, date, token)
            out_path = os.path.join(out_dir, local_name)
            try:
                req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
                with urllib.request.urlopen(req, context=ctx) as resp:
                    data = resp.read()
                    with open(out_path, "wb") as f:
                        f.write(data)
                done += 1
                size_kb = len(data) / 1024
                print(f"  [{done}/{total}] OK {post_dir}/{local_name} ({size_kb:.0f}KB)")
            except Exception as e:
                failed += 1
                print(f"  [{done + failed}/{total}] FAIL {post_dir}/{local_name}: {e}")
    print(f"\nDone: {done} downloaded, {failed} failed out of {total}")


if __name__ == "__main__":
    download()
```

### 5단계: MDX에서 이미지 참조 업데이트

다운로드한 이미지는 포스트 디렉토리에 저장하고, MDX에서 상대 경로로 참조:

```markdown
![설명](./descriptive-local-name.png)
```

## 블로그 포스트 frontmatter 형식

```yaml
---
title: "포스트 제목"
description: "간단한 설명"
date: "Jan 07 2026"
draft: false
---
```

## 파일 구조

```
src/content/blog/
└── {번호}-{slug}/
    ├── index.mdx
    ├── image1.png
    ├── image2.png
    └── ...
```

## 이미지 URL 추출 방법

Notion fetch 결과에서 이미지는 다음 형태로 나타남:
```markdown
<image>
![alt text](https://prod-files-secure.s3.us-west-2.amazonaws.com/...)
</image>
```

이 URL에서 다음 파라미터를 추출:
- **uuid**: URL path의 두 번째 세그먼트
- **filename**: URL path의 세 번째 세그먼트  
- **X-Amz-Credential**: credential 키
- **X-Amz-Date**: 타임스탬프
- **X-Amz-Security-Token**: 보안 토큰
- **X-Amz-Signature**: 서명

같은 포스트의 이미지는 동일한 credential/date/token을 공유하므로 포스트 단위로 auth를 묶어서 관리.
