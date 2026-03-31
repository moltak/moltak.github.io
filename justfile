default:
    @just --list

dev:
    npx astro dev

build:
    npx astro build

deploy:
    pnpm run deploy

# Create a new blog post: just new-post my-post-slug "Post Title"
new-post slug title:
    #!/usr/bin/env bash
    set -euo pipefail
    next=$(ls src/content/blog | sed 's/-.*//' | sort -n | tail -1 | awk '{print $1 + 1}')
    dir="src/content/blog/${next}-{{slug}}"
    mkdir -p "$dir"
    cat > "$dir/index.mdx" <<EOF
    ---
    title: "{{title}}"
    description: ""
    date: "$(date +'%b %d %Y')"
    draft: true
    ---
    EOF
    sed -i 's/^    //' "$dir/index.mdx"
    echo "Created: $dir/index.mdx"
