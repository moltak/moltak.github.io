# Astro Nano and Sveltia CMS - Agent Guidelines

This document provides essential information for AI coding agents working in this repository.

## Project Overview

**Astro Nano** is a minimal, lightweight static blog and portfolio theme built with:
- **Astro** (v5) - Static site generator
- **TypeScript** (strict mode) - Type safety
- **Tailwind CSS** - Utility-first styling
- **MDX** - Markdown with components
- **Sveltia CMS** - Browser-based GitHub content management

**Project Structure:**
```
src/
├── components/     # Astro components (.astro files)
├── content/        # Content collections (blog, work, projects)
│   ├── blog/       # Blog posts (MDX)
│   ├── work/       # Work collection, if present
│   └── projects/   # Projects collection, if present
├── layouts/        # Page layouts
├── lib/           # Utility functions
├── pages/         # Routes (file-based routing)
├── consts.ts      # Site configuration constants
├── types.ts       # TypeScript type definitions
└── env.d.ts       # Environment type declarations
public/admin/
├── index.html     # Loads Sveltia CMS from CDN
└── config.yml     # GitHub backend and blog collection
```

## Build & Development Commands

All commands run from project root:

| Command | Action |
|---------|--------|
| `npm install` | Install dependencies |
| `npm run dev` | Start dev server at localhost:4321 |
| `npm run dev:network` | Dev server accessible on local network |
| `npm run build` | Type-check + build to `./dist/` |
| `npm run preview` | Preview production build locally |
| `npm run lint` | Run ESLint |
| `npm run lint:fix` | Auto-fix ESLint issues |
| `npm run astro check` | TypeScript type checking |

**Build Output:** `./dist/` directory (gitignored)

## Code Style & Conventions

### TypeScript

- **Strict mode enabled** (`strictNullChecks: true`)
- **Never suppress type errors** with `as any`, `@ts-ignore`, `@ts-expect-error`
- **Path aliases:** Use `@*` to reference `./src/*`
  ```typescript
  import { SITE } from "@consts";
  import Container from "@components/Container.astro";
  import type { Site } from "@types";
  ```
- **Type definitions:** Define types in `src/types.ts` or colocate with usage
- **Explicit return types** preferred for exported functions

### ESLint Rules (Enforced)

```javascript
// .eslintrc.cjs
- Semicolons: REQUIRED
- Quotes: DOUBLE quotes (template literals allowed)
- No triple-slash references allowed
```

**Examples:**
```typescript
// ✅ Correct
import { cn } from "@lib/utils";
const name = "Astro Nano";

// ❌ Wrong
import { cn } from "@lib/utils"  // Missing semicolon
const name = 'Astro Nano';       // Single quotes
```

### Astro Components

- **Frontmatter:** Component logic in `---` fences at top
- **Props typing:** Use TypeScript interface
- **Component names:** PascalCase for files and usage
- **No frameworks:** Pure Astro + Tailwind (no React/Vue/Svelte)

**Example:**
```astro
---
import Container from "@components/Container.astro";
import Link from "@components/Link.astro";
import { SITE } from "@consts";

interface Props {
  title: string;
  description?: string;
}

const { title, description } = Astro.props;
---

<Container>
  <h1>{title}</h1>
  {description && <p>{description}</p>}
</Container>
```

### Styling

- **Tailwind CSS only** - No custom CSS files
- **Class utility:** Use `cn()` from `@lib/utils` for conditional classes
  ```typescript
  import { cn } from "@lib/utils";
  
  const classes = cn(
    "base-class",
    isActive && "active-class",
    className // Optional prop
  );
  ```
- **Typography:** `@tailwindcss/typography` for prose content
- **Responsive:** Mobile-first approach with Tailwind breakpoints

### Content Collections

- **Schema:** Defined in `src/content/config.ts` using Zod
- **Types:** Auto-generated, import from `astro:content`
- **Collections:** `blog`, `work`, `projects`
- **Draft posts:** Set `draft: true` in frontmatter to exclude from production

**Example blog post:**
```markdown
---
title: "My Post Title"
description: "Post description"
date: 2024-01-15
draft: false
---

Content here...
```

### Imports & Organization

**Import order (recommended):**
1. Astro built-ins (`astro:content`, `astro:*`)
2. External packages
3. Components (`@components/*`)
4. Utilities (`@lib/*`)
5. Types (`@types`)
6. Constants (`@consts`)

**Example:**
```typescript
import { getCollection } from "astro:content";
import { clsx } from "clsx";
import Container from "@components/Container.astro";
import { formatDate } from "@lib/utils";
import type { Site } from "@types";
import { SITE } from "@consts";
```

### Error Handling

- **No empty catch blocks** - Always handle or log errors
- **Type guards** for runtime validation when needed
- **Optional chaining** for nullable values: `data?.property`
- **Nullish coalescing** for defaults: `value ?? defaultValue`

## Configuration

### Site Config

Edit `src/consts.ts` to customize:
- Site name, email, social links
- Number of posts/works/projects on homepage
- Page metadata (titles, descriptions)

### Astro Config

`astro.config.mjs`:
- `site`: Full URL for sitemap/RSS generation
- `integrations`: MDX, Sitemap, Tailwind
- Update `site` before deploying to production

## Content Management

### Adding Blog Posts

1. Create `src/content/blog/post-slug/index.mdx` with the required frontmatter, or use `just new-post <slug> "<title>"`.
2. Keep post images in the same folder when using relative image paths.
3. Alternatively, create or edit posts using the CMS at `/admin/`.

### Sveltia CMS

- `public/admin/index.html` loads the CMS from UNPKG; `public/admin/config.yml` defines its settings.
- The GitHub backend targets `moltak/moltak.github.io`, branch `main`, using token authentication. A fine-grained token needs repository Contents read/write permission. Never commit tokens or request them in chat.
- The CMS edits the `blog` collection only. It saves MDX posts at `src/content/blog/{{slug}}/index.mdx` and uses entry-relative media folders.
- The blog listing shows six `table_columns` in this order: `title`, object columns `{ field: "{{description | truncate(20, '...')}}", label: 설명 }` and `{ field: "{{body | plainify | truncate(20, '...')}}", label: 본문 }` (~20-char excerpts; `plainify` strips Markdown markup from the body excerpt), then `featured`, `date`, and `updated` referencing their actual widgets. `featured`/`updated` are optional, so posts without them show empty cells; keep column templates referencing only fields declared in the collection.
- The body uses the `markdown` widget with `modes: [raw, rich_text]`. Sveltia treats the first mode as the default, so entries open in the raw Markdown/MDX source editor (syntax highlighting and toolbar insert Markdown text). Visual editing (`rich_text`) is opt-in via the mode switch in the entry editor: it's convenient for plain-Markdown posts and supports clipboard paste (pasted text and images; pasted images are stored in the entry's media folder and inserted into the body). The `rich_text` mode re-parses and re-serializes content through its Lexical editor and can corrupt MDX components and JSX expressions, so keep `raw` first (never make `rich_text` the default), and warn users to switch to visual editing only for posts that contain plain Markdown, verifying saved output through `npm run build`/the deployed site.
- CMS preview (the read-only rendered view, and the entry preview toggle) renders Markdown as HTML but does not render MDX components or `{expressions}`. Treat CMS preview as indicative for plain Markdown only; verify MDX posts through `npm run build`/the deployed site.
- Keep CMS fields and optional-field handling aligned with the blog schema in `src/content/config.ts`. Preserve existing post paths, frontmatter and media references.
- CMS writes go to GitHub even when the admin page is opened locally. Saving a post does not itself guarantee deployment. CMS slugs are not automatically numbered like those from `just new-post`.

### Frontmatter Requirements

**Blog posts:**
- `title`: string (required)
- `description`: string (required)
- `date`: Date string (required)
- `draft`: boolean (optional, default false)
- `featured`: boolean (optional)
- `updated`: date (optional)

## Verification Checklist

Before marking work complete:

- [ ] **TypeScript:** Run `npm run astro check` - zero errors
- [ ] **Linting:** Run `npm run lint` - zero errors
- [ ] **Build:** Run `npm run build` - succeeds
- [ ] **Manual test:** Run `npm run dev` - verify changes work

## Common Patterns

### Date Formatting
```typescript
import { formatDate } from "@lib/utils";
const formatted = formatDate(new Date()); // "Jan 15, 2024"
```

### Reading Time
```typescript
import { readingTime } from "@lib/utils";
const time = readingTime(htmlContent); // "5 min read"
```

### Getting Posts
```typescript
import { getCollection } from "astro:content";
const posts = await getCollection("blog");
const published = posts.filter((post) => !post.data.draft);
```

## Deployment

Built site is static HTML/CSS/JS in `dist/`. `npm run deploy` builds and publishes it to the `gh-pages` branch. Changes saved by the CMS to `main` must be built and deployed before they appear on the site.

**Before deploy:**
1. Check `site` in `astro.config.mjs` matches the production URL
2. Run `npm run build` to verify
3. Deploy `dist/` folder

## Notes for Agents

- **No testing framework** - Manual verification required
- **Match existing patterns** - Consistency is critical in this small codebase
- **Minimal dependencies** - Avoid adding new packages without strong justification
- **Performance matters** - This theme prioritizes speed and simplicity
- **Read before edit** - Check existing components for established patterns
