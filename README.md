# 블로그

[Astro Nano](https://github.com/markhorn-dev/astro-nano)를 기반으로 만든 정적 블로그입니다. Astro 5, TypeScript, Tailwind CSS와 MDX를 사용하며, Sveltia CMS에서 GitHub 저장소의 글을 관리합니다.

## 시작하기

```sh
npm install
npm run dev
```

로컬 사이트는 기본적으로 <http://localhost:4321>에서 열립니다.

| 명령 | 설명 |
| --- | --- |
| `npm run dev:network` | 로컬 네트워크에서 접근 가능한 개발 서버 실행 |
| `npm run build` | Astro 검사 후 `dist/`에 정적 사이트 빌드 |
| `npm run preview` | 빌드 결과 미리보기 |
| `npm run lint` | ESLint 검사 |
| `npm run astro check` | Astro 및 TypeScript 검사 |
| `just new-post <slug> "<title>"` | 번호가 붙은 새 임시 글 생성 |
| `npm run deploy` | 빌드 후 `gh-pages` 브랜치에 배포 |

## 글 관리

글은 `src/content/blog/<slug>/index.mdx`에 저장합니다. 필수 frontmatter는 `title`, `description`, `date`이며 `draft`, `featured`, `updated`는 선택 사항입니다. `draft: true`인 글은 블로그 페이지에서 제외됩니다. 이미지도 글 폴더에 함께 둘 수 있습니다.

### Sveltia CMS

배포 후 <https://blog.parsley-bay.com/admin/>에서 기존 글을 수정하거나 새 글을 추가할 수 있습니다. 로컬 개발 서버에서는 <http://localhost:4321/admin/>에서 같은 관리 화면을 열 수 있습니다. 두 경우 모두 설정된 GitHub 저장소에 연결하므로 저장하면 로컬 파일이 아닌 GitHub의 `main` 브랜치에 반영됩니다.

1. GitHub에서 `moltak/moltak.github.io` 저장소에 접근할 수 있는 개인 액세스 토큰을 만듭니다. 세분화된 토큰에는 해당 저장소의 **Contents: Read and write** 권한이 필요합니다.
2. 관리 화면에서 토큰으로 로그인합니다. 토큰은 브라우저의 로컬 저장소에 보관되므로 공유 기기에서는 주의하고, 토큰을 저장소에 커밋하지 마세요.
3. **블로그**에서 기존 글을 선택하거나 새 글을 작성합니다. 저장하면 GitHub에 커밋됩니다. 사이트 반영은 별도의 배포 과정에 달려 있습니다.

CMS는 `public/admin/index.html`에서 CDN으로 불러오며, 저장소·브랜치·필드 설정은 `public/admin/config.yml`에 있습니다. 새 글은 `<slug>/index.mdx`로 저장되고 이미지 경로는 글 폴더 기준으로 설정되어 있습니다. CMS에서 생성하는 슬러그에는 `just new-post`와 달리 번호가 자동으로 붙지 않습니다.

글 목록에는 `table_columns`로 제목·설명·본문·추천 글·작성일·수정일 여섯 열을 표시합니다. 설명과 본문은 열 템플릿(`truncate(20, '...')`)으로 약 20자로 잘라 보여주며, 본문의 열은 `plainify`로 서식 기호를 먼저 제거한 뒤 잘라냅니다. 추천 글 여부와 수정일은 선택 필드이므로 값이 없는 글에서는 해당 열이 비어 표시됩니다.

본문 필드는 Markdown 에디터(`markdown` 위젯)를 씁니다. 편집 모드는 `modes: [raw, rich_text]`로 두 가지를 모두 허용하되, 목록의 첫 항목인 원문(`raw`) 모드가 기본값입니다. 원문 모드에서는 구문 강조와 도구모음(단락·링크·이미지 삽입 등)을 쓸 수 있고 내용은 항상 Markdown/MDX 원문 그대로 저장됩니다.

시각 편집(`rich_text`) 모드는 선택적으로(opt-in) 켜는 기능입니다. 편집 화면 상단의 모드 전환 버튼으로 전환할 수 있으며, 렌더링된 결과를 보며 쓸 수 있어 일반 Markdown 글에는 편리합니다. 특히 클립보드 붙여넣기가 지원되어, 외부에서 복사한 텍스트나 이미지를 에디터에 바로 붙여넣으면 이미지가 글 폴더(미디어 폴더)에 저장되고 본문에 삽입됩니다.

다만 시각 편집 모드는 기존 내용을 에디터를 거쳐 다시 파싱·직렬화하므로, MDX 컴포넌트나 `{표현식}`이 손상될 수 있습니다. 그래서 기본은 원문 모드로 두고, MDX를 쓰는 글에서는 함부로 시각 편집으로 전환하지 마세요. 시각 편집을 쓰려는 글이 일반 Markdown으로만 되어 있는지 확인한 뒤 전환하고, 저장 후 빌드·배포 결과로 내용이 온전한지 점검하는 것이 안전합니다.

CMS 미리보기는 일반 Markdown만 HTML로 렌더링하며 MDX 컴포넌트나 `{표현식}`은 렌더링하지 않습니다. MDX를 쓰는 글의 실제 출력은 CMS 미리보기가 아니라 사이트 빌드(`npm run build` / `npm run preview`)나 배포된 사이트로 확인하세요.

## 구성 및 배포

- 사이트 정보: `src/consts.ts`
- Astro 및 사이트 URL: `astro.config.mjs`
- 콘텐츠 스키마: `src/content/config.ts`
- CMS 설정: `public/admin/config.yml`

`npm run build` 결과는 `dist/`에 생성됩니다. `npm run deploy`는 이 결과를 GitHub 저장소의 `gh-pages` 브랜치로 배포합니다. CMS에서 `main`에 저장한 변경이 사이트에 표시되려면 해당 변경을 포함하는 빌드와 배포가 필요합니다.

## 라이선스

MIT
