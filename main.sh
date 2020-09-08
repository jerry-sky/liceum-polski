#!/bin/bash

# prepare the output directory
mkdir -p dist

# render out the documents
## compile
npx tsc -b
## use the compiled script
program="node ./dist/index.js"
## render the main readme
$program readme.md > dist/index.html

## copy the styles over
cp styles.css dist/

## render the `repetytorium folder`
mkdir -p dist/repetytorium
for doc in ./repetytorium/*; do
    extension="${doc##*.}"
    if [ $extension = "md" ]; then
        $program $doc > "dist/repetytorium/$(basename $doc .md)".html
    else
        cp $doc ./dist/repetytorium/
    fi
done
