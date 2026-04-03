import { CanActivate, ExecutionContext } from '@nestjs/common';
import { AuthGuard } from './auth.guard';
import { FirebaseService } from '../../firebase/firebase.service';
export declare class AdminGuard extends AuthGuard implements CanActivate {
    constructor(firebaseService: FirebaseService);
    canActivate(context: ExecutionContext): Promise<boolean>;
}
