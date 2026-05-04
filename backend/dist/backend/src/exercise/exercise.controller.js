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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ExerciseController = void 0;
const common_1 = require("@nestjs/common");
const exercise_service_1 = require("./exercise.service");
const submit_exercise_dto_1 = require("./dto/submit-exercise.dto");
const auth_guard_1 = require("../auth/guards/auth.guard");
const user_decorator_1 = require("../auth/decorators/user.decorator");
const swagger_1 = require("@nestjs/swagger");
let ExerciseController = class ExerciseController {
    exerciseService;
    constructor(exerciseService) {
        this.exerciseService = exerciseService;
    }
    getExercisesByLesson(lessonId) {
        return this.exerciseService.getExercisesByLesson(lessonId);
    }
    getExerciseById(id) {
        return this.exerciseService.getOne(id);
    }
    submitAnswer(user, dto) {
        return this.exerciseService.submitAnswer(user.uid, dto);
    }
};
exports.ExerciseController = ExerciseController;
__decorate([
    (0, common_1.Get)('lesson/:lessonId'),
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, swagger_1.ApiOperation)({ summary: 'Get all exercises for a lesson' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'List of exercises (without answers)' }),
    __param(0, (0, common_1.Param)('lessonId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], ExerciseController.prototype, "getExercisesByLesson", null);
__decorate([
    (0, common_1.Get)(':id'),
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, swagger_1.ApiOperation)({ summary: 'Get exercise by ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'The exercise data (without answers)' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], ExerciseController.prototype, "getExerciseById", null);
__decorate([
    (0, common_1.Post)('submit'),
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, swagger_1.ApiOperation)({ summary: 'Submit an exercise answer' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Result of the submission' }),
    __param(0, (0, user_decorator_1.CurrentUser)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, submit_exercise_dto_1.SubmitExerciseDto]),
    __metadata("design:returntype", void 0)
], ExerciseController.prototype, "submitAnswer", null);
exports.ExerciseController = ExerciseController = __decorate([
    (0, swagger_1.ApiTags)('Exercise'),
    (0, swagger_1.ApiBearerAuth)(),
    (0, common_1.Controller)('exercises'),
    __metadata("design:paramtypes", [exercise_service_1.ExerciseService])
], ExerciseController);
//# sourceMappingURL=exercise.controller.js.map