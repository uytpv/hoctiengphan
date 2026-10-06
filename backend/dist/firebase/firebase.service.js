"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.FirebaseService = void 0;
const common_1 = require("@nestjs/common");
const admin = __importStar(require("firebase-admin"));
const fs = __importStar(require("fs"));
const path = __importStar(require("path"));
let FirebaseService = class FirebaseService {
    onModuleInit() {
        const useEmulator = process.env.USE_FIREBASE_EMULATOR === 'true';
        if (useEmulator) {
            process.env.FIRESTORE_EMULATOR_HOST =
                process.env.FIRESTORE_EMULATOR_HOST || '127.0.0.1:8080';
            process.env.FIREBASE_AUTH_EMULATOR_HOST =
                process.env.FIREBASE_AUTH_EMULATOR_HOST || '127.0.0.1:9099';
        }
        else {
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
                }
                else {
                    const candidatePaths = [
                        process.env.FIREBASE_SERVICE_ACCOUNT_KEY,
                        path.resolve(process.cwd(), 'hoc-tieng-phan-firebase-adminsdk-fbsvc-cbfffbc13f.json'),
                        path.resolve(__dirname, '../../hoc-tieng-phan-firebase-adminsdk-fbsvc-cbfffbc13f.json'),
                        path.resolve(__dirname, '../../../hoc-tieng-phan-firebase-adminsdk-fbsvc-cbfffbc13f.json'),
                    ].filter(Boolean);
                    let serviceAccountKeyPath;
                    for (const p of candidatePaths) {
                        if (fs.existsSync(p)) {
                            serviceAccountKeyPath = p;
                            break;
                        }
                    }
                    if (serviceAccountKeyPath) {
                        const serviceAccount = JSON.parse(fs.readFileSync(serviceAccountKeyPath, 'utf8'));
                        admin.initializeApp({
                            credential: admin.credential.cert(serviceAccount),
                            projectId: serviceAccount.project_id || 'hoc-tieng-phan',
                        });
                        console.log(`Firebase Admin SDK initialized with Production Credentials (project: ${serviceAccount.project_id || 'hoc-tieng-phan'})`);
                    }
                    else {
                        admin.initializeApp({
                            projectId: process.env.FIREBASE_PROJECT_ID || 'hoc-tieng-phan',
                        });
                        console.log('Firebase Admin SDK initialized with Default Credentials (project: hoc-tieng-phan)');
                    }
                }
            }
        }
        catch (error) {
            console.error('Firebase Admin SDK init error:', error);
        }
    }
    getAuth() {
        return admin.auth();
    }
    getFirestore() {
        return admin.firestore();
    }
};
exports.FirebaseService = FirebaseService;
exports.FirebaseService = FirebaseService = __decorate([
    (0, common_1.Injectable)()
], FirebaseService);
//# sourceMappingURL=firebase.service.js.map