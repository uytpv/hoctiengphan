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
exports.VocabularyService = void 0;
const common_1 = require("@nestjs/common");
const firebase_service_1 = require("../firebase/firebase.service");
let VocabularyService = class VocabularyService {
    firebaseService;
    constructor(firebaseService) {
        this.firebaseService = firebaseService;
    }
    get collection() {
        return this.firebaseService.getFirestore().collection('vocabulary');
    }
    async findAll(category, authorId) {
        let query = this.collection;
        if (category) {
            query = query.where('category', '==', category);
        }
        if (authorId) {
            query = query.where('authorId', '==', authorId);
        }
        const snapshot = await query.get();
        return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    }
    async addPersonal(uid, dto) {
        const docRef = await this.collection.add({
            ...dto,
            authorId: uid,
            createdAt: new Date(),
            updatedAt: new Date(),
        });
        return { id: docRef.id, ...dto, authorId: uid };
    }
    async createGlobal(dto) {
        const docRef = await this.collection.add({
            ...dto,
            authorId: null,
            createdAt: new Date(),
            updatedAt: new Date(),
        });
        return { id: docRef.id, ...dto, authorId: null };
    }
    async update(id, dto) {
        const docRef = this.collection.doc(id);
        await docRef.update({ ...dto, updatedAt: new Date() });
        return { id, ...dto };
    }
    async remove(id) {
        await this.collection.doc(id).delete();
        return { id, deleted: true };
    }
};
exports.VocabularyService = VocabularyService;
exports.VocabularyService = VocabularyService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [firebase_service_1.FirebaseService])
], VocabularyService);
//# sourceMappingURL=vocabulary.service.js.map