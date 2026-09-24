// Les quatre styles de cadre, chacun avec tous les éléments du filet : clé,
// haltère, source, facultatif, titre très long, bloc Automatismes.
#import "../../src/lib.typ": *
#set page(height: auto)
#for style in ("etiquette-encadree", "fond-blanc", "bandeau", "etiquette-pleine") [
  #maquette(style-exercice: style, localisation-correction: "apres", couleur-obligatoire: navy)[
    #thematique[Style #raw(style)]
    #exercice(titre: "Tout", entrainement: "https://a.b", source: "Manuel p. 12")[A] #solution[a]
    #exercice(obligatoire: false, entrainement: "https://c.d")[B] #solution[b]
    #exercice(titre: "Un titre très long qui doit passer à la ligne dans son étiquette sans sortir du cadre de l'exercice")[C]
  ]
]
