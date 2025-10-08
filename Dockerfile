FROM python:3.9-alpine3.13
LABEL maintainer="vainqueur"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false

#FROM python:3.9-alpine3.13 → dit à Docker d’utiliser une image Python légère (Alpine) comme base.
 #
 #LABEL maintainer="vainqueur" → indique qui a créé ou maintient l’image.
 #
 #ENV PYTHONUNBUFFERED 1 → empêche le buffering de Python pour que les logs s’affichent directement dans le terminal.
 #
 #COPY ./requirements.txt /tmp/requirements.txt → copie le fichier des dépendances dans le conteneur.
 #
 #COPY ./app /app → copie le code de ton application dans le dossier /app du conteneur.
 #
 #WORKDIR /app → définit /app comme dossier de travail par défaut.
 #
 #EXPOSE 8000 → indique que le conteneur utilisera le port 8000 (souvent pour un serveur web).

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ "$DEV" = "true" ]; then \
        /py/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user


ENV PATH="/py/bin:$PATH"

USER django-user


#RUN python -m venv /py → crée un environnement virtuel Python dans le dossier /py.
 #
 #/py/bin/pip install --upgrade pip → met à jour pip dans cet environnement.
 #
 #/py/bin/pip install -r /tmp/requirements.txt → installe toutes les dépendances listées dans requirements.txt.
 #
 #rm -rf /tmp → supprime le dossier temporaire pour alléger l’image.
 #
 #adduser --disabled-password --no-create-home django-user → crée un utilisateur django-user sans mot de passe et sans dossier personnel.
 #
 #ENV PATH="/py/bin:$PATH" → ajoute le dossier de l’environnement virtuel au chemin pour utiliser Python et pip plus facilement.
 #
 #USER django-user → fait tourner l’application avec un utilisateur non-root (plus sécurisé).


