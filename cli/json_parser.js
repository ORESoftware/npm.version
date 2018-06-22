#!/usr/bin/env node
'use strict';

let stdin = '';

/*
 This script handles the case where --json is passed back
 or results look like this instead:

    npm@5.4.2 '5.4.2'
    npm@5.5.0 '5.5.0'
    npm@5.5.1 '5.5.1'
    npm@5.6.0 '5.6.0'
    npm@5.7.0 '5.7.0'
    npm@5.7.1 '5.7.1'
*/

process.stdin.resume()
.on('data', d => {
   stdin+=String(d || '').trim();
})
.once('end', () => {

  try{
    const results = JSON.parse(stdin);
    console.log(String(results.pop() || '').trim());
  }
  catch(err){
    const lastLine = String(stdin).split('\n').map(v => String(v).trim()).filter(Boolean);
    console.log(String(lastLine.pop() || '').split('@')[0].replace(/"/g,'').replace(/'/g,'').trim());
  }

});
