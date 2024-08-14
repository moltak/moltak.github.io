bundle update && bundle install
# ./generateData.js

if [[ $1 = "docker" ]]; then
    docker-compose up
elif [[ $1 = "watch" ]]; then
    jekyll serve --livereload -o
elif [[ $1 = "inc" ]]; then
    jekyll serve --incremental --trace
fi
