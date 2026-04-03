import { CanActivate, ExecutionContext } from '@nestjs/common';
import { FirebaseService } from '../../firebase/firebase.service';
export declare class AuthGuard implements CanActivate {
    protected readonly firebaseService: FirebaseService;
    constructor(firebaseService: FirebaseService);
    canActivate(context: ExecutionContext): Promise<boolean>;
    private extractTokenFromHeader;
}
