# Projet Analytics ESGI

### Groupe 5IW3

- Raimbault Fantin 5IW3
- Maziarz Oliwier 5IW3
- Naderi Farid 5IW3
- Lelong Antoine 5IW3

## Prérequis

- Docker
- Docker-compose / Docker compose
- Nodejs

## Installation

Pour commencer il faut clonner ce repo.

Après l'avoir clonner on se met à la racine du projet et on clonne les 4 sous projet en effectuant la commande suivante

```bash
make clone
```

Ensuite, pour installer le projet il faut mettre dans 2 terminaux différents les commandes suivantes :

```bash
make start-back
```

```bash
make start-front -j
```

Cela va lancer 3 projets:

- Le backend nest sur le port 3000
- Le backoffice sur le port 3001
- le frontend utilisant le sdk sur le port 5173

Ces commandes vont seeds les bases de données et lancer les projets.

Les variables d'environnement sont directement inclue aux différents projets dans ce zip.

## Fonctionnement

### [Frontend](https://github.com/FantinPro/analytics_esgi)

Le frontend est un projet simple bootstrap avec vite.
Il y est installé le sdk analytics qui est relié à notre backend. (le code source se trouve dans le dossier front-sdk à la racine du zip)

Une instance y est crée avec un APP ID généré dans le seed.

Il y'a un bouton qui permet d'envoyer des events `click` au backend.

Il y'a une zone rouge dans laquelle au survol on envoie un event `mousemove` au backend.

### [Backend Nest](https://github.com/FantinPro/nest-js-analytics)

Ce backend est une API Rest qui expose différentes routes:

- on peut créer un utilisateur.
- on peut s'authentifier avec email/mdp.
- on peut créer une application ainsi qu'ajouter/supprimer des utilisateurs à l'application lorsqu'on est admin de l'application.
- on peut récupérer les heatmaps d'une application.
- enfin l'api expose une route pour y envoyer les events des applications

Toute les données à part les events sont stocké dans une base de données postgresql.
Les events sont stocké dans une base de données mongodb.

### [Backoffice](https://github.com/omaziarz/backoffice)

Le backoffice est une application next qui permet de visualiser les heatmaps des applications ainsi que de créer des nouvelles applications.

En arrivant dessus il y'a un formulaire de connexion.
Pour se connecter il faut utiliser les identifiants suivants:

- email: robert@gmail.com
- mdp: test

cet utilisateur possède directement une application qui est parametrée pour être utilisée par le frontend pour envoyer des events.

Il y'a deux onglets:

- Dashboard: permet de voir les heatmaps des applications. Elles ne sont pas en temps réél il faut donc refresh pour voir des changements.
- Applications: permet de créer des applications.

## [Le SDK Front](https://github.com/omaziarz/esgi-sdk-front)

Le SDK front est un package qui exporte une instance de la classe Analytics.
Cette classe gére l'envoie des events et la configuration de l'APP ID.
Le SDK export aussi quelque hook React permettant de plugger facilement le SDK dans un projet React. Ces hooks utilisent les méthodes de la classe Analytics.

Ce qui est exposé par le package:

- ESGIAnalytics: instance de la classe Analytics qui
  expose les différentes méthodes

```ts
- register(applicationId: string, labelService: string, opt?: AnalyticsOptions
) // configuration du sdk

- handleActiveUser() // permet de refresh l'expiration de la session utilisateur

- sendAnalyticsEvent(events: TrackerEvent[]) // permet d'envoyer une liste d'events


// le sdk utilise ces types

type TrackerEvent = {
  timestamp: number;
  dimensions?: {
    route?: string;
    resolution?: {
      width: number;
      height: number;
    };
    tag?: string;
    event?: string;
    meta?: Record<string, any>;
    [key: string]: any;
  };
};

type AnalyticsOptions = {
  afk?: number;
};
```

- Le SDK export aussi des hooks React

```tsx
interface TrackerParams {
  tag: string; // to register for backend app
  event: "click";
}

- function useTracker<T>({ tag, event }: TrackerParams): Ref<T> // track les clics

- function useMouseTracker<T>(): Ref<T> // track les mouvements de souris

- function useRouterMiddleware() // track les changements de route

// Ces hooks sont tous utilisés dans le projet frontend
```
