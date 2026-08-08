import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

async function bootstrap() {

  const app = await NestFactory.create(AppModule);

  app.enableCors({
    origin: [
      'http://localhost:4200',
      'https://fast-track-food.netlify.app'
    ],
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    credentials: true,
  });

   // Configuración de Swagger
  const config = new DocumentBuilder()
    .setTitle('Fast Track Food API')
    .setDescription(
      'API para gestión de productos, categorías, usuarios y pedidos'
    )
    .setVersion('1.0')
    .addBearerAuth()
    .build();

  const document = SwaggerModule.createDocument(app, config);

  SwaggerModule.setup('api', app, document);


  await app.listen(process.env.PORT ?? 3000);
}

bootstrap();