#!/bin/bash

cat preamble.md > README.md
echo "" >> README.md

for file in files/*.html; do
  title=$(nokogiri "$file" -e 'puts $_.at_css("title").content')
  date=$(nokogiri "$file" -e 'puts $_.at_css(".post-signature.owner .relativetime").attr("title")')
  date=$(date -d "$date" +%Y-%m-%d)
  title=$(echo "$title" | sed -E 's/^\s+//' | sed -E 's/\s+$//')
  echo "* [$title](https://nvidialinuxdriversaretrash.github.io/files/$file.html) ($date)" >> README.md
done
