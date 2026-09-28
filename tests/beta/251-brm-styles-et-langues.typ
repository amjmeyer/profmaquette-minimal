// Les quatre styles, chacun dans une langue (de, es, it, en).
#import "../../src/lib.typ": *
#for (style, langue) in (("fond-blanc", "de"), ("etiquette-encadree", "es"), ("bandeau", "it"), ("etiquette-pleine", "en")) {
  maquette(mode-maquette: "interro", afficher-brm: "complet", style-exercice: style, langue: langue)[
    #exercice(brm: (1, 1.5, 2.5))[
      + A
      + B
      + C
    ]
  ]
}
