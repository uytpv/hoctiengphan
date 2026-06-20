"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ProgressService = void 0;
const common_1 = require("@nestjs/common");
const firebase_service_1 = require("../firebase/firebase.service");
let ProgressService = class ProgressService {
    firebaseService;
    constructor(firebaseService) {
        this.firebaseService = firebaseService;
    }
    get collection() {
        return this.firebaseService.getFirestore().collection('userProgress');
    }
    async getUserProgress(uid) {
        const docRef = this.collection.doc(uid);
        const doc = await docRef.get();
        const completedTasksSnapshot = await docRef
            .collection('completedTasks')
            .get();
        const completedTasks = {};
        completedTasksSnapshot.docs.forEach((d) => {
            completedTasks[d.id] = true;
        });
        if (!doc.exists) {
            return {
                completedTasks,
                updatedAt: new Date(),
            };
        }
        const data = doc.data();
        return {
            completedTasks,
            updatedAt: data.updatedAt || new Date(),
        };
    }
    async updateTaskProgress(uid, dto) {
        const userProgressRef = this.collection.doc(uid);
        const taskRef = userProgressRef.collection('completedTasks').doc(dto.taskId);
        const now = new Date();
        if (dto.isCompleted) {
            await taskRef.set({
                completedAt: now,
                isCompleted: true,
            });
        }
        else {
            await taskRef.delete();
        }
        await userProgressRef.set({
            updatedAt: now,
        }, { merge: true });
        return { taskId: dto.taskId, isCompleted: dto.isCompleted };
    }
};
exports.ProgressService = ProgressService;
exports.ProgressService = ProgressService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [firebase_service_1.FirebaseService])
], ProgressService);
//# sourceMappingURL=progress.service.js.map