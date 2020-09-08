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

// render
const result = md.render(content.toString());

// add styles
console.log('<link rel=stylesheet href="styles.css"/>');

// put the rendered content
console.log(result);

// add MathJax
console.log('<script type="text/javascript" id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>');
