#!/bin/bash

cat preamble.md > README.md
echo "" >> README.md

for file in $(ls -r files/*.html); do
  title=$(nokogiri "$file" -e 'puts $_.at_css("title").content')
  date=$(nokogiri "$file" -e 'puts $_.at_css(".post-signature.owner .relativetime").attr("title")')
  date=$(date -d "$date" +%Y-%m-%d)
  title=$(echo "$title" | sed -E 's/^\s+//' | sed -E 's/\s+$//')
  name=$(basename -s .html "$file")
  url=$(cat "files/$name.url")
  echo "* [$title]($url) ($date) ([mirror](https://nvidialinuxdriversaretrash.github.io/files/$name.html))" >> README.md
done
