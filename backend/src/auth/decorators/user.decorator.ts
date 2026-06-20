import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import * as admin from 'firebase-admin';

export const CurrentUser = createParamDecorator(
  (data: unknown, ctx: ExecutionContext) => {
    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
    const request = ctx.switchToHttp().getRequest<any>();
    // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
    return request.user as admin.auth.DecodedIdToken;
  },
);
