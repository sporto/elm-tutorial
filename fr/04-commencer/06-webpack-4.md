> Cette page couvre Elm 0.18

# Webpack 4

## package.json

Pour finir, ajoutons quelques scripts npm, pour pouvoir lancer nos serveurs facilement. Dans __package.json__, remplacez la clef `scripts` par :

```json
"scripts": {
    "api": "node api.js",
    "build": "webpack",
    "watch": "webpack --watch",
    "dev": "webpack-dev-server --port 3000"
},
```

Désormais :
- `npm run api` va lancer noter faux serveur
- `npm run build` va créer un *build* webpack et mettre les *bundles* dans `dist`
- `npm run watch` exécute le *watcher* de Webpack, qui ajoute les *bundles* dans `dist` à chaque fois que l'on change le code
- `npm run dev` exécute le serveur de développement de Webpack.

## Node Foreman

Nous avons deux serveurs à lancer pour travailler : l'Api et le Frontend. Nous allons devoir lancer les deux à la main pour tester notre application. Ce n'est pas un problème en soi, mais il existe une meilleure façon de faire.

Installez Node Foreman:

```
npm install -g foreman
```

Ensuite créez un fichier appelé `Procfile` à la racine du projet contenant :

```
api: npm run api
client: npm run dev
```

Nous avons maintenant à notre disposition une commande appelée `nf` qui va nous permettre de lancer les deux serveurs en même temps.

## Test

Testons notre configuration ! Dans un terminal, exécutez :

```bash
nf start
```

Si vous allez sur `http://localhost:3000/`, vous devriez voir notre application, qui affiche "Hello". Utilisez `Ctrl-c` pour arrêter les serveurs.

Le code de votre application devrait correspondre à cela : <https://github.com/sporto/elm-tutorial-app/tree/02-webpack>.
