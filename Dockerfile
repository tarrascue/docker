# Используем alpine как базовый образ
FROM alpine:3.12

# Установка пакетов и зависимостей
RUN apk update && apk upgrade && \
    apk add nginx && \
    mkdir -p /run/nginx

# Создаем директорию /www
RUN mkdir /www

# Настройка Nginx
RUN adduser -D -g 'www' www && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /www

# Копирование конфигурационного файла Nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /www/

# Определяем рабочую директорию
WORKDIR /www

# Expose ports
EXPOSE 80 443

# Запуск сервиса Nginx
CMD ["nginx", "-g", "daemon off;"]
