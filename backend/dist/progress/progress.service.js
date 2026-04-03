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
        const snapshot = await this.collection.doc(uid).collection('completedTasks').get();
        return snapshot.docs.map(doc => doc.id);
    }
    async updateTaskProgress(uid, dto) {
        const taskRef = this.collection.doc(uid).collection('completedTasks').doc(dto.taskId);
        if (dto.isCompleted) {
            await taskRef.set({
                completedAt: new Date(),
                isCompleted: true,
            });
            return { taskId: dto.taskId, isCompleted: true };
        }
        else {
            await taskRef.delete();
            return { taskId: dto.taskId, isCompleted: false };
        }
    }
};
exports.ProgressService = ProgressService;
exports.ProgressService = ProgressService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [firebase_service_1.FirebaseService])
], ProgressService);
//# sourceMappingURL=progress.service.js.map