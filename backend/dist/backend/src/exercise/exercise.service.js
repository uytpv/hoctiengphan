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
        return { id: doc.id, ...data };
    }
    async getExercisesByLesson(lessonId) {
        const snapshot = await this.collection.where('lessonId', '==', lessonId).get();
        return snapshot.docs.map(doc => {
            const data = doc.data();
            if (data.questions && Array.isArray(data.questions)) {
                data.questions = data.questions.map((q) => {
                    const { correctIndex, correctText, ...publicQ } = q;
                    return publicQ;
                });
            }
            return { id: doc.id, ...data };
        });
    }
    async submitAnswer(uid, dto) {
        const doc = await this.collection.doc(dto.exerciseId).get();
        if (!doc.exists) {
            throw new common_1.NotFoundException('Exercise not found');
        }
        const exerciseData = doc.data();
        let score = 0;
        let total = 1;
        let results = [];
        if (exerciseData.questions && Array.isArray(exerciseData.questions) && dto.answers) {
            total = exerciseData.questions.length;
            results = exerciseData.questions.map((q, index) => {
                const userAnswer = dto.answers[index.toString()];
                let isCorrect = false;
                if (q.type === 'MULTIPLE_CHOICE' || !q.type) {
                    isCorrect = userAnswer === q.correctIndex;
                }
                else if (q.type === 'FILL_IN_BLANK') {
                    const userStr = String(userAnswer || '').trim().toLowerCase();
                    const correctStr = String(q.correctText || '').trim().toLowerCase();
                    isCorrect = userStr === correctStr;
                }
                if (isCorrect)
                    score++;
                return {
                    index,
                    isCorrect,
                    correctIndex: q.correctIndex,
                    correctText: q.correctText,
                };
            });
        }
        else {
            const isCorrect = this.checkAnswer(exerciseData, dto.answer);
            if (isCorrect)
                score = 1;
            results = [{ isCorrect, correctIndex: exerciseData.correctIndex }];
        }
        const percentage = (score / total) * 100;
        if (percentage >= 70 && dto.planId && dto.activityId) {
            const db = this.firebaseService.getFirestore();
            try {
                await db.collection('studyPlans').doc(dto.planId).collection('activities').doc(dto.activityId).update({
                    isCompleted: true,
                    score: percentage,
                    updatedAt: new Date()
                });
            }
            catch (e) {
                await db.collection('study_plans').doc(dto.planId).collection('activities').doc(dto.activityId).update({
                    isCompleted: true,
                    score: percentage,
                    updatedAt: new Date()
                });
            }
        }
        return {
            score,
            total,
            percentage,
            results,
        };
    }
    checkAnswer(exercise, userAnswer) {
        const correct = exercise.correctIndex ?? exercise.correctAnswer;
        if (Array.isArray(correct)) {
            if (!Array.isArray(userAnswer))
                return false;
            return (correct.length === userAnswer.length &&
                correct.every((val, index) => val === userAnswer[index]));
        }
        if (typeof correct === 'number' || typeof userAnswer === 'number') {
            return correct?.toString() === userAnswer?.toString();
        }
        return correct === userAnswer;
    }
};
exports.ExerciseService = ExerciseService;
exports.ExerciseService = ExerciseService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [firebase_service_1.FirebaseService,
        progress_service_1.ProgressService])
], ExerciseService);
//# sourceMappingURL=exercise.service.js.map