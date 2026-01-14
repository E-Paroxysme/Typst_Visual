# Position Helper

Un package Typst interactif pour faciliter le positionnement d'éléments (annotations, barres, etc.) dans vos documents.

## Le problème

Positionner précisément une annotation sur une image ou un graphique dans Typst est souvent frustrant. Il faut deviner les coordonnées, compiler, ajuster, recompiler...

## La solution

Position Helper affiche un marqueur visuel que vous pouvez déplacer en tapant des commandes. Grâce à la preview live de Typst, vous voyez le marqueur bouger en temps réel et obtenez les coordonnées exactes à utiliser avec `place()`.

## Installation

### Package local

```bash
# Créer le dossier
mkdir -p ~/.local/share/typst/packages/local/position-helper/0.1.0

# Copier les fichiers
cp -r src typst.toml ~/.local/share/typst/packages/local/position-helper/0.1.0/
```

Puis dans vos documents :
```typst
#import "@local/position-helper:0.1.0": ph
```

### Utilisation directe

Si vous travaillez dans le dossier du projet :
```typst
#import "src/lib.typ": ph
```

## Utilisation

```typst
#import "@local/position-helper:0.1.0": ph

#show: ph("ddddzzzz")

// Votre contenu normal
= Mon titre
#image("mon-image.png")
```

Le marqueur rouge se superpose à votre contenu. Modifiez la chaîne de commandes pour le déplacer.

## Contrôles (Layout ZQSD)

| Touche | Action |
|--------|--------|
| `z` | Monter |
| `s` | Descendre |
| `q` | Gauche |
| `d` | Droite |
| `a` | Réduire le pas (-1pt) |
| `e` | Augmenter le pas (+1pt) |
| `r` | Reset position |

## Paramètres

| Paramètre | Type | Défaut | Description |
|-----------|------|--------|-------------|
| `commands` | string | `""` | Chaîne de commandes (zqsd...) |
| `start-x` | length | `297.5pt` | Position X initiale |
| `start-y` | length | `421pt` | Position Y initiale |
| `step` | integer | `10` | Pas de déplacement (en pt) |
| `marker-size` | length | `8pt` | Taille du marqueur |
| `marker-color` | color | `red` | Couleur du marqueur |
| `show-grid` | boolean | `false` | Afficher une grille de référence |
| `grid-step` | length | `50pt` | Espacement de la grille |
| `margin` | length | `2.5cm` | Marge de la page (pour le calcul des coordonnées) |

## Workflow

1. Ajoutez `#show: ph("")` en haut de votre document
2. Tapez des commandes dans la chaîne (ex: `"ddddzzzz"`)
3. Observez le marqueur se déplacer dans la preview
4. Notez les coordonnées X et Y affichées
5. Utilisez ces coordonnées avec `place()` :

```typst
#place(
  top + left,
  dx: 150pt,
  dy: 80pt,
  [Mon annotation]
)
```

6. Supprimez la ligne `#show: ph(...)` quand vous avez terminé

## Exemples

### Basique

```typst
#import "@local/position-helper:0.1.0": ph

#show: ph("ddddddddddssssssssss")

= Mon Document
#lorem(100)
```

### Avec grille

```typst
#show: ph("dddddddddd", show-grid: true)
```

### Marges personnalisées

Si votre document utilise des marges différentes de 2.5cm :

```typst
#set page(margin: 1cm)
#show: ph("dddddddddd", margin: 1cm)
```

### Position de départ personnalisée

```typst
#show: ph("", start-x: 100pt, start-y: 100pt)
```

## Demonstration :
https://github.com/E-Paroxysme/Typst_Visual/blob/Version_ok/Video/Video_demo-ezgif.com-video-to-gif-converter.gif

## Licence

MIT
