default:
    @just --list

dev:
    npx astro dev

build:
    npx astro build

deploy:
    pnpm run deploy
