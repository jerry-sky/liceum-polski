#!./node_modules/.bin/ts-node
import MarkdownIt from 'markdown-it';
import MarkdownItAnchor from 'markdown-it-anchor';
import fs from 'fs';
import { exit } from 'process';
/**
 * There is no TS definition declaration for this package so `require` has to suffice.
 */
const MarkdownItMathJax = require('markdown-it-mathjax');

// acquired from <https://github.com/yzhang-gh/vscode-markdown/blob/master/src/util.ts#L172>
const PUNCTUATION_REGEXP = /[^\p{L}\p{M}\p{N}\p{Pc}\- ]/gu;

// setup the renderer
const md = new MarkdownIt()
    .use(MarkdownItAnchor, {
        // acquired from <https://github.com/yzhang-gh/vscode-markdown/blob/master/src/util.ts#L187>
        slugify: (string: string) => string.replace(PUNCTUATION_REGEXP, '').replace(/ /g, '-').toLocaleLowerCase()
    })
    // .use(MarkdownItKaTeX, { throwOnError: true });
    .use(new MarkdownItMathJax());

// read the path to the file
if (process.argv.length < 3) { exit(1); }
const path = process.argv[2];

// read the raw file
const content = fs.readFileSync(path);

const raw = content.toString();
// extract the title from the beginning of the document
const title = raw.split('\n', 2)[0];

// render
const result = md.render(raw)
    .replace(
        // replace every `.md` link file with `.html` link
        /(?<=\<a\s.{0,}href\=.+)(\.md)(?=(.{0}|(#.+))".{0,}\>)/gmis,
        '.html'
    );

// add title
console.log('<title>' + title.slice(2) + '</title>');

// add the standard meta tags
console.log('<meta name="viewport" content="width=device-width, initial-scale=1.0">');
console.log('<meta charset="utf-8">');
// add styles
console.log('<link rel=stylesheet href="/styles.css"/>');

// put the rendered content
console.log(result);

// add MathJax
console.log('<script type="text/javascript" id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>');
