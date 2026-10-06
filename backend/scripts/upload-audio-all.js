const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');
const serviceAccount = require('../hoc-tieng-phan-firebase-adminsdk-fbsvc-cbfffbc13f.json');

if (!admin.apps.length) {
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    storageBucket: 'hoc-tieng-phan.firebasestorage.app'
  });
}

const bucket = admin.storage().bucket();
const audioDir = path.resolve(__dirname, '../../content/Suomen Mestarit [Disc 1]');

async function uploadAllAudioFiles() {
  console.log('🚀 Checking & Uploading all audio files from Disc 1 to Firebase Storage...');
  const files = fs.readdirSync(audioDir).filter(f => f.endsWith('.mp3'));
  
  // Existing map
  const existingMapPath = path.resolve(__dirname, 'audio_urls_all.json');
  let urlMap = {};
  if (fs.existsSync(existingMapPath)) {
    try {
      urlMap = JSON.parse(fs.readFileSync(existingMapPath, 'utf8'));
    } catch (e) {}
  }
  const ch01MapPath = path.resolve(__dirname, 'audio_urls_ch01.json');
  if (fs.existsSync(ch01MapPath)) {
    const ch01 = JSON.parse(fs.readFileSync(ch01MapPath, 'utf8'));
    urlMap = { ...ch01, ...urlMap };
  }

  for (const fileName of files) {
    if (urlMap[fileName]) {
      console.log(`⏩ Already mapped: ${fileName}`);
      continue;
    }

    const filePath = path.join(audioDir, fileName);
    const num = parseInt(fileName.substring(0, 2), 10);
    let subFolder = 'ch01';
    if (num >= 15 && num <= 32) subFolder = 'ch02';
    else if (num >= 33 && num <= 45) subFolder = 'ch03';

    const cleanName = fileName
      .replace(/Ä/g, 'A')
      .replace(/ä/g, 'a')
      .replace(/Ö/g, 'O')
      .replace(/ö/g, 'o')
      .replace(/[^a-zA-Z0-9._-]/g, '_');
    const destination = `audio/${subFolder}/${cleanName}`;

    console.log(`Uploading ${fileName} -> ${destination}...`);
    await bucket.upload(filePath, {
      destination: destination,
      metadata: {
        contentType: 'audio/mpeg',
        cacheControl: 'public, max-age=31536000',
      }
    });

    const encodedPath = encodeURIComponent(destination);
    const publicUrl = `https://firebasestorage.googleapis.com/v0/b/hoc-tieng-phan.firebasestorage.app/o/${encodedPath}?alt=media`;
    urlMap[fileName] = publicUrl;
    console.log(`✅ Uploaded: ${fileName} -> ${publicUrl}`);
  }

  fs.writeFileSync(existingMapPath, JSON.stringify(urlMap, null, 2), 'utf8');
  console.log(`\n🎉 All ${files.length} audio tracks are ready in ${existingMapPath}`);
}

uploadAllAudioFiles().catch(err => {
  console.error('❌ Upload failed:', err);
  process.exit(1);
});
