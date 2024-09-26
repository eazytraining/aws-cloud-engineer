# Note de cours du 09-08-2024-BootCamp AWS Cloud Engineer-Session

# Premier points sur AWS IAM et la gestion des utilisateurs

- premier Lab creation d'un utilidateur IAM, groupe, association des permissions et ajout des utilisateurs au groupe duree 20 minutes
-Demo duree 15 minutes


# Phase questions/reponses sur le cours duree 20 minutes

- KMS Multi -region

AWS KMS prend en charge les clés multirégionales, qui sont AWS KMS keys différentes Régions AWS et peuvent être utilisées de manière interchangeable, comme si vous aviez la même clé dans plusieurs régions. Chaque ensemble de clés multirégionales associées possède le même contenu clé et le même identifiant de clé. Vous pouvez donc chiffrer les données dans une clé Région AWS et les déchiffrer dans une autre Région AWS sans les chiffrer à nouveau ni effectuer un appel interrégional. AWS KMS Comme toutes les clés KMS, les clés multirégionales ne sont jamais AWS KMS déchiffrées. Vous pouvez créer des clés multirégionales symétriques ou asymétriques pour le chiffrement ou la signature.

Avanatages:
- Reprise après sinistre
les clés multirégionales vous permettent de traiter les données chiffrées sans interruption, même en cas de Région AWS panne. Les données conservées dans les régions de sauvegarde peuvent être déchiffrées dans la région de sauvegarde, et les données nouvellement chiffrées dans la région de sauvegarde peuvent être déchiffrées dans la région principale lorsque cette région est restaurée.

- Gestion globale des donneees
Les entreprises qui opèrent à l'échelle mondiale ont besoin de données distribuées dans le monde entier et qui soient disponibles entre les Régions AWS. Vous pouvez créer des clés multi-région dans toutes les régions où résident vos données, puis utiliser les clés comme s'il s'agissait d'une clé à région
- applications de signatures distribuees
- Application active/active ccouvrant plusieurs regions

-AWS Secret Manager-partage entre les comptes

Création d'un secret dans le compte source:
Créez un secret dans le compte AWS source en utilisant AWS Secrets Manager. Vous pouvez le faire via la console AWS, AWS CLI ou SDK.
Accorder des permissions d'accès au secret:
Utilisez les politiques de ressource basées sur des secrets pour accorder l'accès au secret à un autre compte AWS.
Voici un exemple de politique JSON que vous pouvez attacher à votre secret pour accorder l'accès de lecture (GetSecretValue) à un autre compte AWS :
Accéder au secret dans le compte destinataire:
Dans le compte AWS destinataire, créez une politique IAM pour permettre aux utilisateurs ou rôles IAM d'accéder au secret partagé.
Accéder au secret via AWS CLI ou SDK:
Les utilisateurs ou rôles dans le compte destinataire peuvent désormais accéder au secret partagé en utilisant AWS CLI ou SDK.
Considérations de Sécurité
Principaux d'Accès: Limitez les principaux (utilisateurs ou rôles IAM) dans le compte destinataire ayant accès aux secrets.
Politique de Rotation: Configurez la rotation automatique des secrets pour améliorer la sécurité.
Journalisation et Surveillance: Utilisez AWS CloudTrail pour surveiller l'accès aux secrets et les activités associées.
Scénarios d'Utilisation
Environnements Multi-Comptes: Dans des architectures où les applications et services sont répartis sur plusieurs comptes AWS, le partage de secrets permet une gestion centralisée et sécurisée des informations sensibles.
Déploiements Inter-Organisationnels: Partagez des secrets entre différentes unités organisationnelles ou équipes ayant des comptes AWS séparés.

# questions supplementaires 5 minutes et mot de fin.



