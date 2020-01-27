const fs = require('fs')
const file = 'src/app/shared/copier.service.ts';
const data = fs.readFileSync(file, 'utf8');
setTimeout(() => fs.writeFileSync(file, data.replace('9999', '99999')), 8000)


