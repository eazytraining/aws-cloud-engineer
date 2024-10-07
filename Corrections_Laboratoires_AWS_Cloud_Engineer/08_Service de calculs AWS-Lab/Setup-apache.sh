#!/bin/bash

# Mise à jour des paquets
sudo apt-get update -y

# Installation d'Apache
sudo apt-get install apache2 -y

# Activation du service Apache pour démarrer au démarrage du système
sudo systemctl enable apache2

# Démarrage du service Apache
sudo systemctl start apache2

# Création d'une page HTML simple
echo "<!DOCTYPE html>
<html>
<head>
    <title>Page de bienvenue</title>
</head>
<body>
    <h1>Hello</h1>
</body>
</html>" | sudo tee /var/www/html/index.html

# Réinitialisation d'Apache pour prendre en compte les modifications
sudo systemctl restart apache2

echo "Installation terminée. Visitez l'IP publique de votre instance EC2 pour voir la page 'Hello welcome to our BootCamp AWS Cloud Engineer'."
