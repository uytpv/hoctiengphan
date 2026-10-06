import { Injectable, OnModuleInit } from '@nestjs/common';
import * as admin from 'firebase-admin';
import * as fs from 'fs';
import * as path from 'path';

@Injectable()
export class FirebaseService implements OnModuleInit {
  onModuleInit() {
    const useEmulator = process.env.USE_FIREBASE_EMULATOR === 'true';

    if (useEmulator) {
      process.env.FIRESTORE_EMULATOR_HOST =
        process.env.FIRESTORE_EMULATOR_HOST || '127.0.0.1:8080';
      process.env.FIREBASE_AUTH_EMULATOR_HOST =
        process.env.FIREBASE_AUTH_EMULATOR_HOST || '127.0.0.1:9099';
    } else {
      delete process.env.FIRESTORE_EMULATOR_HOST;
      delete process.env.FIREBASE_AUTH_EMULATOR_HOST;
    }

    try {
      if (!admin.apps.length) {
        if (useEmulator) {
          admin.initializeApp({
            projectId: process.env.FIREBASE_PROJECT_ID || 'hoc-tieng-phan',
          });
          console.log('Firebase Admin SDK initialized (Emulator Mode: true)');
        } else {
          // Connect to Production Firebase
          const candidatePaths = [
            process.env.FIREBASE_SERVICE_ACCOUNT_KEY,
            path.resolve(
              process.cwd(),
              'hoc-tieng-phan-firebase-adminsdk-fbsvc-cbfffbc13f.json',
            ),
            path.resolve(
              __dirname,
              '../../hoc-tieng-phan-firebase-adminsdk-fbsvc-cbfffbc13f.json',
            ),
            path.resolve(
              __dirname,
              '../../../hoc-tieng-phan-firebase-adminsdk-fbsvc-cbfffbc13f.json',
            ),
          ].filter(Boolean) as string[];

          let serviceAccountKeyPath: string | undefined;
          for (const p of candidatePaths) {
            if (fs.existsSync(p)) {
              serviceAccountKeyPath = p;
              break;
            }
          }

          if (serviceAccountKeyPath) {
            const serviceAccount = JSON.parse(
              fs.readFileSync(serviceAccountKeyPath, 'utf8'),
            );
            admin.initializeApp({
              credential: admin.credential.cert(serviceAccount),
              projectId: serviceAccount.project_id || 'hoc-tieng-phan',
            });
            console.log(
              `Firebase Admin SDK initialized with Production Credentials (project: ${serviceAccount.project_id || 'hoc-tieng-phan'})`,
            );
          } else {
            admin.initializeApp({
              projectId: process.env.FIREBASE_PROJECT_ID || 'hoc-tieng-phan',
            });
            console.log(
              'Firebase Admin SDK initialized with Default Credentials (project: hoc-tieng-phan)',
            );
          }
        }
      }
    } catch (error) {
      console.error('Firebase Admin SDK init error:', error);
    }
  }

  getAuth() {
    return admin.auth();
  }

  getFirestore() {
    return admin.firestore();
  }
}
