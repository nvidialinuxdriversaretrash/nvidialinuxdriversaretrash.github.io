#!/bin/bash

read -p "Enter a URL: " url
curl "$url" > tmp.html
title=$(nokogiri tmp.html -e 'puts $_.at_css("title").content')
date=$(nokogiri tmp.html -e 'puts $_.at_css(".post-signature.owner .relativetime").attr("title")')
date=$(date -d "$date" +%Y-%m-%d)
words=( $title )
title=$(echo "${words[@]:0:10}" | tr ' ' - | sed -E 's/-+/-/g' | sed -E 's/^-+//' | sed -E 's/-+$//')
file="files/$date-$title.html"

if [ -f "$file" ]; then
  echo "Already exists"
  rm tmp.html
  exit
fi

mv tmp.html "$file"
echo "Added $file"
echo "$url" > "files/$date-$title.url"
git add files
./generate.sh
git add README.md
git commit -m "Added $url"
