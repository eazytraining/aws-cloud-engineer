Voici une explication détaillée de la configuration de la tâche ECS (Elastic Container Service) pour WordPress :

## Définition de la tâche

- `family` : Le nom de la définition de tâche, ici "wordpress-front".
- `containerDefinitions` : Définit les conteneurs qui composent la tâche.

## Définition du conteneur

- `name` : Le nom du conteneur, ici "wordpress-front".
- `image` : L'image Docker utilisée pour le conteneur, ici "wordpress:6.5.5-php8.1-apache".
- `cpu` : La quantité de CPU allouée au conteneur, ici 0 (illimité).
- `portMappings` : Mappe le port 80 du conteneur au port 80 de l'hôte en utilisant le protocole TCP.
- `essential` : Indique que ce conteneur est essentiel pour le bon fonctionnement de la tâche.
- `user` : Spécifie l'utilisateur qui exécute le conteneur, ici "root".
- `environment` : Définit les variables d'environnement pour le conteneur :
  - `ECS_RESERVED_MEMORY` : Réserve 100 Mo de mémoire pour le conteneur.
  - `WORDPRESS_DB_HOST` : L'hôte de la base de données, ici un proxy RDS.
  - `WORDPRESS_DB_NAME` : Le nom de la base de données WordPress.
  - `PHP_MEMORY_LIMIT` : La limite de mémoire PHP, ici 512 Mo.
- `mountPoints` : Monte le volume "efs-wordpress-volume" dans le répertoire "/bitnami/wordpress" du conteneur.
- `secrets` : Récupère les secrets pour l'utilisateur et le mot de passe de la base de données à partir d'AWS Secrets Manager.
- `logConfiguration` : Configure la journalisation des logs du conteneur avec le pilote "awslogs" et les options appropriées.

## Volumes

- `volumes` : Définit un volume nommé "efs-wordpress-volume" utilisant Amazon EFS (Elastic File System) :
  - `fileSystemId` : L'ID du système de fichiers EFS.
  - `rootDirectory` : Le répertoire racine du volume, ici "/".
  - `transitEncryption` : Active le chiffrement en transit pour le volume EFS.
  - `authorizationConfig` : Configure l'autorisation d'accès au volume EFS :
    - `accessPointId` : L'ID du point d'accès EFS.
    - `iam` : Désactive l'authentification IAM pour le point d'accès.

## Autres paramètres

- `executionRoleArn` : L'ARN (Amazon Resource Name) du rôle d'exécution de la tâche.
- `networkMode` : Le mode réseau utilisé par la tâche, ici "awsvpc".
- `requiresCompatibilities` : Les types de lancement compatibles avec la tâche, ici "FARGATE".
- `cpu` : La quantité de CPU allouée à la tâche, ici 1024 (1 vCPU).
- `memory` : La quantité de mémoire allouée à la tâche, ici 2048 Mo (2 Go).
- `tags` : Ajoute une étiquette "Name" avec la valeur "wordpress-prod-task-front" à la tâche.

Cette configuration permet de déployer un conteneur WordPress sur AWS Fargate, en utilisant un volume EFS pour stocker les fichiers WordPress, en se connectant à une base de données via un proxy RDS, et en utilisant des secrets pour les informations d'identification de la base de données.
