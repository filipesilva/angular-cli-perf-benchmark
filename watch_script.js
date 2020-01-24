const fs = require('fs')
const file = 'one/src/app/a4/a1/a11/a11.component.ts';
const data = fs.readFileSync(file, 'utf8');
fs.writeFileSync(file, data.replace(/this.fibonacci(10);/g, 'this.fibonacci(10);console.log(true);'));