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
exports.GrammarService = void 0;
const common_1 = require("@nestjs/common");
const firebase_service_1 = require("../firebase/firebase.service");
let GrammarService = class GrammarService {
    firebaseService;
    constructor(firebaseService) {
        this.firebaseService = firebaseService;
    }
    get collection() {
        return this.firebaseService.getFirestore().collection('grammar');
    }
    async findAllTopics() {
        const snapshot = await this.collection.select('id', 'chapter', 'title', 'desc').get();
        return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    }
    async findOne(id) {
        const doc = await this.collection.doc(id).get();
        if (!doc.exists)
            throw new common_1.NotFoundException('Grammar topic not found');
        return { id: doc.id, ...doc.data() };
    }
    async create(dto) {
        const { id, ...data } = dto;
        await this.collection.doc(id).set({
            ...data,
            createdAt: new Date(),
            updatedAt: new Date(),
        });
        return { id, ...data };
    }
    async update(id, dto) {
        await this.collection.doc(id).update({
            ...dto,
            updatedAt: new Date(),
        });
        return { id, ...dto };
    }
    async remove(id) {
        await this.collection.doc(id).delete();
        return { id, deleted: true };
    }
};
exports.GrammarService = GrammarService;
exports.GrammarService = GrammarService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [firebase_service_1.FirebaseService])
], GrammarService);
//# sourceMappingURL=grammar.service.js.map