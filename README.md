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

본문은 기존 MDX 구문을 보호하기 위해 시각 편집기가 아닌 Markdown/MDX 원문으로 편집합니다. Sveltia CMS는 MDX 컴포넌트의 시각 편집을 완전히 지원하지 않으므로 관련 설정을 변경할 때 기존 글이 손상되지 않는지 확인하세요.

## 구성 및 배포

- 사이트 정보: `src/consts.ts`
- Astro 및 사이트 URL: `astro.config.mjs`
- 콘텐츠 스키마: `src/content/config.ts`
- CMS 설정: `public/admin/config.yml`

`npm run build` 결과는 `dist/`에 생성됩니다. `npm run deploy`는 이 결과를 GitHub 저장소의 `gh-pages` 브랜치로 배포합니다. CMS에서 `main`에 저장한 변경이 사이트에 표시되려면 해당 변경을 포함하는 빌드와 배포가 필요합니다.

## 라이선스

MIT
