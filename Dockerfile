# Étape 1 : Construction
FROM golang:1.23.2 AS builder
# Définir le répertoire de travail dans le conteneur
WORKDIR /app
# Copier le module et les fichiers go.mod et go.sum
COPY go.mod go.sum ./
# Télécharger les dépendances
RUN go mod download
# Copier le reste du code source
COPY . .
# Construire l'application
RUN go build -o DevOpsTest .

# Étape 2 : Exécution
FROM alpine:latest
# Créer un utilisateur non root pour la sécurité
RUN adduser -D arno
# Définir le répertoire de travail
WORKDIR /app
# Copier l'application depuis l'image de construction
COPY --from=builder /app/DevOpsTest .
# Changer le propriétaire du répertoire pour l'utilisateur non root
RUN chown -R arno /app
# Changer d'utilisateur pour éviter d'exécuter l'appli en tant que root
USER arno
# Exposer le port utilisé par l'application (exemple : 8080)
EXPOSE 8080

# Démarrer l'application
CMD ["./DevOpsTest"]
