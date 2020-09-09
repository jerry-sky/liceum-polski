#!/bin/bash

# prepare the output directory
rm -rf dist

# copy the target branch
printf "\033[1m « Copying the \033[38;5;123m\`gh-pages\`\033[0;1m branch » \033[0m\n"
git clone -b gh-pages --single-branch https://github.com/jerry-sky/liceum-polski dist &> /dev/null

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

cd dist

git add .
git reset index.js &> /dev/null
rm -f index.js
if [ $(git status -s) ]; then
    printf "\033[1m « Pushing \033[38;5;123mthe changes\033[0;1m » \033[0m\n"
    git commit -m "deployed on $(date)"
    git push origin gh-pages
else
    printf "\033[1m « No changes detected »\033[0m\n"
fi

cd ..

printf "\033[1m « Done » \033[0m\n"
