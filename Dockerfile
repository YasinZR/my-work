# Шаг 1: Сборка React-приложения
FROM node:20 AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Шаг 2: Запуск готового приложения через Nginx
FROM nginx:alpine

# Копируем собранное приложение в Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Копируем дефолтный конфиг Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
