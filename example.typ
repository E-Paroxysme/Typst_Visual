// Exemple d'utilisation du Position Helper
#import "src/lib.typ": position-helper

#set page(width: 595pt, height: 842pt, margin: 0pt)

// Mode 1: Sans grille, position de départ au centre
// Tapez des caractères pour déplacer le point:
// - z: haut, s: bas, q: gauche, d: droite
// - a: réduire le pas, e: augmenter le pas
// - r: reset

#show: position-helper.with(
  start-x: 50%,
  start-y: 50%,
  step: 10,
  marker-color: red,
  show-grid: true,  // Activer la grille pour mieux se repérer
)

// Tapez vos commandes ici (effacez ce texte et tapez):
// Exemple: "dddddzzzzz" déplace le point de 50pt à droite et 50pt vers le haut

