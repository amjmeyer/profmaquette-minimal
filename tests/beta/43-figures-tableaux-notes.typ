#import "../../src/lib.typ": *
#maquette(afficher-corrige: "apres")[
  #exercice(titre: "Figure")[
    #figure(rect(width: 3cm, height: 1cm), caption: [Une figure])
    #table(columns: 3, [a], [b], [c], [1], [2], [3])
    Une note#footnote[Note de bas de page dans un exercice.].
    #place(top + right, float: true, rect(width: 1cm, height: 1cm, fill: red))
  ]
  #solution[#figure(rect(width: 2cm, height: 5mm), caption: [Figure du corrigé])]
]
