FROM python:3.12

WORKDIR ~/todoapp

COPY . .

RUN apt update && apt install -y pkg-config libdbus-1-dev python3-dev

RUN pip install --upgrade pip
RUN pip install gunicorn
RUN pip install django
RUN pip install -r requirements.txt
RUN apt install sqlite3

EXPOSE 8096

CMD ["python3 manage.py makemigrations"]

CMD ["python3 manage.py migrate"]

CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8091", "todoApp.wsgi:application"]

