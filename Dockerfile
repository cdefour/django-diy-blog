# --- Base Node ---
FROM python



RUN git clone https://github.com/mdn/django-diy-blog.git diyblog
WORKDIR diyblog
#RUN apt-get update -y && apt-get install -y python3-pip
RUN pip install --upgrade pip

RUN pip install -r requirements.txt
RUN python manage.py makemigrations
RUN python manage.py migrate
RUN python manage.py collectstatic
RUN python manage.py test # Run the standard tests. These should all pass.

ENV DJANGO_SUPERUSER_NAME=admin
ENV DJANGO_SUPERUSER_EMAIL=admin@my.company
ENV DJANGO_SUPERUSER_PASSWORD=admin1
RUN python manage.py createsuperuser --username admin --noinput # Create a superuser

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
EXPOSE 8000
