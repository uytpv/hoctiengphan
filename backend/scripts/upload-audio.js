const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');
const serviceAccount = require('../hoc-tieng-phan-firebase-adminsdk-fbsvc-cbfffbc13f.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  storageBucket: 'hoc-tieng-phan.firebasestorage.app'
});

const bucket = admin.storage().bucket();
const audioDir = path.resolve(__dirname, '../../content/Suomen Mestarit [Disc 1]');

async function uploadAudioFiles() {
  console.log('🚀 Uploading Chapter 1 Audio files to Firebase Storage...');
  const files = fs.readdirSync(audioDir);
  const targetFiles = files.filter(f => {
    const num = parseInt(f.substring(0, 2), 10);
    return num >= 2 && num <= 14;
  });

  const urlMap = {};

  for (const fileName of targetFiles) {
    const filePath = path.join(audioDir, fileName);
    // Sanitize destination path (ASCII friendly for URL)
    const cleanName = fileName
      .replace(/Ä/g, 'A')
      .replace(/ä/g, 'a')
      .replace(/Ö/g, 'O')
      .replace(/ö/g, 'o')
      .replace(/[^a-zA-Z0-9._-]/g, '_');
    const destination = `audio/ch01/${cleanName}`;

    console.log(`Uploading ${fileName} -> ${destination}...`);
    await bucket.upload(filePath, {
      destination: destination,
      metadata: {
        contentType: 'audio/mpeg',
        cacheControl: 'public, max-age=31536000',
      }
    });

    // Construct Firebase public download URL
    const encodedPath = encodeURIComponent(destination);
    const publicUrl = `https://firebasestorage.googleapis.com/v0/b/hoc-tieng-phan.firebasestorage.app/o/${encodedPath}?alt=media`;
    urlMap[fileName] = publicUrl;
    console.log(`✅ Uploaded: ${fileName}`);
    console.log(`   URL: ${publicUrl}`);
  }

  const outputPath = path.resolve(__dirname, 'audio_urls_ch01.json');
  fs.writeFileSync(outputPath, JSON.stringify(urlMap, null, 2), 'utf8');
  console.log(`\n🎉 All ${targetFiles.length} audio files uploaded! Saved mapping to ${outputPath}`);
}

uploadAudioFiles().catch(err => {
  console.error('❌ Upload failed:', err);
  process.exit(1);
});
