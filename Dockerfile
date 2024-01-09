# Используйте образ hwdsl2/ipsec-vpn-server как базовый
FROM hwdsl2/ipsec-vpn-server:debian

# Установите рабочую директорию
WORKDIR /service

# Установите переменные среды для немудрой установки
#ENV DEBIAN_FRONTEND=noninteractive

# Обновите список пакетов и установите python3-venv
RUN apt-get update \
    && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv

# Копируйте ваше приложение и файл requirements.txt
COPY service /service
COPY requirements.txt /temp/requirements.txt

# Создайте виртуальное окружение Python
#RUN python3 -m venv /service/env

# Настроить и активировать виртуальную среду
ENV VIRTUAL_ENV "/venv"
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH "$VIRTUAL_ENV/bin:$PATH"

# Активируйте виртуальную среду
RUN pip install --no-cache-dir -r /temp/requirements.txt

# Установите зависимости приложения
#RUN . /service/venv/bin/activate
#RUN . /service/venv/bin/activate && pip install -r /temp/requirements.txt
#RUN pip install -r /temp/requirements.txt

# Создайте пользователя для запуска приложения
#RUN adduser --disabled-password service-user

# Установите пользователя для запуска приложения
#USER service-user



# Определите порт, который будет использоваться
#EXPOSE 8000
#EXPOSE 500
#EXPOSE 4500

# Команда для запуска приложения
#CMD ["/bin/sh", "-c", "python3 /service/manage.py runserver 0.0.0.0:8000"]
