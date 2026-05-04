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
exports.AdminGuard = void 0;
const common_1 = require("@nestjs/common");
const auth_guard_1 = require("./auth.guard");
const firebase_service_1 = require("../../firebase/firebase.service");
let AdminGuard = class AdminGuard extends auth_guard_1.AuthGuard {
    constructor(firebaseService) {
        super(firebaseService);
    }
    async canActivate(context) {
        const isAuth = await super.canActivate(context);
        if (!isAuth)
            return false;
        const request = context.switchToHttp().getRequest();
        const user = request.user;
        try {
            const userDoc = await this.firebaseService.getFirestore().collection('users').doc(user.uid).get();
            if (!userDoc.exists || userDoc.data()?.isAdmin !== true) {
                throw new common_1.ForbiddenException('Admin access is required.');
            }
            return true;
        }
        catch (e) {
            if (e instanceof common_1.ForbiddenException)
                throw e;
            throw new common_1.ForbiddenException('Access denied.');
        }
    }
};
exports.AdminGuard = AdminGuard;
exports.AdminGuard = AdminGuard = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [firebase_service_1.FirebaseService])
], AdminGuard);
//# sourceMappingURL=admin.guard.js.map