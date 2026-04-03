import { Injectable, OnModuleInit } from '@nestjs/common';
import * as admin from 'firebase-admin';

@Injectable()
export class FirebaseService implements OnModuleInit {
  onModuleInit() {
    // Trong môi trường development, trỏ SDK đến local emulators
    if (process.env.NODE_ENV !== 'production') {
      process.env.FIRESTORE_EMULATOR_HOST = '127.0.0.1:8080';
      process.env.FIREBASE_AUTH_EMULATOR_HOST = '127.0.0.1:9099';
    }

    try {
      if (!admin.apps.length) {
        admin.initializeApp({
          projectId: 'hoctiengphan-dev',
        });
        console.log('Firebase Admin SDK initialized (Emulator Mode: ' + (process.env.NODE_ENV !== 'production') + ')');
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
