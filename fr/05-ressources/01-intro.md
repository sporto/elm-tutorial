# La ressource Joueurs

Nous allons structurer notre application par nom de ressource. Dans cette application, nous n'avons qu'une seule ressource, les joueurs (`Players`), donc nous n'allons créer qu'un répertoire `Players`.

Ce répertoire contiendra plusieurs modules, un par composant, comme le répertoire du niveau principal :

- Players/Messages.elm
- Players/Models.elm
- Players/Update.elm

Par contre, nous aurons des vues différentes pour les joueurs : la liste, et l'édition. Chaque vue aura son propre module Elm :

- Players/List.elm
- Players/Edit.elm

