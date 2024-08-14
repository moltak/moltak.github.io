#!/bin/bash

# 1. blog 디렉토리에서 https://ik.imagekit.io/ 내용을 포함하는 모든 파일 목록 만들기
echo "Searching for files containing 'https://ik.imagekit.io/'..."
file_list=$(grep -rl 'https://ik.imagekit.io/' ./_wiki)


# 2. 위 파일 목록에서 https://ik.imagekit.io/ 파일을 읽어와 asset/images 에 다운로드
echo "Downloading images to asset/images..."
mkdir -p ./assets/images

IFS=$'\n'

for file in $file_list; 
do
  # Extract URLs from the file
  urls=$(grep -o 'https://ik\.imagekit\.io/[a-zA-Z0-9_/.\-]*' "$file")
  
  for url in $urls;
  do
    # Get the file name from the URL
    filename=$(basename "$url")
    
    # Download the file
    curl -s "$url" -o "./assets/images/$filename"
    
    # 3. https://ik.imagekit.io/ 를 asset/images 로 링크 변경
    sed -i '' "s|$url|/assets/images/$filename|g" "$file"
  done
done
