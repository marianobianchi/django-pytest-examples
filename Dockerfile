FROM python:2-slim

LABEL maintainer="marianobianchi08@gmail.com"

# Definir uid y gid custom. Por defecto se asigna 1000:1000
ARG UID=1000
ARG GID=1000
ARG APPPATH=/var/www/django-pytest
ARG USERNAME=djangouser


# Create a user so our program doesn't run as root.
RUN groupadd -r ${USERNAME} -g ${GID} &&\
    useradd -r -g ${USERNAME} -u ${UID} -d /home/${USERNAME} -s /sbin/nologin -c "Docker image user" ${USERNAME}


# Crear carpeta del proyecto
RUN mkdir -p ${APPPATH}


# Asigno los permisos para el usuario
RUN chown -R ${USERNAME}:${USERNAME} ${APPPATH}


# Cambio de directorio
WORKDIR ${APPPATH}


# Instalo los requirements
RUN pip install \
        "Django==1.8" \
        pytest \
        pytest-bdd \
        pytest-django


VOLUME ${APPPATH}
EXPOSE 8000

USER ${USERNAME}

CMD ["/sbin/init"]
