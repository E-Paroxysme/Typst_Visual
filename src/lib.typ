// Position Helper - Package Typst pour faciliter le positionnement d'éléments
// Auteur: E-Paroxysme
// Licence: MIT

/// Parse les caractères de commande depuis le contenu
#let parse-commands(body) = {
  let text-content = if type(body) == str {
    body
  } else {
    let result = ""
    for child in body.children {
      if child.has("text") {
        result += child.text
      }
    }
    result
  }
  text-content.clusters().map(c => lower(c))
}

/// Fonction principale du position helper
///
/// Contrôles (layout ZQSD français):
/// - z : monter
/// - s : descendre
/// - q : gauche
/// - d : droite
/// - a : diminuer le pas
/// - e : augmenter le pas
/// - r : reset position au centre
///
/// Paramètres:
/// - start-x : position X initiale (défaut: 50%)
/// - start-y : position Y initiale (défaut: 50%)
/// - step : pas de déplacement initial en pt (défaut: 10)
/// - marker-size : taille du marqueur (défaut: 8pt)
/// - marker-color : couleur du marqueur (défaut: red)
/// - show-grid : afficher une grille de fond (défaut: false)
/// - grid-step : pas de la grille (défaut: 50pt)
#let position-helper(
  start-x: 50%,
  start-y: 50%,
  step: 10,
  marker-size: 8pt,
  marker-color: red,
  show-grid: false,
  grid-step: 50pt,
  body
) = {
  // Parser les commandes
  let commands = parse-commands(body)

  // État initial
  let pos-x = if type(start-x) == ratio {
    // Convertir le pourcentage en pt (basé sur A4 width = 595pt)
    595pt * (start-x / 100%)
  } else {
    start-x
  }

  let pos-y = if type(start-y) == ratio {
    // Convertir le pourcentage en pt (basé sur A4 height = 842pt)
    842pt * (start-y / 100%)
  } else {
    start-y
  }

  let current-step = step

  // Position initiale pour reset
  let init-x = pos-x
  let init-y = pos-y

  // Traiter chaque commande
  for cmd in commands {
    if cmd == "z" {
      // Monter (Y diminue car origine en haut)
      pos-y = pos-y - current-step * 1pt
    } else if cmd == "s" {
      // Descendre
      pos-y = pos-y + current-step * 1pt
    } else if cmd == "q" {
      // Gauche
      pos-x = pos-x - current-step * 1pt
    } else if cmd == "d" {
      // Droite
      pos-x = pos-x + current-step * 1pt
    } else if cmd == "a" {
      // Diminuer le pas (minimum 1)
      current-step = calc.max(1, current-step - 1)
    } else if cmd == "e" {
      // Augmenter le pas
      current-step = current-step + 1
    } else if cmd == "r" {
      // Reset position
      pos-x = init-x
      pos-y = init-y
      current-step = step
    }
  }

  // S'assurer que les positions restent positives
  pos-x = calc.max(0pt, pos-x)
  pos-y = calc.max(0pt, pos-y)

  // Affichage
  block(width: 100%, height: 100%, {
    // Grille optionnelle
    if show-grid {
      place(
        top + left,
        {
          let grid-color = luma(200)
          // Lignes verticales
          for x in range(0, 13) {
            let xpos = x * grid-step
            place(
              dx: xpos,
              dy: 0pt,
              line(
                start: (0pt, 0pt),
                end: (0pt, 842pt),
                stroke: 0.5pt + grid-color
              )
            )
            // Labels X
            place(
              dx: xpos + 2pt,
              dy: 2pt,
              text(size: 6pt, fill: grid-color)[#xpos]
            )
          }
          // Lignes horizontales
          for y in range(0, 18) {
            let ypos = y * grid-step
            place(
              dx: 0pt,
              dy: ypos,
              line(
                start: (0pt, 0pt),
                end: (595pt, 0pt),
                stroke: 0.5pt + grid-color
              )
            )
            // Labels Y
            place(
              dx: 2pt,
              dy: ypos + 2pt,
              text(size: 6pt, fill: grid-color)[#ypos]
            )
          }
        }
      )
    }

    // Marqueur (point rouge)
    place(
      top + left,
      dx: pos-x - marker-size / 2,
      dy: pos-y - marker-size / 2,
      {
        circle(
          radius: marker-size / 2,
          fill: marker-color,
          stroke: 1pt + marker-color.darken(30%)
        )
      }
    )

    // Croix de visée
    place(
      top + left,
      dx: pos-x,
      dy: pos-y - marker-size,
      line(
        start: (0pt, 0pt),
        end: (0pt, marker-size * 2),
        stroke: 0.5pt + marker-color
      )
    )
    place(
      top + left,
      dx: pos-x - marker-size,
      dy: pos-y,
      line(
        start: (0pt, 0pt),
        end: (marker-size * 2, 0pt),
        stroke: 0.5pt + marker-color
      )
    )

    // Panneau d'information
    place(
      top + left,
      dx: 10pt,
      dy: 10pt,
      block(
        fill: white.transparentize(20%),
        stroke: 1pt + luma(100),
        inset: 8pt,
        radius: 4pt,
        [
          #set text(size: 10pt, font: "DejaVu Sans Mono")
          #strong[Position Helper]

          #v(4pt)

          #grid(
            columns: (auto, auto),
            gutter: 8pt,
            [*X:*], [#calc.round(pos-x.pt(), digits: 1)pt],
            [*Y:*], [#calc.round(pos-y.pt(), digits: 1)pt],
            [*Pas:*], [#current-step pt],
          )

          #v(4pt)
          #line(length: 100%, stroke: 0.5pt + luma(150))
          #v(4pt)

          #set text(size: 8pt)
          *Contrôles:*\
          ZQSD: déplacer\
          A/E: pas -/+\
          R: reset

          #v(4pt)
          #line(length: 100%, stroke: 0.5pt + luma(150))
          #v(4pt)

          #set text(size: 9pt)
          *Code à copier:*\
          #raw("place(dx: " + str(calc.round(pos-x.pt(), digits: 1)) + "pt, dy: " + str(calc.round(pos-y.pt(), digits: 1)) + "pt, [...])")
        ]
      )
    )
  })
}
