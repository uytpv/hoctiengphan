import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { FirebaseModule } from './firebase/firebase.module';
import { AuthModule } from './auth/auth.module';
import { VocabularyModule } from './vocabulary/VocabularyModule';
import { GrammarModule } from './grammar/grammar.module';
import { StudyPlanModule } from './study-plan/StudyPlanModule';
import { ProgressModule } from './progress/progress.module';

@Module({
  imports: [FirebaseModule, AuthModule, VocabularyModule, GrammarModule, StudyPlanModule, ProgressModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
