# GitHub Pages 배포 가이드

이 프로젝트는 GitHub Actions를 통해 자동으로 GitHub Pages에 배포됩니다.

## 초기 설정

### 1. GitHub Repository 생성 및 코드 푸시

```bash
# GitHub에서 새 저장소 생성 후
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
git branch -M main
git add .
git commit -m "Initial commit"
git push -u origin main
```

### 2. astro.config.mjs 수정

`astro.config.mjs` 파일을 열고 다음을 수정하세요:

```javascript
export default defineConfig({
  site: "https://YOUR_USERNAME.github.io",
  base: "/YOUR_REPO_NAME",  // 저장소 이름이 YOUR_USERNAME.github.io가 아닌 경우
  integrations: [mdx(), sitemap(), tailwind()],
});
```

**주의사항:**
- `YOUR_USERNAME`을 GitHub 사용자명으로 변경
- `YOUR_REPO_NAME`을 저장소 이름으로 변경
- 저장소 이름이 `YOUR_USERNAME.github.io` 형식이면 `base` 속성은 불필요합니다

### 3. GitHub Pages 설정

1. GitHub 저장소로 이동
2. **Settings** > **Pages** 클릭
3. **Source** 섹션에서:
   - "GitHub Actions"를 선택

### 4. 배포

설정이 완료되면 `main` 브랜치에 푸시할 때마다 자동으로 배포됩니다:

```bash
git add .
git commit -m "Update content"
git push
```

## 배포 확인

- **Actions 탭**에서 배포 진행 상황 확인
- 배포 완료 후 `https://YOUR_USERNAME.github.io/YOUR_REPO_NAME`에서 사이트 확인
- 일반적으로 2-3분 소요

## 수동 배포

Actions 탭에서 "Deploy to GitHub Pages" 워크플로우를 선택하고 "Run workflow"를 클릭하여 수동으로 배포할 수 있습니다.

## 트러블슈팅

### 404 오류
- `astro.config.mjs`의 `base` 경로가 저장소 이름과 일치하는지 확인
- GitHub Pages 설정이 "GitHub Actions"로 되어 있는지 확인

### 빌드 실패
- Actions 탭에서 에러 로그 확인
- 로컬에서 `npm run build`가 성공하는지 확인

### CSS/이미지 로딩 안 됨
- `base` 경로 설정을 확인하세요
- 상대 경로를 사용하고 있는지 확인하세요
