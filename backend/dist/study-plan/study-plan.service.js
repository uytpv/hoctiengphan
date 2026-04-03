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
exports.StudyPlanService = void 0;
const common_1 = require("@nestjs/common");
const firebase_service_1 = require("../firebase/firebase.service");
let StudyPlanService = class StudyPlanService {
    firebaseService;
    constructor(firebaseService) {
        this.firebaseService = firebaseService;
    }
    get collection() {
        return this.firebaseService.getFirestore().collection('studyPlans');
    }
    async getStudyPlan(planId = 'suomen_mestari_1') {
        const doc = await this.collection.doc(planId).get();
        if (!doc.exists)
            throw new common_1.NotFoundException('Study plan not found');
        return { id: doc.id, ...doc.data() };
    }
    async updateStudyPlan(planId = 'suomen_mestari_1', dto) {
        await this.collection.doc(planId).set(dto, { merge: true });
        return { id: planId, ...dto };
    }
};
exports.StudyPlanService = StudyPlanService;
exports.StudyPlanService = StudyPlanService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [firebase_service_1.FirebaseService])
], StudyPlanService);
//# sourceMappingURL=study-plan.service.js.map