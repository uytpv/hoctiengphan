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
const admin = __importStar(require("firebase-admin"));
const swagger_1 = require("@nestjs/swagger");
let VocabularyController = class VocabularyController {
    vocabularyService;
    constructor(vocabularyService) {
        this.vocabularyService = vocabularyService;
    }
    getVocabulary(category, authorUid) {
        return this.vocabularyService.findAll(category, authorUid);
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
    (0, swagger_1.ApiOperation)({ summary: 'Get vocabulary list' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'List of vocabulary words' }),
    __param(0, (0, common_1.Query)('category')),
    __param(1, (0, common_1.Query)('authorUid')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", void 0)
], VocabularyController.prototype, "getVocabulary", null);
__decorate([
    (0, common_1.Post)('vocabulary/personal'),
    (0, common_1.UseGuards)(auth_guard_1.AuthGuard),
    (0, swagger_1.ApiOperation)({ summary: 'Add personal vocabulary word' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'Personal word added' }),
    __param(0, (0, user_decorator_1.CurrentUser)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, create_vocabulary_dto_1.CreateVocabularyDto]),
    __metadata("design:returntype", void 0)
], VocabularyController.prototype, "addPersonalVocabulary", null);
__decorate([
    (0, common_1.Post)('admin/vocabulary'),
    (0, common_1.UseGuards)(admin_guard_1.AdminGuard),
    (0, swagger_1.ApiOperation)({ summary: 'Create a global vocabulary word' }),
    (0, swagger_1.ApiResponse)({ status: 201, description: 'Global word created' }),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_vocabulary_dto_1.CreateVocabularyDto]),
    __metadata("design:returntype", void 0)
], VocabularyController.prototype, "createVocabularyWord", null);
__decorate([
    (0, common_1.Put)('admin/vocabulary/:wordId'),
    (0, common_1.UseGuards)(admin_guard_1.AdminGuard),
    (0, swagger_1.ApiOperation)({ summary: 'Update a vocabulary word' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Word updated' }),
    __param(0, (0, common_1.Param)('wordId')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, update_vocabulary_dto_1.UpdateVocabularyDto]),
    __metadata("design:returntype", void 0)
], VocabularyController.prototype, "updateVocabularyWord", null);
__decorate([
    (0, common_1.Delete)('admin/vocabulary/:wordId'),
    (0, common_1.UseGuards)(admin_guard_1.AdminGuard),
    (0, swagger_1.ApiOperation)({ summary: 'Delete a vocabulary word' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Word deleted' }),
    __param(0, (0, common_1.Param)('wordId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], VocabularyController.prototype, "deleteVocabularyWord", null);
exports.VocabularyController = VocabularyController = __decorate([
    (0, swagger_1.ApiTags)('Vocabulary'),
    (0, swagger_1.ApiBearerAuth)(),
    (0, common_1.Controller)(),
    __metadata("design:paramtypes", [vocabulary_service_1.VocabularyService])
], VocabularyController);
//# sourceMappingURL=vocabulary.controller.js.map