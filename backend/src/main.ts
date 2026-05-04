import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(new ValidationPipe({ whitelist: true, transform: true }));

  const config = new DocumentBuilder()
    .setTitle('Opi Suomea API')
    .setDescription('The Opi Suomea project API description')
    .setVersion('1.0')
    .addTag('andromeda')
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document);

  // Export swagger.json in development mode
  if (process.env.NODE_ENV !== 'production') {
    const fs = require('fs');
    const path = require('path');
    fs.writeFileSync(
      path.join(__dirname, '..', 'swagger.json'),
      JSON.stringify(document, null, 2),
    );
    console.log('Swagger JSON exported to swagger.json');
  }

  await app.listen(process.env.PORT ?? 3000);
}
bootstrap();
