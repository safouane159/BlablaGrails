![Logo of the project](https://s3.eu-west-3.amazonaws.com/blablagrails/illustration/logo-white.png)

# Blbabla Grails
> Des millions de petites annonces et autant d’occasions de se faire plaisir


Cette application est dévolopé pour repondre au cahier de charge fonctionel : https://github.com/Master-2-MIAGE-MBDS/grails-lecoincoin-blabla-grails/edit/main/todo.md

### Choix de Stack : 

Framework : Grails.<br />
Back-end  : Groovy.<br />
Front-end : HTML5/css/Javascript.<br />
Base de données : Postgree.<br />
Deployement: Heroku plateforme.<br />
Stockage fichiers : Cloud AWS s3.<br />


**Cette application est développé par  **

| **Nom / mail**                               |  **Qualité / rôle**        |
|----------------------------------------------|----------------------------|
| SAMIA Oussama / oussamasamia1@gmail.com      | Développeur                |
| OUAZRI Safouane / safouane1ouazri@gmail.com  | Développeur                |

#

Table des matières




[1. Prise en main](#PriseenMain)

[1.1. Lancer l'application en local](#Local )

[1.2. Déployer sur héroku](#héroku)

[2.  Conception de l'application](#Conception)

[1.2. Acteurs et roles](#Acteurs)

[1.2. Composents](#Composents)

[1.2. Domain](#Domain)

[3. Features (Google map api) ](#features (Google map api))

[4. déploiement (heroku)  ](#déploiement (heroku))

[5. Cloud AWS s3  ](#Cloud-AWS-s3)

[6.  Api REST  ](#Api-REST)

[7. Fonctionalité reste à faire   ](#Fonctionalité-reste-à-faire )

[8. Links  ](#Links)

[9. Licensing   ](#FLicensing)
 

## 1. Prise en main 

### 1.1. Lancer l'application en local : 

La configuration minimale dont vous avez besoin pour exécuter l'application en local

```shell
git clone https://github.com/Master-2-MIAGE-MBDS/grails-lecoincoin-blabla-grails.git
cd grails-lecoincoin-blabla-grails
grails run-app
```

Vous pouvez trouvez l'application sur http://localhost:8081/ 

### 1.2. Déployer sur héroku : 


```shell
 heroku create --stack cedar
 git push heroku main
 
```
Vous trouverez votre application sur un lien comme ceci "http://app-name.herokuapp.com". 

Note :vous devez changer "app-name" avec le lien qui apparait dans le console aprés l'exécution de git push heroku main. 




## 2 Conception de l'application

### 2.1. les Acteurs et roles

Notre application sera interoger par 3 type de utilisateur avec 2 type de role:  

| type Acteur                     |  rôle                |
|---------------------------------|----------------------|
| Admin                           | ROLE_ADMIN           |
| Client authentifié              | ROLE_CLIENT          |
| Client non-authentifié          | Aucun                |

![useCase](/useCase.png)

### 2.2. Composents 

Notre application suit l'architecture Domain-view-controller. 
![useCase](/systemDesign2.png)

#### 2.3. Domaines : 

domaine User : <br />
    - username : idetifiant de l'utilisateur. <br />
    - password : le mot de passe. <br />
    - nomComplet : nom complet de l'itulisateur. <br />
    - enabled: (true ou false). <br />
    - tel : numero de telephone. <br />
    - mail : le mail. <br />
    - aboutme : brief description sur l'utilisateur. <br />
    - Role : le Role. <br />
    - annonces : list des annonces. <br />
    
domaine annonce : <br />
    - title : le titre de l'annonce. <br />
    - description : la description de l'annonce. <br />
    - address : l'address. <br />
    - price : le prix. <br />
    - active = Boolean.FALSE. <br />
    - lng : latiture. <br />
    - lat : longitude. <br />
    - dateCreated : date de creation. <br />
    - autheur : le vendeur. <br />
    - illustrations : la list des illustration. <br />
    
    
 domaine Illustration : <br />
    - filename : nom de fichier. <br />
    - annonce : l'annone auquel elle appartient. <br />
    
## 3. Features (Google map api)  
   
Nous avons ajouté une fonctionnalité qui vous permet d'interroger l'API de Google Map pour obtenir des données de localisation pour une annonce.<br />

![useCase](/map.png)

En tapant just la ville, le javascript renvoi les coordonnées dans des inpurt de type "hidden" qui sont aprés persisté dans la table de l'annonce.<br />



## 4. Déploiement (heroku)

Afin de déployer notre application sur heroku nous avons:<br />

1- déclarer quelles commandes qui seront exécutées par les conteneurs de heroku:<br />

Procfile:<br />

```shell
web: java  -Dserver.port=$PORT $JAVA_OPTS -jar build/libs/mbds_grails_22_23-0.1.war
```

2- Switcher vers la base de données Posrgres :<br />
   * Changer les parametres de la base de données dans l'envirennement de production .<br />
   * crée Add-ons postgres sur heroku. <br />
   * configurer les informations d'identification et l'URL de connexion pour le PostgreSQL.<br />
  

3- Deployer la branche main

## 5. Cloud AWS s3


Puisque heroku ne permet pas de stocker des fichiers dans son systeme de fichier nous avons choisi di'utilisé le service de Amazon s3.<br />

1- Nous avons crée un compte sur Amazon pour pouvoir utiliser leurs services. nous avons obtenu un access_token et secret_key de notre compte propriétaire qui est utilisé pour l'authentification pour consommer les services Amazon via n'importe quel appel API. <br />

2- Nous avons ajouté une ligne dans le bloc « dependency » pour récupérer le SDK AWS : <br />
```shell
compile ‘com.amazonaws:aws-java-sdk-s3:1.10.8’
```

3- Nous avons implementer une class "MyPictureWritter" qui conient deux main methods : <br />
    * wrtieAwS qui prends comme parametre le fichier en base64 (String), Stock le fichier dans aws cloud  et retourne le nom de fichier (string).<br />
    * deleteFile qui prends comme parametre le fichier ( string) , suprime le fichier dans aws, retourne rien. <br />

4- Nous avons ajouté les identifiants de notre compte aws dans heroku pour données la permission a l'application d'ecrire et lire depuis notre bucket.<br />


## 6. Api REST



Comme expliqué dans la paragraph 2.2. nous avons exposé une api REST qui permet de faire des opertions crud sur les tables (user, annonce, illustration(à l'interieur de annonce)).<br />

la documentation détaillée de l'API est disponible dans ce lien: https://documenter.getpostman.com/view/6206844/2s83zpJg3B <br />

Vous trouvez la collection (.json) prête à être importé dans POSTman dans ce repositorie. <br />


## 7. Fonctionalités reste à faire 


les fonctionnalité que nous avons prévu a faire mais malheureusement nous avons pas pu les faire: <br />

   * filtrage dtailler sur les les annonces part : type, prix, localisation.. etc. <br />
   * Envoi des messages entre utilisateur  <br />
   * Chatboot <br />



## 8. Links

Liens important: 

- app : https://blablagrails.herokuapp.com/ <br />
- git Repositorie : https://your.github.com/awesome-project/ <br />
- Repository: https://github.com/your/awesome-project/ <br />
- Documentation Api REST: https://github.com/your/awesome-project/ <br />





## 9. Licensing
Le code de ce projet est sous licence université cote d'azur.
