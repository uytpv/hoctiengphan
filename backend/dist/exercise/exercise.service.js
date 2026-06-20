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
exports.ExerciseService = void 0;
const common_1 = require("@nestjs/common");
const firebase_service_1 = require("../firebase/firebase.service");
const progress_service_1 = require("../progress/progress.service");
let ExerciseService = class ExerciseService {
    firebaseService;
    progressService;
    constructor(firebaseService, progressService) {
        this.firebaseService = firebaseService;
        this.progressService = progressService;
    }
    get collection() {
        return this.firebaseService.getFirestore().collection('exercises');
    }
    async getOne(id) {
        const doc = await this.collection.doc(id).get();
        if (!doc.exists) {
            throw new common_1.NotFoundException('Exercise not found');
        }
        const data = doc.data();
        if (data.questions && Array.isArray(data.questions)) {
            data.questions = data.questions.map((q) => {
                const { correctIndex, correctText, ...publicQ } = q;
                return publicQ;
            });
        }
        return { ...data, id: doc.id };
    }
    async getExercisesByLesson(lessonId) {
        const snapshot = await this.collection
            .where('lessonId', '==', lessonId)
            .get();
        return snapshot.docs.map((doc) => {
            const data = doc.data();
            if (data.questions && Array.isArray(data.questions)) {
                data.questions = data.questions.map((q) => {
                    const { correctIndex, correctText, ...publicQ } = q;
                    return publicQ;
                });
            }
            return { ...data, id: doc.id };
        });
    }
    async submitAnswer(uid, dto) {
        const doc = await this.collection.doc(dto.exerciseId).get();
        if (!doc.exists) {
            throw new common_1.NotFoundException('Exercise not found');
        }
        const exerciseData = doc.data();
        let score = 0;
        const questions = exerciseData.questions || [];
        const total = questions.length || 1;
        const feedback = [];
        if (questions.length > 0 && dto.answers) {
            for (let i = 0; i < questions.length; i++) {
                const q = questions[i];
                const userAnswer = dto.answers[i.toString()];
                let isCorrect = false;
                if (q.type === 'MULTIPLE_CHOICE' || q.type === 'TRUE_FALSE') {
                    isCorrect = userAnswer === q.correctIndex;
                }
                else if (q.type === 'FILL_IN_BLANK') {
                    const userStr = String(userAnswer || '')
                        .trim()
                        .toLowerCase();
                    const correctStr = String(q.correctText || '')
                        .trim()
                        .toLowerCase();
                    isCorrect = userStr === correctStr;
                }
                if (isCorrect)
                    score++;
                feedback.push({
                    questionIndex: i,
                    isCorrect,
                    correctAnswer: q.type === 'FILL_IN_BLANK' ? q.correctText : q.correctIndex,
                    explanation: q.explanation,
                });
            }
        }
        const percentage = (score / total) * 100;
        const percentageRounded = Math.round(percentage * 100) / 100;
        const passed = percentageRounded >= 70;
        if (passed && uid && dto.taskId) {
            await this.progressService.updateTaskProgress(uid, {
                taskId: dto.taskId,
                isCompleted: true,
            });
        }
        return {
            score,
            total,
            percentage: percentageRounded,
            passed,
            feedback,
        };
    }
};
exports.ExerciseService = ExerciseService;
exports.ExerciseService = ExerciseService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [firebase_service_1.FirebaseService,
        progress_service_1.ProgressService])
], ExerciseService);
//# sourceMappingURL=exercise.service.js.map