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
exports.VocabularyController = void 0;
const common_1 = require("@nestjs/common");
const vocabulary_service_1 = require("./vocabulary.service");
const create_vocabulary_dto_1 = require("./dto/create-vocabulary.dto");
const update_vocabulary_dto_1 = require("./dto/update-vocabulary.dto");
const auth_guard_1 = require("../auth/guards/auth.guard");
const admin_guard_1 = require("../auth/guards/admin.guard");
const user_decorator_1 = require("../auth/decorators/user.decorator");
let VocabularyController = class VocabularyController {
    vocabularyService;
    constructor(vocabularyService) {
        this.vocabularyService = vocabularyService;
    }
    getVocabulary(category, authorId) {
        return this.vocabularyService.findAll(category, authorId);
    }
    addPersonalVocabulary(user, dto) {
        return this.vocabularyService.addPersonal(user.uid, dto);
    }
    createVocabularyWord(dto) {
        return this.vocabularyService.createGlobal(dto);
    }
    updateVocabularyWord(wordId, dto) {
        return this.vocabularyService.update(wordId, dto);
    }
    deleteVocabularyWord(wordId) {
        return this.vocabularyService.remove(wordId);
    }
};
exports.VocabularyController = VocabularyController;
__decorate([
    (0, common_1.Get)('vocabulary'),
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    __param(0, (0, common_1.Query)('category')),
    __param(1, (0, common_1.Query)('authorId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", void 0)
], VocabularyController.prototype, "getVocabulary", null);
__decorate([
    (0, common_1.Post)('vocabulary/personal'),
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    __param(0, (0, user_decorator_1.CurrentUser)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, create_vocabulary_dto_1.CreateVocabularyDto]),
    __metadata("design:returntype", void 0)
], VocabularyController.prototype, "addPersonalVocabulary", null);
__decorate([
    (0, common_1.Post)('admin/vocabulary'),
    (0, common_1.UseGuards)(admin_guard_1.AdminGuard),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_vocabulary_dto_1.CreateVocabularyDto]),
    __metadata("design:returntype", void 0)
], VocabularyController.prototype, "createVocabularyWord", null);
__decorate([
    (0, common_1.Put)('admin/vocabulary/:wordId'),
    (0, common_1.UseGuards)(admin_guard_1.AdminGuard),
    __param(0, (0, common_1.Param)('wordId')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, update_vocabulary_dto_1.UpdateVocabularyDto]),
    __metadata("design:returntype", void 0)
], VocabularyController.prototype, "updateVocabularyWord", null);
__decorate([
    (0, common_1.Delete)('admin/vocabulary/:wordId'),
    (0, common_1.UseGuards)(admin_guard_1.AdminGuard),
    __param(0, (0, common_1.Param)('wordId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], VocabularyController.prototype, "deleteVocabularyWord", null);
exports.VocabularyController = VocabularyController = __decorate([
    (0, common_1.Controller)(),
    __metadata("design:paramtypes", [vocabulary_service_1.VocabularyService])
], VocabularyController);
//# sourceMappingURL=vocabulary.controller.js.map