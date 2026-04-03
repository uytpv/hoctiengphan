import { Injectable, CanActivate, ExecutionContext, ForbiddenException } from '@nestjs/common';
import { AuthGuard } from './auth.guard';
import { FirebaseService } from '../../firebase/firebase.service';

@Injectable()
export class AdminGuard extends AuthGuard implements CanActivate {
  constructor(firebaseService: FirebaseService) {
    super(firebaseService);
  }

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const isAuth = await super.canActivate(context);
    if (!isAuth) return false;

    const request = context.switchToHttp().getRequest();
    const user = request.user;
    
    // Check if user document contains isAdmin: true
    try {
      const userDoc = await this.firebaseService.getFirestore().collection('users').doc(user.uid).get();
      if (!userDoc.exists || userDoc.data()?.isAdmin !== true) {
        throw new ForbiddenException('Admin access is required.');
      }
      return true;
    } catch(e) {
      if (e instanceof ForbiddenException) throw e;
      throw new ForbiddenException('Access denied.');
    }
  }
}
