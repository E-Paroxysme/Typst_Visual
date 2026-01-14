# Position Helper

Un package Typst interactif pour faciliter le positionnement d'éléments (annotations, barres, etc.) dans vos documents.

## Le problème

Positionner précisément une annotation sur une image ou un graphique dans Typst est souvent frustrant. Il faut deviner les coordonnées, compiler, ajuster, recompiler...

## La solution

Position Helper affiche un marqueur visuel que vous pouvez déplacer en tapant des commandes directement dans votre document. Grâce à la preview live de Typst, vous voyez le marqueur bouger en temps réel et obtenez les coordonnées exactes à copier.

## Installation

```typst
#import "src/lib.typ": position-helper
```

## Utilisation

```typst
#set page(margin: 0pt)

#show: position-helper.with(
  start-x: 50%,
  start-y: 50%,
  step: 10,
  show-grid: true,
)

// Tapez vos commandes ici:
ddddzzzz
```

## Contrôles (Layout ZQSD français)

| Touche | Action |
|--------|--------|
| `z` | Monter |
| `s` | Descendre |
| `q` | Gauche |
| `d` | Droite |
| `a` | Réduire le pas |
| `e` | Augmenter le pas |
| `r` | Reset position |

## Paramètres

| Paramètre | Type | Défaut | Description |
|-----------|------|--------|-------------|
| `start-x` | length/ratio | `50%` | Position X initiale |
| `start-y` | length/ratio | `50%` | Position Y initiale |
| `step` | integer | `10` | Pas de déplacement (en pt) |
| `marker-size` | length | `8pt` | Taille du marqueur |
| `marker-color` | color | `red` | Couleur du marqueur |
| `show-grid` | boolean | `false` | Afficher une grille de référence |
| `grid-step` | length | `50pt` | Espacement de la grille |

## Workflow

1. Insérez le position helper dans votre document
2. Tapez des commandes (ex: `dddddzzzzz`) pour déplacer le marqueur
3. Observez les coordonnées dans le panneau d'info
4. Copiez le code `place(dx: ..., dy: ..., [...])` affiché
5. Supprimez le position helper et utilisez les coordonnées pour votre élément réel

## Exemple

```typst
#import "src/lib.typ": position-helper

#set page(margin: 0pt)

// Étape 1: Trouver la position
#show: position-helper.with(show-grid: true)
ddddddddddzzzzz

// Étape 2: Une fois la position trouvée (ex: x: 150pt, y: 100pt),
// remplacez par votre contenu réel:
// #place(dx: 150pt, dy: 100pt, [Mon annotation])
```

## Licence

MIT
