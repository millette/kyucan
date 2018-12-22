# Kyucan

> Qui, où, quand? Telle est la question.

## Installation

```sh
git clone https://github.com/millette/kyucan.git
cd kyucan
npm install
npm start # mode dev, CTRL-C pour quitter
npm run build # générer la version de production dans dist/
```

## Structure du code

Un tout petit fichier html (avec un link stylesheet sur du scss (SASS), au lieu du css et parcel s'arrange pour compilé le scss et remplace le lien par du css:
https://github.com/millette/kyucan/blob/master/index.html

Le style lui-même est dérivé de bulma:
https://github.com/millette/kyucan/blob/master/css/style.scss

Le fichier JS principal est tout petit, il charge riot et les tags que j'ai écrit pour mon application. Remarque le les imports des tags n'assignent pas de noms, mais rend les tags disponibles (merci Parcel):
https://github.com/millette/kyucan/blob/master/js/main.js

Enfin les tags sont ici:
https://github.com/millette/kyucan/tree/master/tags

Dans le html, on charge le tag <app> qu'on trouve ici, tout petit:
https://github.com/millette/kyucan/blob/master/tags/app.tag

Le hero tag (header) ressemble plus à du html:
https://github.com/millette/kyucan/blob/master/tags/hero.tag

À l'autre extrème, le tag le plus compliqué qui contient du html, js et style:
https://github.com/millette/kyucan/blob/master/tags/form.tag

## Crédits

- [Riot.js](https://riot.js.org/) Bibliothèque _front-end_
- [Bulma](https://bulma.io/) Bibliothèque CSS
- [Parcel](https://parceljs.org/) Empaqueteur d'application web ultra-rapide, sans configuration
- [Prettier](https://prettier.io/) Reformatteur de code source

## License

AGPL-v3 © 2018 [Robin Millette](http://robin.millette.info)
