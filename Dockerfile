# Используем официальный Node.js образ
FROM node:alpine AS build

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json
COPY package.json package-lock.json ./
RUN npm install

# Копируем весь исходный код проекта
COPY . .

# Собираем проект с помощью Vite
RUN npm run build

# Используем Nginx для обслуживания проекта
FROM nginx:alpine

# Копируем файлы сборки из первого этапа
COPY --from=build /app/dist /usr/share/nginx/html

# Открываем порт 80
# EXPOSE 80

# Запускаем Nginx для обслуживания статических файлов
CMD ["nginx", "-g", "daemon off;"]
