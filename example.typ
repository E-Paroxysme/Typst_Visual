// Exemple d'utilisation du Position Helper
#import "src/lib.typ": position-helper

// Active le helper en overlay - modifie "commands" pour déplacer le point
#show: position-helper.with(
  commands: "ddddddddddzzzzzzzzzz",  // ← TAPE ICI pour déplacer
  show-grid: true,
)

// === TON CONTENU NORMAL EN DESSOUS ===

= Mon Document

Voici un paragraphe de texte normal. Le point rouge se superpose par-dessus.

#lorem(50)

#figure(
  rect(width: 200pt, height: 150pt, fill: blue.lighten(80%))[
    #align(center + horizon)[Image placeholder]
  ],
  caption: [Une figure exemple]
)

#lorem(30)
