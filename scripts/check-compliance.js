const fs = require('fs');
const path = require('path');

const CHECK_DIRS = [
  'backend/src',
  'mobile_app/lib',
  'admin_tool/lib'
];

function checkFiles(dir) {
  if (!fs.existsSync(dir)) return;
  const files = fs.readdirSync(dir);
  files.forEach(file => {
    const fullPath = path.join(dir, file);
    const stats = fs.statSync(fullPath);
    if (stats.isDirectory()) {
      checkFiles(fullPath);
    } else if (file.endsWith('.ts') || file.endsWith('.dart')) {
      // Ignore main files and specific patterns
      if (file === 'main.ts' || file === 'main.dart' || file.includes('.freezed.') || file.includes('.g.')) return;
      
      const firstChar = file[0];
      if (firstChar !== firstChar.toUpperCase()) {
        console.error(`[VIOLATION] File ${fullPath} should be PascalCase.`);
        process.exitCode = 1;
      }
    }
  });
}

console.log('Checking DTH Global Constitution Compliance...');
CHECK_DIRS.forEach(checkFiles);
if (process.exitCode === 1) {
  console.log('Compliance Check FAILED.');
} else {
  console.log('Compliance Check PASSED.');
}
