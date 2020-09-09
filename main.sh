#!/bin/bash

# render out the documents
## compile
printf "\033[1m « Compiling \033[38;5;123mthe renderer\033[0;1m » \033[0m\n"
npx tsc -b
## use the compiled script
program="node ./dist/index.js"
## render the main readme
printf "\033[1m « Rendering \033[38;5;123m\`index.html\`\033[0;1m » \033[0m\n"
$program readme.md > dist/index.html

## copy the styles over
printf "\033[1m « Copying \033[38;5;123mthe stylesheet\033[0;1m » \033[0m\n"
cp styles.css dist/

## render the ‘repetytorium’ folder
mkdir -p dist/repetytorium
printf "\033[1m « Rendering \033[38;5;123mthe \`repetytorium\` documents\033[0;1m » \033[0m\n"
for doc in ./repetytorium/*; do
    ### extract the extension
    extension="${doc##*.}"
    if [ $extension = "md" ]; then
        ### render if the file is a Markdown document
        printf "\033[2m     $doc\033[0m\n"
        $program $doc > "dist/repetytorium/$(basename $doc .md)".html
    else
        ### otherwise copy it over
        cp $doc ./dist/repetytorium/
    fi
done

# remove the compiled script
rm -f dist/index.js

printf "\033[1m « Done » \033[0m\n"
