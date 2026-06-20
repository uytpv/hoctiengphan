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
exports.SubmitExerciseDto = void 0;
const class_validator_1 = require("class-validator");
const swagger_1 = require("@nestjs/swagger");
class SubmitExerciseDto {
    exerciseId;
    answers;
    answer;
    taskId;
    planId;
    activityId;
}
exports.SubmitExerciseDto = SubmitExerciseDto;
__decorate([
    (0, swagger_1.ApiProperty)({ description: 'ID of the exercise being submitted' }),
    (0, class_validator_1.IsString)(),
    (0, class_validator_1.IsNotEmpty)(),
    __metadata("design:type", String)
], SubmitExerciseDto.prototype, "exerciseId", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({
        description: 'Map of question index to answer index or text',
        example: { '0': 1, '1': 'correct answer' },
        required: false,
    }),
    (0, class_validator_1.IsObject)(),
    (0, class_validator_1.IsOptional)(),
    __metadata("design:type", Object)
], SubmitExerciseDto.prototype, "answers", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({
        description: 'Single answer for simple exercises',
        required: false,
    }),
    (0, class_validator_1.IsOptional)(),
    __metadata("design:type", Object)
], SubmitExerciseDto.prototype, "answer", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({
        description: 'ID of the task in the roadmap',
        required: false,
    }),
    (0, class_validator_1.IsString)(),
    (0, class_validator_1.IsOptional)(),
    __metadata("design:type", String)
], SubmitExerciseDto.prototype, "taskId", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ description: 'ID of the study plan', required: false }),
    (0, class_validator_1.IsString)(),
    (0, class_validator_1.IsOptional)(),
    __metadata("design:type", String)
], SubmitExerciseDto.prototype, "planId", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ description: 'Legacy activity ID', required: false }),
    (0, class_validator_1.IsString)(),
    (0, class_validator_1.IsOptional)(),
    __metadata("design:type", String)
], SubmitExerciseDto.prototype, "activityId", void 0);
//# sourceMappingURL=submit-exercise.dto.js.map