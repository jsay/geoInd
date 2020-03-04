---
title: "Déterminants biophysiques des AOC viticoles, Construction des données et modélisation"
author: |
  | Jean-Sauveur Ay et Mohamed Hilal
  | UMR CESAER, AgroSup, INRA, Université Bourgogne Franche-Comté
output: word_document
---

# Résumé

<div class="abstract">
Cet article présente la construction d'une base de données parcellaire
pour analyser les relations entre les caractéristiques biophysiques
(topographie, géologie, pédologie), les caractéristiques
administratives (commune d'appartenance) et les appellations d'origine
contrôlée (AOC) viticoles.  Pour les 31 communes qui forment la côte
de Beaune et la côte de Nuits, les données mettent en évidence une
relation forte entre les caractéristiques biophysiques des parcelles
et leur position dans la hiérarchie des AOC.  La relation apparaît
toutefois différenciée selon l'appartenance administrative des
parcelles, ce qui révèle des traitements hétérogènes dans les AOC.
Les prédictions issues de l'analyse permettent également de
positionner chaque parcelle sur une échelle continue de qualité à
partir des seuls attributs biophysiques.  Les données, modèles et
prédictions sont disponibles sous licence GNU GPL V3 sur le serveur
[https://data.inra.fr/](https://data.inra.fr/dataset.xhtml?persistentId=doi:10.15454/ZZWQMN) et sont consultables par une application
hébergée à l'url [https://cesaer-datas.inra.fr/geoind/](https://cesaer-datas.inra.fr/geoind).
Les&nbsp;codes `R` sont également fournis pour reproduire
l'intégralité des résultats de cette recherche.  

**Mots-clés**: Économie viti-vinicole ; histoire des appellations
d'origine contrôlée ; signes de qualité ; recherche reproductible ;
système d'information géographique ; modélisation économétrique.

</div>


# Introduction

Les appellations d'origine contrôlée (AOC) viticoles de Bourgogne
résultent de processus historiques complexes au cours desquels les
parcelles ont été classifiées selon leurs caractéristiques
biophysiques et selon les rapports économiques, politiques et
sociaux en vigueur <sup id="121170804c03a6ffd9b6598b03e5ae59"><a href="#Garc11" title="Garcia, Les \emph{climats} du vignoble de {B}ourgogne comme  patrimoine mondial de l'humanit{\'e}, Ed. Universitaires de Dijon (2011).">Garc11</a></sup><sup>,</sup><sup id="7e3cc4e952baf2ace29bc97117ad514c"><a href="#WJac11" title="Wolikow \&amp; Jacquet, Territoires et terroirs du vin du XVIIIe au XXIe si&#232;cles, &#201;ditions Universitaires de Dijon (2011).">WJac11</a></sup>.  Ainsi, la classification
actuelle est issue de plusieurs siècles de culture de la vigne, de
production de vin et de négociation sur les dénominations.  Ces
trois ensembles de pratiques forment les usages loyaux et
constants selon la doctrine de l'institut national de l'origine et
de la qualité (INAO) pour définir, reconnaître et gérer les AOC
<sup id="95abb746101aa32ae2b154f5bdee7ad0"><a href="#Capu47" title="Capus, L'{\'E}volution de la l{\'e}gislation sur les appellations  d'origine. Gen{\`e}se des appellations  contr{\^o}l{\'e}es, L. Larmat (1947).">Capu47</a></sup><sup>,</sup><sup id="36d1387edd76d672ddb30e2817a44c44"><a href="#Humb11" title="@phdthesis{Humb11,
  title={L'INAO, de ses origines {\`a} la fin des ann{\'e}es 1960:
                  gen{\`e}se et {\'e}volutions du syst{\`e}me des vins
                  d'AOC},
  author={Humbert, Florian},
  year={2011},
  school={Universit{\'e} de Bourgogne}
}">Humb11</a></sup>.  La complexité des informations contenues
dans la référence au lieu de production et la complexité de leurs
évolutions dans le temps sont à la fois des forces et des
faiblesses pour les AOC.  Elles permettent de simplifier les
nombreux déterminants biophysiques de la qualité des vins au prix
d'une perte d'information et d'une certaine opacité pour les
acteurs des marchés du vin.

La référence au lieu de production permet de donner une certaine
indication composite sur la qualité des vins lors des échanges.
Une abondante littérature économique (synthétisée par
<sup id="90e8d3da1815242f3136e232bea3b79b"><a href="#CMar04" title="Coestier \&amp; Marette, Economie de la qualit{\'e}, La d{\'e}couverte (2004).">CMar04</a></sup>) montre qu'en diminuant l'asymétrie d'information
entre les vendeurs et les acheteurs, les AOC peuvent limiter cette
défaillance de marché préjudiciable aux deux parties prenantes.
La question de la nature de l'information contenue dans les AOC se
pose alors, en particulier la distinction de la part relative aux
processus naturels de la part relative aux processus humains
<sup id="179cacf6073e0a5bd2c08b8f57141208"><a href="#Dion52" title="Dion, Querelle des anciens et des modernes sur les facteurs de la qualit{\'e} du vin, {Annales de g{\'e}ographie}, v(328), 417--431 (1952).">Dion52</a></sup>.  Cette séparation est déterminante pour identifier
les facteurs naturels, immobiles et non-reproductibles, qui
justifient réellement la référence au lieu de production
<sup id="d5f551e637b0632950381ff3346c5e2e"><a href="#Ay19" title="Ay, The informational content of geographical indications, {en r&#233;vision}, v(), (2019).">Ay19</a></sup>.  Nous présentons ici la constitution de données et
l'estimation de modèles qui permettent d'opérer statistiquement
cette distinction.  Nous montrons la présence d'une hiérarchie
implicite entre les communes de la zone, qui biaise l'information
transmise par les AOC sur les caractéristiques biophysiques des
parcelles.  Nous utilisons les prédictions issues de cette
modélisation pour classifier l'ensemble des parcelles sur une
échelle continue de qualité (entre 0 et 100) tout en corrigeant
les effets communaux issus de l'histoire.  Nous présentons cette
information par le biais d'une application cartographique.

La Section [2](#Sec:1) présente la construction de la base de données
géographique disponible sous licence GNU GPL V3 sur le serveur
[https://data.inra.fr/](https://data.inra.fr/dataset.xhtml?persistentId=doi:10.15454/ZZWQMN).  La parcelle cadastrale est l'unité
élémentaire d'observation qui permet l'appariement des variables
sur les AOC actuelles (produites par l'INAO), sur les AOC de 1936
(produites par la MSH de Dijon), sur les lieux-dits par le Plan
Cadastral Informatisé (produit par la DGFiP), sur l'altimétrie par
le RGE ALTI\textsuperscript{\textregistered} à 5 mètres (produit
par l'IGN), sur l'occupation du sol (produite par <sup id="04c03aec0f1658f1e579f642294535bc"><a href="#HJRV18" title="Hilal, Joly, Roy \&amp; Vuidel, Visual structure of landscapes seen from built environment, {Urban Forestry \&amp; Urban Greening}, v(), 71--80 (2018).">HJRV18</a></sup>),
sur la géologie par Charm-50 (produit par le BRGM) et sur la
pédologie par le Référentiel Pédologique de Bourgogne (produit par
le Gis Sol).  Les données ainsi constituées concernent l'ensemble
des parcelles des 31 communes inclues dans la côte de Beaune et la
côte de Nuits, soient l'ensemble des vignobles du département de
la Côte-d'Or à l'exception des hautes côtes et du Châtillonnais
(\autoref{Fig:1}).  Cette base de données permet de relier
finement les AOC aux caractéristiques biophysiques des parcelles
dont les vins sont issus, et possède ainsi une utilisation plus
large que celle présentée ici.

La Section [3](#Sec:3) présente l'estimation des modèles statistiques
dont les spécifications sont décrites plus extensivement dans un
article associé <sup id="d5f551e637b0632950381ff3346c5e2e"><a href="#Ay19" title="Ay, The informational content of geographical indications, {en r&#233;vision}, v(), (2019).">Ay19</a></sup>.  Le principe est d'utiliser la
structure hiérarchique des AOC (Coteaux bourguignons < Bourgogne
régional < Villages < Premiers crus < Grands crus) pour les relier
aux caractéristiques biophysiques des parcelles par une unique
variable latente de qualité des vignes.  Nous montrons que cette
variable continue non observable peut être estimée de manière
flexible à partir des AOC actuelles.  Nous utilisons pour cela des
modèles ordonnés additifs généralisés (OGAM pour *ordered
generalized additive model*, <sup id="288ff4c397fcb33b93de861cedf4c4e5"><a href="#WPSa16" title="Wood, Pya \&amp; S\afken, Smoothing parameter and model selection for general smooth models, {Journal of the American Statistical Association}, v(516), 1548--1563 (2016).">WPSa16</a></sup>) qui prédisent
correctement près de 90 % des niveaux actuels des AOC. Ils
permettent également d'estimer semi-paramétriquement l'effet de
chaque variable biophysique ainsi que les effets communaux issus
de l'histoire.  Ces estimations permettent de corriger les effets
communaux pour prédire la qualité des vignes uniquement à partir
des caractéristiques biophysiques.

La Section [4](#Sec:4) présente le codage et l'utilisation de
l'application *Shiny* <sup id="834ac534f77f47a4c55b352119d1a346"><a href="#CCAX19" title="@Manual{CCAX19,
    title = {shiny: Web Application Framework for {R}},
    author = {Winston Chang and Joe Cheng and JJ Allaire and Yihui Xie
                  and Jonathan McPherson},
    year = {2019},
    note = {R package version 1.4.0},
    url = {https://CRAN.R-project.org/package=shiny},
  }">CCAX19</a></sup> qui permet de consulter la
classification continue des parcelles de vignes, telle que prédite
par la modélisation statistique.  L'utilisateur peut ainsi saisir
les informations typiquement disponibles sur les étiquettes des
bouteilles de vin de Bourgogne (le niveau de l'AOC dans la
hiérarchie, la commune de production, et le lieu-dit de la
parcelle) pour identifier géographiquement l'ensemble des
parcelles concernées et leur niveau de qualité prédite (avec ou
sans correction des effets communaux).  Cette information permet
une évaluation plus précise de la qualité des vins que la
hiérarchie actuelle des AOC en 5 niveaux, sans introduire de
facteurs subjectifs exogènes.  Cela permet en outre d'améliorer
l'information disponible pour les consommateurs à partir
d'informations déjà présentes sur les étiquettes.  Chaque vin
identifié peut alors être comparé aux autres vins du même niveau
hiérarchique ou aux vins d'autres niveaux hiérarchiques afin
d'évaluer sa qualité relative.

Les codes `R` <sup id="4a3b4bb79c4511e11e837fb04f7b66b0"><a href="#Core19" title="@Manual{Core19,
title = {R: A Language and Environment for Statistical Computing},
author = {{R Core Team}},
organization = {R Foundation for Statistical Computing},
address = {Vienna, Austria},
year = {2019},
url = {http://www.R-project.org/},
}">Core19</a></sup> fournis permettent de reproduire
l'ensemble des tables et des figures à partir des données
disponibles sur le serveur [https://data.inra.fr/](https://data.inra.fr/dataset.xhtml?persistentId=doi:10.15454/ZZWQMN). La version du
logiciel et des packages utilisés lors de la rédaction de cet
article sont reportés en Annexe 1.  L'intégralité du code relatif
à l'application *Shiny* est également reportée en Annexes 5
et&nbsp;6.  Elle peut ainsi être lancée localement, voire
modifiée par les utilisateurs.  La version la plus récente des
codes est accessible sur le répertoire
[https://github.com/jsay/geoInd](https://github.com/jsay/geoInd).


<a id="Sec:1"></a>

# Présentation des données

L'unité géographique de base pour construire les données est la
parcelle cadastrale des 31 communes du périmètre d'étude présenté
dans la \autoref{Fig:1}.  La géométrie des parcelles est issue de la
BD parcellaire de l'IGN dans sa version 2014 pour la Côte-d'Or
(téléchargement le 09/10/2015).  Nous l'avons enrichie de variables
décrivant la géométrie des parcelles avec l'ajout de la surface, du
périmètre et de la distance maximale entre deux sommets pour chaque
polygone cadastral <sup id="f8a440497b1cd6ff02337891691ca6f3"><a href="#CBBD15" title="Conrad, Bechtel, Bock, , Dietrich, Fischer, Gerlitz, , Wehberg, Wichmann, \&amp; B\ohner, System for automated geoscientific analyses (SAGA) v. 2.1. 4, {Geoscientific Model Development}, v(7), 1991--2007 (2015).">CBBD15</a></sup>.  

La base de données qui résulte de toutes les étapes présentées
ci-dessous est directement disponible sur le serveur
[https://data.inra.fr/](https://data.inra.fr/dataset.xhtml?persistentId=doi:10.15454/ZZWQMN).  Le code `R` ci-dessous permet de charger
directement la version la plus récente des données à l'aide du
package `dataverse` <sup id="6d166ff2ee01be4cb1f7664f2b5c9dd2"><a href="#Leep17" title="  @Manual{Leep17,
    title = {dataverse: R Client for Dataverse 4},
    author = {Thomas J. Leeper},
    year = {2017},
    note = {R package version 0.2.0},
  }">Leep17</a></sup>.

    library(dataverse) ; library(sp)
    Sys.setenv("DATAVERSE_SERVER" = "data.inra.fr")
    GeoRasRaw <- get_file("GeoRas.Rda", "https://doi.org/10.15454/ZZWQMN")
    writeBin(GeoRasRaw, "GeoRas.Rda")
    load("GeoRas.Rda") ; dim(Geo.Ras)

    [1] 110350     67

L'objet `Geo.Ras` est un objet de la classe
`SpatialPolygonsDataFrame`, définie par le package `sp`
<sup id="d9b8eba189b5d10464e23f2df05daf7f"><a href="#BPGR13" title="Roger Bivand, Edzer Pebesma \&amp; Virgilio Gomez-Rubio, Applied spatial data analysis with {R}, Second edition, Springer, NY (2013).">BPGR13</a></sup> préalablement chargé.  Nous constatons que la version
actuelle de la base compte \(110\,350\) parcelles et 67 variables.
Le dictionnaire des variables est reporté dans la Table [1](#org2bc3466) en
Annexe 3.


## Les AOC actuelles

Les polygones cadastraux ont ensuite été appariés par jointure
géographique aux délimitations parcellaires des AOC viticoles
produites par l'INAO, disponibles à l'adresse
[https://www.data.gouv.fr/fr/datasets/delimitation-parcellaire-des-aoc-viticoles-de-linao](https://www.data.gouv.fr/fr/datasets/delimitation-parcellaire-des-aoc-viticoles-de-linao)
sous licence ouverte (téléchargement le 21/08/18). Les variables
qui décrivent la géométrie des parcelles cadastrales et les AOC
sont présentes dans les colonnes 2 à 16 des données produites,
qui ont été chargées ci-dessus.

    names(Geo.Ras)[ 2: 16]

     [1] "IDU"     "CODECOM" "AREA"    "PERIM"   "MAXDIST" "PAOC"   
     [7] "BGOR"    "BOUR"    "VILL"    "COMM"    "PCRU"    "GCRU"   
    [13] "AOC"     "AOCtp"   "AOClb"

L'information brute issue de la superposition de la couche
cadastrale avec la couche INAO sur les AOC actuelles est reportée
dans les variables `PAOC` à `GCRU`, avec la valeur \(1\) lorsque que
le niveau AOC est revendicable sur la parcelle correspondante et
\(0\) sinon (voir Table [1](#org2bc3466)).  Les \(49\,718\) parcelles cadastrales
hors du périmètre des AOC ont des valeurs manquantes pour chacune
de ces 7 variables.

Les trois variables suivantes (`AOC`, `AOCtp` et `AOClb`)
contiennent les mêmes informations INAO, mais recodées de façon
plus opérationnelle pour l'analyse statistique.  Selon le principe
des replis, issu de la doctrine de l'INAO, les parcelles d'un
niveau hiérarchique supérieur peuvent toujours être revendiquées
dans un niveau inférieur.  La superposition des couches de l'INAO
conduit donc à la présence de plusieurs niveaux d'AOC sur une même
parcelle, ce qui entre en contradiction avec une autre doctrine de
l'INAO, à savoir qu'il est interdit de revendiquer des AOC
différentes pour un même produit.  Dans les faits, les producteurs
revendiquent très souvent l'AOC maximale à laquelle ils peuvent
prétendre.  La variable `AOC` que nous avons créée représente donc
cette valeur pour chacune des parcelles: elle est codée `0` pour
les parcelles hors AOC, `1` pour les Coteaux bourguignons, `2`
pour les Bourgognes régionaux et jusqu'à `5` pour les Grands crus.
De plus, les informations présentes sur les étiquettes des vins
peuvent correspondre soit à des AOC soit à des dénominations
géographiques complémentaires (le plus souvent sans que cette
distinction soit claire pour le consommateur).  Les modalités
prises par la variable `AOClb` sont une combinaison du nom des
appellations et des dénominations.  La variable `AOCtp` code cette
combinaison.  Les modalités correspondent souvent au nom de l'AOC
maximale revendicable.  Pour les Bourgognes régionaux, nous
n'utilisons pas la dénomination "Bourgogne Côte d'Or", créée en
2015, plus haute dans la hiérarchie que l'AOC Bourgogne mais peu
connue du fait de sa faible antériorité.  D'ailleurs, l'analyse se
limite à la Côte d'Or où les délimitations "Bourgogne Côte d'Or"
et "Bourgognes régionaux" sont très proches.  C'est principalement
pour les Premiers Crus que la variable `AOClb` contient les
dénominations géographiques, car l'AOC ne fait référence qu'au
niveau village alors que les dénominations permettent d'identifier
plus précisément les lieux-dits des parcelles.

La distribution de l'ensemble des parcelles de la zone entre la
dimension horizontale (entre les communes) et verticale des AOC
(entre les niveaux hiérarchiques) est présentée dans la
\autoref{Fig:2} suivante, dont le code est reporté ci-dessous.
Pour la clarté du code, les objets et fonctions de configuration
graphique `my.lab`, `my.pal`, `my.par`, `my.key` et `my.pan` sont
définis dans l'Annexe 2.  Ces objets doivent être chargés en
préalable pour le fonctionnement du code suivant en local, en
plus des packages `lattice` et `RColorBrewer`.

    tmp <- unique(Geo.Ras$LIBCOM[order(Geo.Ras$YCHF, decreasing= TRUE)])
    Geo.Ras$LIBCOM <- factor(Geo.Ras$LIBCOM, levels= tmp)
    Geo.Fig <- subset(Geo.Ras, !is.na(AOClb))
    fig.dat <- aggregate(model.matrix(~ 0+ factor(Geo.Fig$AOC))*
                         Geo.Fig$AREA/ 1000, by= list(Geo.Fig$LIBCOM), sum)
    names(fig.dat) <- c("LIBCOM", "BGOR", "BOUR", "VILL", "PCRU", "GCRU")
    fig.dat$LIBCOM <- factor(fig.dat$LIBCOM, lev= rev(levels(fig.dat$LIBCOM)))
    fig.crd <- t(apply(fig.dat[, -1], 1, function(t) cumsum(t)- t/2))
    fig.lab <- round(t(apply(fig.dat[, -1], 1, function(t) t/ sum(t)))* 100)
    barchart(LIBCOM~ BGOR+ BOUR+ VILL+ PCRU+ GCRU, xlim= c(-100, 10500),
             xlab="Surfaces sous appellation d'origine contrôlée (hectare)",
             data= fig.dat, horiz= T, stack= T, col= my.pal, border= "black",
             par.settings= my.par, auto.key= my.key, panel= my.pan)


## Enrichissement des AOC historiques

Des variables sur les classifications historiques des parcelles,
obtenues auprès de la Maison des Sciences de l'Homme de Dijon
sous formes de cartes numérisées, sont également appariées.
Alors que l'INAO a été créé en 1936, la première délimitation
officielle des AOC s'est opérée entre 1936 et 1940 sur le
périmètre d'étude.  Elle fut basée sur deux classements
antérieurs non officiels : celui de Jules Lavalle de 1855
<sup id="840f03a33b6be088fc48b363669ed75e"><a href="#Lava55" title="Lavalle, Histoire et statistique de la vigne et des grands vins de  la C&#244;te d'Or, Daumier, Dijon (1855).">Lava55</a></sup> et celui du Comité d’Agriculture et de Viticulture
de l'Arrondissement de Beaune de 1860 <sup id="7e3cc4e952baf2ace29bc97117ad514c"><a href="#WJac11" title="Wolikow \&amp; Jacquet, Territoires et terroirs du vin du XVIIIe au XXIe si&#232;cles, &#201;ditions Universitaires de Dijon (2011).">WJac11</a></sup>.  Nous
compilons ces différentes classifications pour obtenir une
hiérarchie des parcelles en 3 niveaux: Régional < Village < Grand
Cru, que nous considérons comme les niveaux d'AOC en 1936.  Cette
classification historique est moins détaillée que l'actuelle (3
niveaux au lieu de 5) car l'AOC Coteaux bourguignons n'existait
pas encore (les niveaux ordinaires et grands ordinaires qui la
précédèrent n'étaient pas délimités) tout comme les Premiers Crus
seulement instaurés par décret en 1943 <sup id="a2b61fcab0e2c21259e8b2462f32d1b6"><a href="#Luca17" title="Lucand, Le vin et la guerre: Comment les nazis ont fait main basse  sur le vignoble fran{\c{c}}ais, Armand Colin (2017).">Luca17</a></sup>.
L'appariement s'effectue par le centroïde des parcelles car la
géométrie cadastrale actuelle ne se superpose pas parfaitement
avec les polygones de la carte historique du fait de la
numérisation et du changement du cadastre.  La faible taille des
parcelles (0.2 ha en moyenne) permet de faire confiance en cette
procédure d'appariement, confirmée par de nombreuses
vérifications manuelles.  La base parcellaire est ainsi enrichie
des 2 variables `AOC1936lab` et `AOC36lvl` présentées dans la
Table [1](#org2bc3466) en Annexe 3.

    names(Geo.Ras)[ 56: 57]
    table(Geo.Ras$AOC36lvl, Geo.Ras$AOC)

    [1] "AOC36lab" "AOC36lvl"
       
            0     1     2     3     4     5
      0 47056  9832 13337 10554   593    44
      3  2586    15   565 15529  8226   266
      5    24     0     1    14     3  1635

Ces deux nouvelles variables correspondent aux colonnes 56 et 57
de la base `Geo.Ras`.  Le croisement de la hiérarchie des AOC de
1936 avec la hiérarchie des AOC actuelles montre que les surfaces
sous AOC étaient sensiblement plus réduites à l'époque.  Elles
représentaient 27 % des parcelles de la zone au lieu de 55 %
actuellement.  Près de \(165\,000\) parcelles hors AOC en 1936 le
sont actuellement (tous niveaux confondus, soit la somme de la
première ligne du tableau sans la première cellule) alors que
seulement \(2\,610\) parcelles sont dans le cas inverse (somme de la
première colonne, sans la première cellule).  La majorité des
parcelles classées en niveaux Village et Grand cru actuellement
l'étaient déjà en 1936, les Premiers Crus actuels étaient
principalement en Village, et les Coteaux bourguignons et les
Bourgogne niveau régional étaient hors AOC.


## Enrichissement des lieux-dits

Les lieux-dits (géométrie et toponymie) sont disponibles dans le
Plan Cadastral Informatisé (DGFiP) téléchargeable à l'adresse
<https://cadastre.data.gouv.fr/datasets/plan-cadastral-informatise>.
Le téléchargement pour la Côte-d'Or (21) date du 13/01/2019.  Ces
données, en licence ouverte Etalab, nous permettent de renseigner
les lieux-dits des parcelles viticoles et certaines variables
communales agrégées.  Une attention particulière est portée sur
les lieux-dits dont les intitulés doivent être croisés avec le
nom des communes pour être uniques (un même lieu-dit toponymique
peut être présent sur plusieurs communes).  La géométrie des
lieux-dits et des parcelles de l'IGN se superposant parfaitement,
l'appariement avec les données parcellaires est réalisé par
jointure géographique des polygones.

    Geo.Ras$DISTCHF <- sqrt(((Geo.Ras$XL93- Geo.Ras$XCHF* 100))^2
                            + ((Geo.Ras$YL93- Geo.Ras$YCHF* 100))^2)
    names(Geo.Ras)[ 58: 66] ; summary(Geo.Ras$DISTCHF)

    [1] "LIEUDIT"  "CLDVIN"   "LIBCOM"   "XCHF"     "YCHF"     "ALTCOM"  
    [7] "SUPCOM"   "POPCOM"   "CODECANT"
       Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
          0     595    1049    1230    1679    6314    6425

Les variables issues de cette étape sont stockées dans les
colonnes 58 à 66 de l'objet `Geo.Ras`.  Comme reporté dans le
code, nous pouvons calculé la distance euclidienne entre le
centroïde de chaque parcelle et le chef-lieu (généralement la
mairie) de la commune d'appartenance.  La distance moyenne de 1,2
km est cohérente avec la taille des communes du périmètre d'étude
(environ 2,5 km\(^2\)).  Notons que \(6\,426\) parcelles de la BD
parcellaire sont absentes du Plan Cadastral Informatisé.  Elles
correspondent à environ 4 % de la base initiale et n'ont donc pas
été appariées (des valeurs omises sont reportées pour ces
variables associées aux lieux-dits).  Ces parcelles sont pour la
plupart hors AOC et se concentrent sur les communes les plus
urbanisées, telles que Chenôve, Marsannay-la-Côte et Beaune.  Ces
valeurs manquantes semblent donc correspondre à des espaces bâtis
qui ne peuvent pas être classés en AOC.  Des vérifications
manuelles n'ont pas suffi pour statuer définitivement sur ce
point, qui n'est donc pas univoque.  Ces valeurs manquantes
seront exclues de l'analyse statistique, mais elles ne sont pas
décisives pour le résultat des estimations.


## Enrichissement de la topographie

Les informations de la couche cadastrale sont enrichies de
variables topographiques issues d'un modèle numérique de terrain
(MNT RGE ALTI\textsuperscript{\textregistered} 5 m, sous licence
IGN "Recherche") et d'une couche d'occupation du sol (MOS)
provenant du modèle développé par <sup id="04c03aec0f1658f1e579f642294535bc"><a href="#HJRV18" title="Hilal, Joly, Roy \&amp; Vuidel, Visual structure of landscapes seen from built environment, {Urban Forestry \&amp; Urban Greening}, v(), 71--80 (2018).">HJRV18</a></sup> et disponible en
téléchargement sur [https://data.inra.fr/](https://data.inra.fr/dataset.xhtml?persistentId=doi:10.15454/ECLYGT), voir <sup id="8a2f7acf7c07300154df56c90df0c68b"><a href="#Hila20" title="Hilal, Land Use Land Cover High Resolution Map (5-m) for C&#244;te-d&#8217;Or  (21), {Portail Data INRAE}, v(), (2020).">Hila20</a></sup>.  Le
MOS est construit à partir de la BD
TOPO\textsuperscript{\textregistered}, du registre parcellaire
graphique (RPG, Agence de services et de paiement) et de Corine
Land Cover (Agence européenne de l'environnement).  Ces deux
couches raster sont à une résolution de 5 m.  Les informations
altimétriques du MNT permettent de produire 3 couches raster
supplémentaires, toujours à 5 m de résolution : la pente,
l'exposition et les radiations solaires.  Ces attributs sont
calculés en utilisant le logiciel ArcGis <sup id="b5726be6c56a4db97e85e4116e63bb65"><a href="#RFu00" title="Rich \&amp; Fu, Topoclimatic Habitat Models, {Proceedings of the Fourth International Conference on
                  Integrating GIS and Environmental Modeling}, v(), (2000).">RFu00</a></sup>.  Les 5
couches raster ainsi constituées (altitude, pente, exposition,
radiation solaire et occupation du sol) sont converties en
fichiers au format XYZ, avec X et Y les coordonnées Lambert 93 du
centre de chaque pixel et Z la variable d'intérêt de chacune des
couches.  Les fichiers sont regroupés dans une même table XYZ
contenant un seul couple XY et les 5 attributs Z issus des couches
raster respectives.  Cette table est ensuite appariée avec une
autre table XYZ produite après rastérisation à 5 m des parcelles
cadastrales en vue de récupérer le couple XY du centroïde de
chaque pixel et Z l'identifiant `PAR2RAS` qui reprend
l'identifiant cadastral (IDU) de la parcelle dans laquelle se
situe le pixel.  L'identifiant `PAR2RAS` servira à l'appariement
des parcelles avec les 5 variables topographiques.  Le résultat
est une base contenant plus de 14 millions de lignes, une pour
chaque pixel de 5 m.  Les informations ainsi disponibles
permettent de calculer à l'échelle des parcelles cadastrales des
fréquences décrivant l'occupation non agricole du sol (urbain,
forêt, eau) et des valeurs moyennes pour les variables dérivées de
l'altimétrie.  Les résultats sont reportés dans les colonnes 17 à
26 de l'objet `Geo.Ras`. D'autres méthodes d'agrégation des
variables topographiques ont été testées et n'apportent pas de
différences notables avec les variables calculées à partir des
moyennes.

    names(Geo.Ras)[ c(1, 17: 26)]
    Geo.Ras$RAYAT <- (Geo.Ras$SOLAR- mean(Geo.Ras$SOLAR, na.rm= TRUE))/
        sd(Geo.Ras$SOLAR, na.rm= TRUE)
    Geo.Ras$EXPO <- cut(Geo.Ras$ASPECT,
                        breaks= c(-2, 45, 90, 135, 180, 225, 270, 315, 360))

    [1] "PAR2RAS" "XL93"    "YL93"    "NOMOS"   "URBAN"   "FOREST" 
    [7] "WATER"   "DEM"     "SLOPE"   "ASPECT"  "SOLAR"

La variable `SOLAR` (sur les rayonnements solaires) est
centrée-réduite, pour éviter les problèmes d'unité de mesure dans
l'analyse statistique.  Toujours pour des raisons de
spécification statistique, la variable `ASPECT` (exposition
moyenne des parcelles) est discrétisée en 8 classes d'azimuts de
45 degrés d'amplitude.  Lors de cette opération, \(2\,096\)
parcelles n'ont pas pu être appariées car elles ne contiennent
aucun centroïde de pixel suite à la rastérisation du parcellaire.
Ces parcelles de très petites tailles avec des formes
géométriques particulières, probablement des "erreurs" du
cadastre, seront enlevées au moment de l'analyse statistique.
Elle couvrent une surface cumulée de 2.7 ha, soit moins de 0.01 %
de la surface totale étudiée.


## Enrichissement de la géologie

Les données géologiques sont extraites de la BD harmonisée
Charm-50 produite par le BRGM à l'échelle du \(1/50\,000\).  Cette
base est disponible sur le site [http://infoterre.brgm.fr](http://infoterre.brgm.fr) sous
licence Ouverte.  L'extraction contient les formations
géologiques, nommée `GEO050K_HARM_021_S_FGEOL_CGH_2154`,
téléchargées le 25/04/2019 pour le département de la Côte-d'Or.
L'appariement est réalisé par intersection des centroïdes des
parcelles avec les polygones géologiques.  La faible taille des
parcelles permet de s'assurer de la validité de cette procédure,
vérifiée manuellement par ailleurs.  Le dictionnaire associé aux
16 variables sur la géologie est disponible dans la Table [1](#org2bc3466)
en Annexe 3.  La description des variables est peu précise
actuellement car les données du BRGM sont disponibles depuis peu
et ne possèdent pas encore, à notre connaissance, de dictionnaire
exploitable.  Ce manque de précision n'est pas limitant pour
l'analyse statistique postérieure car ces variables géologiques
seront utilisées sous forme d'indicatrices qui ne nécessitent pas
de spécification explicite.  Cela peut néanmoins être différent
pour d'autres utilisations de la base de données.  La variable
`NOTATION`, présente dans la couche sur les formations
géologiques, est une abréviation faite de chiffres et de lettres
qui reprend la stratigraphie harmonisée (âge des formations
représentées et nature des roches).

    names(Geo.Ras)[27: 42]
    Geo.Ras$NOTATION <- factor(Geo.Ras$NOTATION)
    tmp <- table(Geo.Ras$NOTATION)< 1000
    table(Geo.Ras$GEOL <- factor(
              ifelse(Geo.Ras$NOTATION %in% names(tmp[ tmp]), "0AREF",
                     as.character(Geo.Ras$NOTATION))))

     [1] "CODE"       "NOTATION"   "DESCR"      "TYPEGEOL"   "APLOCALE"  
     [6] "TYPEAP"     "GEOLNAT"    "ISOPIQUE"   "AGEDEB"     "ERADEB"    
    [11] "SYSDEB"     "LITHOLOGIE" "DURETE"     "ENVIRONMT"  "GEOCHIMIE" 
    [16] "LITHOCOM"
    
    0AREF     C     E    Fu    Fx    Fy    Fz    GP  j1-2    j3   j3a 
     5487 29040  2683  1653  9321 10006  7951 11181  1359  1848  3785 
      j3b   j4a   j5a   j5b   j6a  p-IV 
     2887  2934  5201  5301  4827  4855

Dans le périmètre d'étude (qui est délimité par les frontières
communales et non le vignoble), nous recensons 31 formations
géologiques homogènes, dont la distribution spatiale et les
intitulés sont présentés dans la \autoref{Fig:5} en
Annexe&nbsp;4.  Les parcelles non appariées, produisant des
valeurs manquantes, sont peu nombreuses (entre 31 et 862
parcelles selon les variables), elles seront enlevées au moment
de l'analyse statistique sans conséquence sur les résultats.
Pour diminuer la multi-colinéarité lors de l'utilisation
statistique de ces notations géologiques, utilisées comme
indicatrices; et nous assurer d'estimations précises, les
notations qui comptent moins de \(1\,000\) parcelles sont
regroupées dans une modalité de référence codée `0AREF`.  Il
reste ainsi les 17 notations présentées ci-dessus qui pourront
être utilisées dans la modélisation.


## Enrichissement de la pédologie

Les données pédologiques utilisées sont extraites du Référentiel
Pédologique de Bourgogne : "Régions naturelles, pédopaysage et
sols de Côte-d'Or à l'échelle \(1/250\,000\)" (étude 25021 dans le
référentiel Gis Sol).  Ces données sont compatibles avec la
référence nationale DoneSol et correspondent à la meilleure
information pédologique actuellement disponible systématiquement
sur le périmètre d'étude.  La localisation des types de sol et
l'appariement avec le parcellaire cadastral s'opèrent par le biais
des 194 unités cartographiques de sols (UCS) qui composent le
périmètre d'étude.  Les UCS sont des polygones construits pour
être homogènes en termes de pédo-paysages (topographie, climat,
géologie).  Elles sont typiquement utilisées pour cartographier
les caractéristiques des sols, mais peuvent néanmoins contenir
différents types de sols.  Ces derniers, regroupés en unités
typologiques, ne peuvent pas être localisés plus précisément que
les unités cartographiques.  Cette imprécision dans la
localisation des données est une limite importante pour leur usage
statistique à l'échelle parcellaire <sup id="208d1d7a07cf6fffe3fa96d1717b7a1f"><a href="#Ay11" title="@phdthesis{Ay11,
  TITLE = {H&#233;t&#233;rog&#233;n&#233;it&#233; de la terre et raret&#233; &#233;conomique},
  AUTHOR = {Ay, Jean-Sauveur},
  URL = {https://tel.archives-ouvertes.fr/tel-00629142},
  SCHOOL = {{Universit{\'e} de Bourgogne}},
  YEAR = {2011},
  MONTH = Jul,
  TYPE = {Theses},
  PDF = {https://tel.archives-ouvertes.fr/tel-00629142/file/THESE.pdf},
  HAL_ID = {tel-00629142},
  HAL_VERSION = {v1},
}">Ay11</a></sup>.  En l'absence de
données spatialement plus précises, les données parcellaires du
cadastre sont enrichies du libellé de l'UCS et des 11 variables
correspondantes à l'unité typologique de sol dominante,
c'est-à-dire celle qui est la plus étendue au sein de chaque UCS.
Ce choix à première vue arbitraire ne change pas les résultats
obtenus.

    names(Geo.Ras)[43: 55]
    Geo.Ras$NOUC <- factor(Geo.Ras$NOUC)
    tmp <- table(Geo.Ras$NOUC)< 1000
    table(Geo.Ras$PEDO <- factor(
              ifelse(Geo.Ras$NOUC %in% names(tmp[tmp]), "0AREF",
                     as.character(Geo.Ras$NOUC))))

     [1] "NOUC"   "SURFUC" "TARG"   "TSAB"   "TLIM"   "TEXTAG" "EPAIS" 
     [8] "TEG"    "TMO"    "RUE"    "RUD"    "OCCUP"  "DESCRp"
    
    0AREF    10    13    14    26    27    28    29    30    32    34 
     3265  2074  3770 23472  4750  1348 11641  7636  6983  3072  2469 
       35    36    38     5    61    69     7     8 
     8356  1602  2198  4767  1605  2116  1445  3136

Comme pour les variables sur la géologie, les variables
pédologiques seront intégrées dans les modèles statistiques par
des indicatrices, qui correspondent ici aux UCS.  Le détail des
11 variables pédologiques est maintenu dans les données
constituées pour ne pas limiter les autres usages qui peuvent en
être faits.  Les libellés des unités cartographiques, reportés
dans la variable `DESCRp`, ont été saisis manuellement à partir
du site [https://bourgogne.websol.fr/carto](https://bourgogne.websol.fr/carto).  Les valeurs
manquantes, associées aux parcelles non couvertes par la couche
pédologique, sont assez nombreuses : \(14\,645\) parcelles
cadastrales, qui couvrent environ 4,25 % de la surface du
périmètre étudié.  Les parcelles non couvertes sont, en revanche,
peu désignées en AOC car moins de 1 % des AOC ont des variables
pédologiques manquantes.  Les valeurs manquantes sont donc dans
de rares cas des parcelles de vignes et ce sont principalement
des parcelles bâties au coeur des villages.  Une explication
intuitive de ces valeurs manquantes est l'absence de données
pédologiques sur les sols artificialisés, cela étant corroborée
par une vérification manuelle.  La faible précision spatiale des
données pédologiques peut s'illustrer par comparaison avec les
variables du MOS sur l'artificialisation.  Les UCS avec les
variables pédologiques manquantes regroupent des occupations du
sol très différentes.  Parmi les 33 modalités présentes
initialement dans les UCS (\autoref{Fig:6} en Annexe 4), seules
19 sont retenues car elles concernent au moins \(1\,000\)
parcelles.  Les autres sont regroupées dans une modalité de
référence `0AREF`.


## Statistiques descriptives

Les données issues des 7 sources présentées ci-dessus sont donc
compilées dans une base unique.  Le code suivant effectue les
derniers traitements, à savoir la conversion du système de
projection du Lambert93 vers le WGS84 utilisé pour l'application
*Shiny*, la suppression des valeurs manquantes sur certaines
variables, le codage des indicatrices (pour les AOC et
l'exposition), et la normalisation des unités de mesure pour les
variables continues.  L'objet `tb.lab` qui contient l'intitulé des
variables, nécessaire dans le code ci-dessous, est défini en
Annexe 2.  Le package `stargazer` doit être chargé en préalable
pour construire la Table \ref{Tab:7}.

    GR84 <- spTransform(Geo.Ras, CRS("+proj=longlat +ellps=WGS84"))
    dd <- coordinates(GR84) ; Geo.Ras$X= dd[, 1] ; Geo.Ras$Y= dd[, 2]
    Reg.Ras <- subset(Geo.Ras, !is.na(AOClb) & !is.na(DEM) & !is.na(DESCR)
                      & !is.na(RUD) & !is.na(AOC36lab) & !is.na(REGION))
    Stat.Ras <- data.frame(Reg.Ras@data, model.matrix(~0+ factor(Reg.Ras$AOC)),
                           model.matrix(~ 0+ factor(Reg.Ras$EXPO)))
    names(Stat.Ras)[75: 79] <- paste0("AOC", 1: 5)
    names(Stat.Ras)[80: 87] <- paste0("EXPO", 1: 8)
    Stat.Ras$AREA  <- Reg.Ras$AREA/ 1000 ; Stat.Ras$DEM   <- Reg.Ras$DEM/ 1000
    Stat.Ras$SOLAR <- Reg.Ras$SOLAR/ 1000000
    stargazer(Stat.Ras[, names(tb.lab)], covariate.labels=tb.lab, float= F, 
              font.size= "small", column.sep.width= "0pt", digit.separate= c(0, 3))

nous disposons donc d'une base de données qui contient \(59\,113\)
observations utilisables pour estimer le modèle statistique.  Ce
nombre provient de plusieurs sélections présentées dans le code
ci-dessus : le principal critère limite les observations aux
parcelles ayant au moins une AOC.  Cette opération exclue
\(49\,717\) pour n'en conserver que \(60\,632\).  Le second critère
enlève les observations avec des valeurs manquantes pour au moins
une des variables qui ont été enrichies.  Ce critère écarte
\(1\,519\) parcelles.  Les parcelles ont des surfaces faibles (0,2
ha de moyenne), des altitudes comprises entre 200 et 500 m (286 m
de moyenne), des pentes entre 0 et 37 degrés (5,75 degrés de
moyenne) et des radiations solaires comprises entre \(581\,000\) et
1,2 millions de Joules (1 millions de Joules en moyenne).  Nous
observons également que le niveau village de la hiérarchie des AOC
regroupe 42 % des parcelles, les niveaux régionaux et coteaux
bourguignons respectivement 23 % et 16,5 %, alors que les niveaux
premier et grand cru respectivement 15 % et 3 %.  Les vignobles
sont globalement orientés à l'Est, avec 55 % des observations qui
ont une orientation comprise entre 45 et 135 degrés.


<a id="Sec:3"></a>

# Modèle statistique

Le modèle statistique étudie la relation entre le classement AOC des
parcelles, leurs caractéristiques biophysiques (topographie,
géologie, pédologie) et leur commune d'appartenance.  Cette
modélisation fournit des prédictions qui permettent de préciser la
hiérarchie sous-jacente aux AOC en positionnant chaque parcelle sur
une échelle de qualité continue entre 0 et 100 après normalisation.


## Estimation du modèle

Le modèle utilisé et le processus de spécification sont tirés d'un
article associé <sup id="d5f551e637b0632950381ff3346c5e2e"><a href="#Ay19" title="Ay, The informational content of geographical indications, {en r&#233;vision}, v(), (2019).">Ay19</a></sup>.  Il s'agit d'estimer un modèle ordonné
additivement semi-paramétrique (OGAM) qui prend en compte la
structure hiérarchique des AOC de la zone, notée \(y \in \{1, 2, 3,
    4, 5\}\) par ordre croissant.  Les désignations des AOC sont
supposées suivre une règle de décision basée sur une variable
latente non observable qui franchit des seuils différents selon la
commune d'appartenance.  Notons \(X_i\) le vecteur des
caractéristiques biophysiques de la parcelle de vigne \(i\) (avec
\(i= 1, \dots, N\)) et \(C_i\) le vecteur de dimension 31 qui a pour
élément générique \(c_{ih}\) égal à 1 si la parcelle \(i\) se situe
dans la *commune* \(h\) et 0 sinon.  L'hypothèse d'une distribution
logistique de la partie aléatoire de la variable latente produit
un modèle de logit ordonné classique <sup id="ba4181a0e7dae7fbb217e69ee0b575b4"><a href="#AKat17" title="Agresti \&amp; Kateri, Ordinal probability effect measures for group comparisons in  multinomial cumulative link models, {Biometrics}, v(1), 214--219 (2017).">AKat17</a></sup> :

où \(\Lambda\) est la fonction cumulative de la loi logistique.  Les
déterminants humains qui ont impactés la classification AOC au
cours de l'histoire sont pris en compte par les effets fixes
communaux notés \(\mu\).  En l'absence d'*a priori* théorique sur
l'effet de chaque variable biophysique \(X_i\), nous les spécifions
au travers d'une série de transformations additives *B-splines*
que nous notons \(B(\cdot)\) avec \(\beta\) le vecteur des
coefficients associés.  Ce modèle de désignation peut alors être
estimé avec la fonction `gam` du package `mgcv` comme décrit dans
<sup id="288ff4c397fcb33b93de861cedf4c4e5"><a href="#WPSa16" title="Wood, Pya \&amp; S\afken, Smoothing parameter and model selection for general smooth models, {Journal of the American Statistical Association}, v(516), 1548--1563 (2016).">WPSa16</a></sup>.  Le manuel d'utilisation de l'auteur du package
<sup id="7428cca95c8f1a0339bd46afd86d6e00"><a href="#Wood17" title="Wood, Generalized additive models: An introduction with R, Chapman and Hall/CRC, second edition (2017).">Wood17</a></sup> contient de nombreux détails méthodologiques sur le
processus de pénalisation semi-paramétrique des effets des
variables continues.

Afin de contrôler les effets du terroir qui ne seraient pas pris
en compte par les variables biophysiques présentées précédemment
(à cause de variables omises ou d'erreurs de mesure), nous
incluons les coordonnées géographiques des centroïdes des
parcelles comme variables explicatives.  Cela permet d'améliorer
sensiblement les capacités prédictives du modèle et de proposer
une estimation non biaisée des effets communaux <sup id="d5f551e637b0632950381ff3346c5e2e"><a href="#Ay19" title="Ay, The informational content of geographical indications, {en r&#233;vision}, v(), (2019).">Ay19</a></sup>.  Nous
estimons des modèles OGAM à des degrés divers d'ajustement des
fonctions splines associées aux coordonnées géographiques.  En
augmentant le nombre maximal de degrés de liberté effectifs noté
\(k\) dans la fonction `gam`, le modèle va s'ajuster plus finement
aux variations locales des AOC pour prendre en compte les effets
non observables.  L'objet `gamod.Rda` téléchargeable sur
[https://data.inra.fr/](https://data.inra.fr/dataset.xhtml?persistentId=doi:10.15454/ZZWQMN) contient 10 modèles OGAM de désignation des
AOC actuelles qui vont du moins ajusté `gam50` au plus ajusté
`gam900`.

    GamModRaw <- get_file("gamod.Rda", "https://doi.org/10.15454/ZZWQMN")
    writeBin(GamModRaw, "gamod.Rda") ; load("gamod.Rda") ; names(gamod)

    [1] "gam50"  "gam100" "gam200" "gam300" "gam400" "gam500" "gam600"
    [8] "gam700" "gam800" "gam900"

Pour la reproductibilité des analyses, nous reportons ci-dessous
le code pour l'estimation du modèle qui sera utilisé dans
l'application, celui qui s'ajuste le mieux aux données et qui
présente les meilleures prédictions.  La localisation des
parcelles est ajustée avec des fonctions splines cubiques pour un
nombre maximal de degré de liberté effectifs de \(k= 900\).
L'algorithme itératif des moindres carrés pondérés pénalisés est
relativement long à effectuer : environ 9 heures avec un
processeur Intel Core i7-7820HQ CPU 2.90 GHz x8 et 64 Go de RAM.
Le lecteur peut accéder directement au résultat de cette
estimation par l'objet `gamod$gam900` téléchargé précédemment sur
le serveur.

    ## system.time(
    ##     gam900 <- gam(AOC~ 0+ LIBCOM+ EXPO+ GEOL+ PEDO 
    ##                   + s(DEM)+ s(SLOPE)+ s(RAYAT)+ s(X, Y, k= 900)
    ##                 , data= Reg.Ras, family= ocat(R= 5))
    ## )
    ## utilisateur     système      écoulé 
    ##    32271.43       93.78    32366.00 
    library(mgcv) ; anova(gamod$gam900)

    Family: Ordered Categorical(-1,5.34,14.01,20.99) 
    Link function: identity 
    
    Formula:
    AOC ~ 0 + LIBCOM + EXPO + GEOL + PEDO + s(DEM) + s(SLOPE) + s(RAYAT) + 
        s(X, Y, k = 900)
    
    Parametric Terms:
           df Chi.sq p-value
    LIBCOM 31   1363  <2e-16
    EXPO    7    131  <2e-16
    GEOL   14    441  <2e-16
    PEDO   13    388  <2e-16
    
    Approximate significance of smooth terms:
                edf Ref.df Chi.sq p-value
    s(DEM)     8.81   8.98    867  <2e-16
    s(SLOPE)   7.72   8.61    190  <2e-16
    s(RAYAT)   7.33   8.38    531  <2e-16
    s(X,Y)   841.42 870.01  86597  <2e-16

Nous obtenons avec la fonction `anova` la significativité
statistique des différentes variables inclues dans le modèle au
regard des statistiques de \(\chi^2\).  Les variables indicatrices
et les effets fixes sont dans la partie paramétrique (`Parametric
    Terms`, reportée en premier) alors que les variables continues
sont dans la partie lissée (`Approximate significance of smooth
    terms`, reportée en second).  Toutes les variables introduites
dans le modèle sont significatives au seuil de 99 %, ce qui
conforte notre hypothèse d'un modèle de désignation des AOC basé
sur une variable latente de qualité des vignes.  Dans ce modèle,
qui s'ajuste précisément aux données, les coordonnées
géographiques apparaissent les variables explicatives les plus
importantes au sens du \(\chi^2\), suivies des indicatrices
communales, de l'altitude, du rayonnement solaire, de la géologie,
de la pédologie, de la pente et enfin de l'exposition.  Ce modèle
avec un lissage spatial fort produit près de 90 % de bonnes
prédictions des niveaux d'AOC pour un pseudo R\(^2\) (au sens de
McFadden) égal à 0,76.  Les mêmes statistiques peuvent être
obtenues pour les autres modèles présents dans l'objet `gamod`,
moins lissés spatialement, mais ne sont pas reportées ici.  Les
résultats sur la significativité des variables et la forme des
effets sont globalement robustes à l'ajustement des coordonnées
géographiques.

    sum(diag(table(cut(gamod$gam900$line,
                       c(-Inf, gamod$gam900$family$getTheta(TRUE), Inf)),
                       gamod$gam900$model[, 1])))/ nrow(gamod$gam900$model)*100
    1- (logLik(gamod$gam900)/ logLik(update(gamod$gam900, . ~ + 1)))

    [1] 89.48
    'log Lik.' 0.7565 (df=964)


## Effets des variables biophysiques

Les effets marginaux de chaque variable biophysique sur la
variable latente de qualité des vignes, soient les fonctions
\(B(\cdot)\) dans l'équation (1), sont représentés graphiquement
dans la \autoref{Fig:4}.  La fonction `plot`, définie par le
package `mgcv`, permet de représenter facilement chacun de ces
effets additivement séparables.

    plot(gamod$gam700, page= 1, scale= 0)

Des effets en U inversés sont obtenus pour l'altitude et la pente,
avec les vignes les mieux classées en termes d'AOC qui sont
situées à environ 300 mètres d'altitude et 10 degrés de pente.
L'effet du rayonnement solaire est plus linéaire, contrairement à
ce que le troisième quadrant de la Figure peut laisser apparaître.
En effet, la plupart des parcelles sous AOC ont un rayonnement
solaire centré-réduit compris entre \(-2\) et \(2\), soit la partie
linéaire de la courbe représentée.  Enfin, les effets spatiaux en
bas à droite semblent se structurer dans une relation de centre/
périphérie par rapport aux altitudes intermédiaires.  Des figures
plus détaillées, qui contiennent en particulier les effets
associés aux autres modèles moins ajustés spatialement, sont
reportées dans l'article associé <sup id="d5f551e637b0632950381ff3346c5e2e"><a href="#Ay19" title="Ay, The informational content of geographical indications, {en r&#233;vision}, v(), (2019).">Ay19</a></sup>.  Le lecteur peut
aussi reproduire ces effets pour d'autres modèles avec la fonction
`plot` du package `mgcv`.  La structure des effets reste cependant
robuste à l'ajustement des effets spatiaux, elle reste proche de
ce qui est obtenu ici pour le modèle avec `k=900`.


## Effets communaux

Les coefficients associés aux effets communaux sont d'un intérêt
particulier car ils correspondent à la partie historique des AOC
actuellement en vigueur, soit la partie qui est expliquée par une
délimitation administrative et non par des caractéristiques
biophysiques.  Cette interprétation des effets fixes communaux
fait écho à certains travaux d'historiens pour lesquels nos
résultats offrent une confirmation statistique.  En effet, Lucand
dans <sup id="7e3cc4e952baf2ace29bc97117ad514c"><a href="#WJac11" title="Wolikow \&amp; Jacquet, Territoires et terroirs du vin du XVIIIe au XXIe si&#232;cles, &#201;ditions Universitaires de Dijon (2011).">WJac11</a></sup> évoque l'existence d'une hiérarchie implicite
des communes comme des "identifications commerciales communes,
investies d'un plus ou moins grand capital symbolique hérité. Ce
capital symbolique hérité attribut un prestige plus ou moins
grand à certaines communes ou propriétaires particuliers"
(p. 68).  Les effets fixes que nous estimons peuvent alors être
vus comme des mesures de ce capital symbolique.  De manière
complémentaire, <sup id="aabd8d871d4bfd7dce750e0ec786fb3d"><a href="#Jacq09" title="Jacquet, Un si{\`e}cle de construction du vignoble bourguignon. Les  organisations vitivinicoles de 1884 aux AOC, Editions Universitaires de Dijon (2009).">Jacq09</a></sup> étudie la structuration des syndicats
de viticulteurs aux XIXe et XXe siècles, qui s'opère
quasi-exclusivement à l'échelle communale et mentionne le fait
que (p.193) "plus l'appellation requise se calque sur le syndicat
qui la défend, plus elle a de chance d'émerger et d'être
délimitée strictement".  Les effets fixes communaux peuvent donc
également mesurer l'action des syndicats, qui apparaît ainsi
avoir une forte inertie historique.

Pour faciliter l'interprétation des effets fixes communaux, nous
traduisons les coefficients estimés en mesures de supériorités
ordinales \(\gamma_{A}\) pour la commune \(A\) par rapport à la
commune moyenne de la zone <sup id="ba4181a0e7dae7fbb217e69ee0b575b4"><a href="#AKat17" title="Agresti \&amp; Kateri, Ordinal probability effect measures for group comparisons in  multinomial cumulative link models, {Biometrics}, v(1), 214--219 (2017).">AKat17</a></sup>.  Par définition,

où \(\mu_A\) représente l'effet fixe de la commune \(A\) et
\(\overline{\mu}\) la moyenne des effets fixes sur la zone
d'intérêt.  Ainsi, cette mesure de supériorité ordinale comprise
entre \(-1\) et 1 représente l'écart de probabilité qu'une parcelle
de la commune \(A\) soit mieux classée qu'une parcelle aux
caractéristiques biophysiques identiques mais localisée dans une
commune au hasard.  Des valeurs positives indiquent des communes
avantagées et des valeurs négatives des communes désavantagées
par les désignations AOC.  Le code suivant calcule ces mesures
pour l'ensemble des communes de la zone et les représente
graphiquement dans la \autoref{Fig:3}.  Les objets `plogi` et
`mso.key` requis pour l'évaluation du code sont définis en
Annexe 2.

    library(latticeExtra) ; resum900 <- summary(gamod$gam900)
    cf <- resum900$p.coeff[ 4: 31]- mean(resum900$p.coeff[ 4: 31])
    dat.fig <- data.frame(LIBCOM=substr(names(gamod$gam900$coef[ 4: 31]),7,30),
                          REGION= c(rep("tomato", 12), rep("chartreuse", 16)),
                          OS= 2* plogi(cf)- 1,
                          OSi= 2* plogi(cf- 1.5* resum900$se[ 4: 31])- 1,
                          OSa= 2* plogi(cf+ 1.5* resum900$se[ 4: 31])- 1)
    segplot(reorder(factor(LIBCOM), OS)~ OSi+ OSa,
            length= 5, draw.bands= T, key= mso.key,
            data= dat.fig[order(dat.fig$OS), ], center= OS, type= "o",
            col= as.character(dat.fig$REGION[order(dat.fig$OS)]),
            unit = "mm", axis = axis.grid, col.symbol= "black", cex= 1, 
            xlab= "Mesure de supériorité ordinale et intervalles à 10 %")

Les communes relativement favorisées par la classification des AOC
apparaissent en haut de la \autoref{Fig:3} et les communes
relativement défavorisées en bas.  Les intervalles de confiance
qui encadrent les valeurs moyennes sont différents de ceux
reportés dans <sup id="d5f551e637b0632950381ff3346c5e2e"><a href="#Ay19" title="Ay, The informational content of geographical indications, {en r&#233;vision}, v(), (2019).">Ay19</a></sup>.  Ils représentent ici l'incertitude
associée à l'estimation des effets fixes communaux plutôt que
l'incertitude associée à la spécification du lissage spatial.  Les
ordres de grandeur obtenus pour ces deux sources d'incertitude
sont toutefois similaires.  Nous observons que certaines mesures
de supériorité ordinale suivent la hiérarchie des dotations brutes
en AOC telles que présentées dans la \autoref{Fig:2} de la Section
2.1, où les communes privilégiées sont celles qui possèdent les
plus grosses proportions d'AOC en haut de la hiérarchie (Premiers
crus et Grands crus).  Mais cette relation n'est pas systématique,
certaines communes peu dotées en hauts niveaux d'AOC apparaissent
également privilégiées.  Parmi les 5 communes les plus
privilégiées par la classification AOC, les communes de Vougeot et
d'Aloxe-Corton sont relativement bien dotées en Premiers et Grands
Crus, alors que ce n'est pas le cas pour les communes de
Pernand-Vergelesses et de Chorey-les-Beaunes.  À l'inverse,
Chassagne-Montrachet ou Vosnes-Romanée possèdent de fortes
proportions de Premiers et Grands Crus, sans que cela semble
venir, au regard de nos résultats, d'un traitement préférentiel
dans la classification.


## Prédiction de la qualité continue

Les prédictions de la variable latente associée au modèle OGAM
vont représenter les valeurs estimées de la qualité des vignes au
sens des AOC actuelles pour chacune des parcelles de la zone.
Nous obtenons ainsi un score continue pour chaque parcelle
uniquement selon ses caractéristiques biophysiques et, selon que
l'on prenne ou pas en compte sa commune d'appartenance, le
traitement préférentiel dont elle a fait l'objet au cours de
l'histoire.  Notons que cette classification statistique des
parcelles est directement issue des AOC qui existent aujourd'hui
et ne se base pas sur des appréciations subjectives exogènes sur
ce qui fait la qualité d'une vigne ou d'un vin.  Le code suivant
présente le calcul des prédictions et leur normalisation pour
qu'elles soient distribuées entre 0 et 100 (avec la fonction
`unini`), pour l'ensemble des parcelles de la base `Prd.Ras`.
Notons que la ligne sur les prédictions, commentée, est assez
longue à évaluer dans `R` (5 minutes).

    Prd.Ras <- subset(Geo.Ras, !is.na(AOClb))
    Prd.Ras$GEOL <- ifelse(Prd.Ras$NOTATION%in%levels(gamod$gam900$model$GEOL),
                           as.character(Prd.Ras$NOTATION), "0AREF")
    Prd.Ras$PEDO <- ifelse(Prd.Ras$NOUC %in% levels(gamod$gam900$model$PEDO),
                           as.character(Prd.Ras$NOUC), "0AREF")
    ## prd <- predict(gamod$gam900, newdata= Prd.Ras@data, type= "terms")
    Prd.Ras$LTraw <- rowSums(prd, na.rm= TRUE)
    Prd.Ras$LTcor <- mean(prd[, 1], na.rm= T)+ rowSums(prd[, -1], na.rm= T)
    unini <- function(x) (x- min(x))/ (max(x)- min(x))
    Prd.Ras$UFraw <- round(unini(Prd.Ras$LTraw)* 100, 2)
    Prd.Ras$UFcor <- round(unini(Prd.Ras$LTcor)* 100, 2)
    lapply(Prd.Ras@data[, c("UFraw", "UFcor")], summary)

    $UFraw
       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
        0.0    67.0    72.5    70.6    75.6   100.0 
    
    $UFcor
       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
        0.0    67.4    71.7    70.8    76.6   100.0

Les prédictions sont donc disponibles avec (`UFcor`) et sans
(`UFraw`) correction des effets communaux afin que, en plus de
pouvoir consulter le classement corrigé, l'utilisateur puisse
apprécier le niveau du biais communal dans la classification
actuelle des AOC.  Nous avons normalisé ces deux variables pour
produire un score de classification des parcelles selon des
valeurs comprises entre 0 et 100, avec des distributions qui
apparaissent aplaties à gauche (les médianes sont supérieures aux
moyennes).


## Agrégation par lieux-dits

Pour faciliter la consultation de ces résultats dans
l'application *Shiny*, nous agrégeons les scores prédits au
niveau des parcelles sur la base d'un recodage des dénominations
et des lieux-dits.  Nous utilisons pour cela les lieux-dits
administratifs qui permettent en outre de localiser plus
précisément les parcelles en niveaux Coteaux bourguignons,
Bourgogne régional et Village pour lesquels la mention de la
parcelle n'est pas reportée systématiquement sur l'étiquette des
bouteilles de vin (cette pratique est néanmoins de plus en plus
fréquente en Côte d'Or).  Il s'agit également ici de renommer les
dénominations géographiques complémentaires associées aux
Premiers crus pour qu'ils soient plus lisibles dans
l'application.

    Prd.Ras$NIVEAU <- as.character(revalue(factor(Prd.Ras$AOC), NVA))
    Prd.Ras$NAME <- ifelse(Prd.Ras$AOC== 5, as.character(Prd.Ras$AOClb),
                    ifelse(Prd.Ras$AOC< 4, as.character(Prd.Ras$LIEUDIT), NA))
    for (i in 1: nrow(Prd.Ras)){
        if (is.na(Prd.Ras$NAME[ i])){
            Prd.Ras$NAME[ i] <- substr(Prd.Ras$AOClb[ i],
                                       regexpr(" cru+", Prd.Ras$AOClb[ i],
                                               perl= T)+ 5,
                                       nchar(as.character(Prd.Ras$AOClb[ i])))
        } else {(Prd.Ras$NAME[ i])}
    }
    Prd.Ras$Concat <- paste0(Prd.Ras$AOC, Prd.Ras$LIBCOM, Prd.Ras$NAME)
    length(unique(Prd.Ras$Concat))

    [1] 2391

Ainsi, à partir des \(60\,000\) parcelles cadastrales utilisées
pour estimer le modèle statistique de classification, nous
obtenons environ \(2\,400\) localités, qui correspondent aux
lieux-dits pour les niveaux Coteaux Bourguignons, Bourgogne
régional, et Village ; ils correspondent aux dénominations
retravaillées pour les Premiers crus ; et aux appellations pour
les Grands Crus. Cela fait une moyenne de 25 parcelles par
localité.

Nous allons désormais fusionner la géographie des parcelles selon
la variable `Contat` tout juste créée pour agréger les scores
prédits.  Les scores alors reportés au niveau des nouvelles
localités seront calculés par moyennes pondérées par la surface
de chaque parcelle qui les compose.  Nous calculons également la
position de chaque localité dans la hiérarchie continue issue de
la modélisation par rapport à l'ensemble des localités de la zone
(avec les variables `RANG_brut` et `RANG_corrigé`), ce qui permet
de présenter, en sortie du code ci-dessous, les 10 localités les
mieux notées sur la base des scores corrigés.

    library(data.table) ; Prd.Dtb <- data.table(Prd.Ras@data)
    Dat.Ldt <- Prd.Dtb[, .(LIBCOM= LIBCOM[ 1], NOM= NAME[ 1],
                           NIVEAU= NIVEAU[ 1],
                           SURFACE_ha= round(sum(AREA)/ 1e4, 2),
                           SCORE_brut= round(weighted.mean(UFraw, AREA), 2),
                           SCORE_corrigé=round(weighted.mean(UFcor, AREA), 2)), by= Concat]
    library(rgdal) ; library(rgeos) ; library(maptools)
    tmp_geo <- gBuffer(Prd.Ras, byid= TRUE, width= 0)    
    Poly.ldt <- unionSpatialPolygons(tmp_geo, Prd.Ras$Concat)
    Poly.ldt$Concat <- as.character(row.names(Poly.ldt))
    Poly.Ras <- merge(Poly.ldt, Dat.Ldt, by= "Concat")
    Poly.Ras$RANG_brut<- round(rank(Poly.Ras$SCORE_brut)/ nrow(Poly.Ras)*100,2)
    Poly.Ras$RANG_corrigé <- round(rank(Poly.Ras$SCORE_corrigé)/
                                   nrow(Poly.Ras)*100,2)
    head(Poly.Ras@data[order(Poly.Ras$RANG_corrigé, decreasing= T), c(3, 4, 6, 7)], n= 10)
    Poly.Ras$NIVEAU <- factor(Poly.Ras$NIVEAU, levels= NVA)

                            NOM      NIVEAU SCORE_brut SCORE_corrigé
    2364             Chambertin   Grand cru      94.22         94.11
    2363       Grands-Echezeaux   Grand cru      87.73         90.76
    2384             Montrachet   Grand cru      88.72         90.69
    2381      Bâtard-Montrachet   Grand cru      87.73         89.68
    2361             Montrachet   Grand cru      87.05         89.58
    2362              Echezeaux   Grand cru      86.13         89.12
    2369 Latricières-Chambertin   Grand cru      88.73         88.53
    2371   Mazoyères-Chambertin   Grand cru      88.71         88.50
    2359      Bâtard-Montrachet   Grand cru      85.80         88.30
    2010      La Combe d'Orveau Premier cru      91.01         87.83

Comme on pouvait s'y attendre avec le pourcentage de bonnes
prédictions obtenu, les Grands Crus arrivent en haut de la
classification statistique, qu'ils appartiennent à la côte de
Nuits (comme Chambertin et Grands-Echezeaux) ou à la côte de
Beaune (comme Montrachet et Bâtard-Montrachet).  Notons tout de
même qu'un Premier cru arrive en dixième position, ce qui
signifie qu'il dépasse les 2/3 des Grands crus de la zone.  Ce
Premier cru qui a pour dénomination "La Combe d'Orveau" se
trouve sur la commune de Chambolle-Musigny, qui n'apparaît pas,
par ailleurs, relativement désavantagée selon la
\autoref{Fig:3}.  Cela indique que la haute classification de ce
Premier cru (en particulier au-dessus du Grand cru "Musigny"
situé sur la même commune) provient des caractéristiques
biophysiques et non de la correction communale.  Également
étonnant, le Grand cru la "Romanée-Conti" qui apparaît souvent
parmi les vins les plus chers du monde
(<https://www.wine-searcher.com/most-expensive-wines>) n'apparaît
qu'en 26e position. Le lieu-dit est tout de même dans les 2 %
meilleures localités de la zone.  Les résultats amènent à penser
que la situation de monopole du domaine de la Romanée-Conti qui
exploite ce climat peut expliquer le fort prix observé des
bouteilles, indépendamment des caractéristiques biophysiques.

Nous enregistrons ensuite les résultats agrégés de la prédiction
dans un objet de type `sf` défini par le package du même nom
<sup id="d28fa3b046391e9f1547f8ad0fb60b70"><a href="#Pebe18" title="Edzer Pebesma, {Simple Features for R: Standardized Support for Spatial Vector Data}, {{The R Journal}}, v(1), 439--446 (2018).">Pebe18</a></sup>. Cette objet nommé `Poly.Ras` pourra directement
être utilisée dans l'application *Shiny* pour consulter, lancer,
ou modifier le classement statistique que nous avons obtenu.  Les
résultats issus du recodage des dénominations et de l'agrégation
des scores prédits sont accessibles sur le serveur data de l'INRA
à l'adresse [https://data.inra.fr/](https://data.inra.fr/), qui peut être aussi chargée
comme précédemment avec le package `dataverse`.

    library(sf) ; Poly.Ras <- st_as_sf(Poly.Ras)
    Poly.Ras <- st_transform(Poly.Ras, crs= 4326)
    save(Poly.Ras, file= "Inter/PolyRas.Rda")
    st_write(Poly.Ras, "/home/jsay/geoInd/Application2/Inter/PolyRas.shp",
             delete_layer= TRUE)


<a id="Sec:4"></a>

# Application *Shiny*

Il y a deux manières d'utiliser l'application *Shiny* <sup id="834ac534f77f47a4c55b352119d1a346"><a href="#CCAX19" title="@Manual{CCAX19,
    title = {shiny: Web Application Framework for {R}},
    author = {Winston Chang and Joe Cheng and JJ Allaire and Yihui Xie
                  and Jonathan McPherson},
    year = {2019},
    note = {R package version 1.4.0},
    url = {https://CRAN.R-project.org/package=shiny},
  }">CCAX19</a></sup>
pour consulter la classification statistique.  Le lecteur peut
consulter l'application sur internet à l'adresse
[https://cesaer-datas.inra.fr/geoind/](https://cesaer-datas.inra.fr/geoind/) (cf. sous-section 4.3), ou
alors installer l'application en local (à partir des données et
codes téléchargés sur le serveur [https://data.inra.fr/](https://data.inra.fr/)) en suivant
la procédure décrite dans les deux sous-sections suivantes.


## Carte dynamique

Une première étape pour générer l'application localement consiste
à définir une carte dynamique, de type `Leaflet`, grâce au
package `mapview` <sup id="a73e7107e57e4bb16786b47e76ff2f7c"><a href="#ADRW18" title="@Manual{ADRW18,
    title = {mapview: Interactive Viewing of Spatial Data in R},
    author = {Tim Appelhans and Florian Detsch and Christoph
                  Reudenbach and Stefan Woellauer},
    year = {2018},
    note = {R package version 2.6.3},
    url = {https://CRAN.R-project.org/package=mapview},
  }">ADRW18</a></sup>, qui sera ensuite intégrée à
l'application.  Cela nécessite la présence de l'objet `Poly.Ras`,
issu des traitements précédents, dans le répertoire de travail.

    library(RColorBrewer) ; library(mapview) ; library(sf)
    Poly.Ras <- st_read("Inter/PolyRas.shp")
    Poly.Ras$NIVEAU <- factor(Poly.Ras$NIVEAU,
                              levels= c("Coteaux b.", "Bourgogne", "Village",
                                        "Premier cru", "Grand cru"))
    AocPal <- brewer.pal(5, "BuPu")
    mapviewOptions(basemaps= c("Esri.WorldImagery", "OpenStreetMap",
                               "OpenTopoMap", "CartoDB.Positron"),
                   raster.palette= colorRampPalette(brewer.pal(9, "Greys")),
                   vector.palette= colorRampPalette(brewer.pal(9, "YlGnBu")),
                   na.color= "magenta", layers.control.pos = "topleft")
    map <- mapview(Poly.Ras, zcol= "NIVEAU", label= Poly.Ras$NOM,
                   layerId= Poly.Ras$Concat, alpha.regions= .5,
                   col.regions = AocPal, color= "white", legend.opacity= .5,
                   popup = popupTable(Poly.Ras, feature.id= FALSE,
                                      zcol= names(Poly.Ras)[ -1]))

L'objet `map` ainsi créé permet de faire apparaître sur un
navigateur internet une carte dynamique pour visualiser les
différentes parcelles viticoles de la zone et faire apparaître le
score (corrigé des effets communaux ou pas) suite à un clic sur
une parcelle donnée.  Il apparaît alors le nom de la commune
d'appartenance (`LIBCOM`), le nom du lieu-dit (`NOM`), le niveau
dans la hiérarchie des AOC (`NIVEAU`), la surface du lieu-dit
(`SURFACE`), le score brut (`SCORE_b`) et corrigé (`SCORE_c`),
ainsi que la position du lieu dit dans la hiérarchie générale de
la région (`RANG_br` pour la version brute et `RANG_cr` pour la
version corrigée).


## Lancer l'application localement

Une fois la carte dynamique `map` créée, le code précédent et le
code suivant doivent être enregistrés dans un fichier `global.R`
en accord avec la structuration habituelle des applications
*Shiny* <sup id="834ac534f77f47a4c55b352119d1a346"><a href="#CCAX19" title="@Manual{CCAX19,
    title = {shiny: Web Application Framework for {R}},
    author = {Winston Chang and Joe Cheng and JJ Allaire and Yihui Xie
                  and Jonathan McPherson},
    year = {2019},
    note = {R package version 1.4.0},
    url = {https://CRAN.R-project.org/package=shiny},
  }">CCAX19</a></sup>.  Les deux autres scripts `ui.R` et
`server.R` nécessaires pour lancer localement l'application
*Shiny* sont reportés en Annexes 5 et 6.  Ils contiennent
respectivement le paramétrage de l'interface utilisateur et les
calculs qui sont effectués sur le serveur pour l'interactivité de
l'application.  Le code ci-dessous `source` ces deux fichiers qui
sont également disponibles sur un répertoire distant
[https://github.com/jsay/geoInd/](https://github.com/jsay/geoInd/tree/master/Application).

    library(shiny) ; library(shinydashboard) ; library(shinyjs)
    library(leaflet) ; library(maptools) ; library(ggplot2)
    library(markdown)
    Pts.Crd <- st_centroid(Poly.Ras)
    source("ui.R") ; source("server.R")
    enableBookmarking(store = "url")
    shinyApp(ui,server)

La commande `shinyApp(ui,server)` lance l'application dans le
navigateur internet par défaut, et permet d'obtenir localement le
même résultat que la version en ligne de l'application.


## Exemple d'utilisation

L'application est structurée en trois parties : en haut à gauche,
trois zones de saisie permettent de renseigner par menus
déroulants directement le nom d'une localité (à partir des
informations typiquement disponibles sur l'étiquette d'une
bouteille de vin ou à partir des connaissances personnelles de
l'utilisateur) ; en bas à gauche, un graphique positionne la
qualité de la localité sélectionnée dans la distribution générale
des qualités (où les niveaux d'appellation sont différentiés) ; à
droite la carte dynamique permet de faire apparaître la localité
sélectionnée.  L'utilisateur peut sélectionner un vin par ses
références mais peut aussi se déplacer librement sur le périmètre
d'étude, dans les parcelles voisines d'un lieu-dit par exemple.
Ainsi, un clic sur une parcelle permet de faire apparaître ses
caractéristiques, les prévisions corrigées et non corrigées en
particulier.

Prenons l'exemple d'un vin de niveau Premier cru, sur la commune
de Flagey-Echezeaux, qui a pour nom de lieu-dit (dénomination
géographique complémentaire en l'occurrence) "Les Rouges".  Suite
à la saisie de ces caractéristiques dans les zones dédiées en haut
à gauche, le score corrigé prédit pour ce vin égal à 83,82
apparaît dans le graphique en bas à gauche de l'application.  Ce
score est supérieur à l'ensemble des Coteaux bourguignons, des
Bourgognes régionaux et des villages du périmètre de l'étude.  Ce
vin de niveau Premier cru est parmi les 10 % des Premiers crus qui
ont les plus hauts scores et il dépasse même 30 % des Grands crus
du périmètre.  La partie à droite de l'application a zoomé sur
cette zone, un clic sur le lieu-dit en question permet de faire
apparaître la différence entre les prédictions brutes et
corrigées.  Ainsi, le score non corrigé de la localité est
sensiblement plus bas (80,92), ce qui implique que suite à la
correction des effets communaux, le vin passe du top 7 % au top 3
% sur l'ensemble de la zone étudiée.  Ce résultat est consistant
avec les effets communaux reportés dans la Figure 5, où la commune
de Flagey-Echezeaux apparaît comme relativement défavorisée dans
la hiérarchie.  D'après la carte reportée dans l'application, on
peut constater que ce Premier cru est mitoyen du Grand cru
Echezeaux qui se trouve tout juste à l'est.


# Conclusion

Ce travail détaille, de façon reproductible, toutes les étapes qui
permettent de construire une base de données des parcelles
cadastrales de 31 communes viticoles de la Côte-d'Or.  La base
contient les caractéristiques géométriques des parcelles ainsi que
leur classement AOC et leurs informations biophysiques (topographie,
géologie, pédologie).  Les données de cette recherche sont ensuite
utilisées pour modéliser statistiquement, pas-à-pas, les
classifications AOC du périmètre d'étude.  Les résultats sont
restitués via une application de cartographie interactive de type
*Shiny*.  Toutes les étapes de la mis en oeuvre et les modalités de
consultation sont décrites dans l'article.

La classification statistique obtenue permet de préciser la
hiérarchie des AOC actuelles.  Il est important de mentionner que
cette classification se base exclusivement sur les caractéristiques
biophysiques des parcelles et ne contient aucune appréciation
subjective exogène sur leur pondération ni sur l'importance d'autres
facteurs (olfactifs, de réputation, de prix) en lien avec des
références subjectives de la qualité d'un vin.  L'approche
statistique permet en outre de corriger les effets communaux issus
des arbitrages politiques qui ont eu lieu au cours de l'histoire, et
qui apparaissent avoir une influence sur le classement AOC sans que
ce soit justifié du point de vue des caractéristiques biophysiques
des parcelles.  La classification obtenue est donc directement
déduite de la hiérarchie actuelle des AOC qui, au regard de la
hiérarchie de prix qu'elle produit, est une information jugée
crédible pour les acteurs des marchés du vin <sup id="d5f551e637b0632950381ff3346c5e2e"><a href="#Ay19" title="Ay, The informational content of geographical indications, {en r&#233;vision}, v(), (2019).">Ay19</a></sup>.

En revanche, le modèle proposé n'est pas déterministe et de
l'incertitude persiste dans la classification obtenue.  La
hiérarchie des parcelles dépend de la spécification du modèle
statistique et le fait d'avoir favorisé des variables biophysiques
pour décrire la relation entre les lieux de production et la qualité
des vins peut faire débat, par opposition aux facteurs humains qui
ont un effet indéniable sur la qualité des vins.  Le débat sur
l'articulation des facteurs humains et des facteurs naturels de la
qualité du vin existe depuis plus d'un demi-siècle et produit des
discussions toujours d'actualité <sup id="295ae69c19e4b3eca519fcac1e12d462"><a href="#DChe15" title="Delay \&amp; Chevallier, Roger {D}ion, toujours vivant!, {Cybergeo: European Journal of Geography}, v(), (2015).">DChe15</a></sup><sup>,</sup><sup id="2a22ed4f28a88b0ca8826f77f697e411"><a href="#LLDe19" title="Lammoglia, Leturcq \&amp; Delay, Le mod{\`e}le {VitiTerroir} pour simuler la dynamique  spatiale des vignobles sur le temps long  (1836-2014), {Cybergeo: European Journal of Geography}, v(), (2019).">LLDe19</a></sup>.  C'est pour
alimenter ce débat que les analyses présentées dans cet article sont
totalement reproductibles à partir de la base de donnée mise à
disposition.  Les codes pour l'estimation du modèle sont reportés
dans l'article, afin de permettre l'estimation de modèles
alternatifs.  L'appariement de données supplémentaires pour relier
les AOC aux caractéristiques des lieux est également possible par la
géolocalisation des parcelles cadastrales.  La transparence des
analyses permet aux résultats d'être discutés et contestés afin de
faire l'objet d'une appropriation par les chercheurs, les décideurs,
les professionnels du secteur, ou les amateurs de vin.


## Remerciements

Nous tenons à remercier Pauline Mialhe (CRC, Centre de Recherches
de Climatologie, Laboratoire Biogéosciences - Université de
Bourgogne), Vincent Larmet et Guillaume Royer (INRA CESAER, Centre
d'Economie et de Sociologie appliqués à l'Agriculture et aux
Espaces Ruraux) pour leur aide sur le développement de
l'application issue de cette recherche.


# Bibliography
<a id="Garc11"></a>[Garc11] Garcia, Les \emphclimats du vignoble de Bourgogne comme  patrimoine mondial de l'humanit\'e, Ed. Universitaires de Dijon (2011). [↩](#121170804c03a6ffd9b6598b03e5ae59)

<a id="WJac11"></a>[WJac11] Wolikow & Jacquet, Territoires et terroirs du vin du XVIIIe au XXIe siècles, Éditions Universitaires de Dijon (2011). [↩](#7e3cc4e952baf2ace29bc97117ad514c)

<a id="Capu47"></a>[Capu47] Capus, L'\'Evolution de la l\'egislation sur les appellations  d'origine. Gen\`ese des appellations  contr\^ol\'ees, L. Larmat (1947). [↩](#95abb746101aa32ae2b154f5bdee7ad0)

<a id="Humb11"></a>[Humb11] @phdthesisHumb11,
  title=L'INAO, de ses origines \`a la fin des ann\'ees 1960:
                  gen\`ese et \'evolutions du syst\`eme des vins
                  d'AOC,
  author=Humbert, Florian,
  year=2011,
  school=Universit\'e de Bourgogne
 [↩](#36d1387edd76d672ddb30e2817a44c44)

<a id="CMar04"></a>[CMar04] Coestier & Marette, Economie de la qualit\'e, La d\'ecouverte (2004). [↩](#90e8d3da1815242f3136e232bea3b79b)

<a id="Dion52"></a>[Dion52] Dion, Querelle des anciens et des modernes sur les facteurs de la qualit\'e du vin, <i>Annales de g\'eographie</i>, <b>61(328)</b>, 417-431 (1952). [↩](#179cacf6073e0a5bd2c08b8f57141208)

<a id="Ay19"></a>[Ay19] Ay, The informational content of geographical indications, <i>en révision</i>,  (2019). [↩](#d5f551e637b0632950381ff3346c5e2e)

<a id="HJRV18"></a>[HJRV18] Hilal, Joly, Roy & Vuidel, Visual structure of landscapes seen from built environment, <i>Urban Forestry & Urban Greening</i>, <b>32</b>, 71-80 (2018). [↩](#04c03aec0f1658f1e579f642294535bc)

<a id="WPSa16"></a>[WPSa16] Wood, Pya & S\"afken, Smoothing parameter and model selection for general smooth models, <i>Journal of the American Statistical Association</i>, <b>111(516)</b>, 1548-1563 (2016). [↩](#288ff4c397fcb33b93de861cedf4c4e5)

<a id="CCAX19"></a>[CCAX19] @ManualCCAX19,
    title = shiny: Web Application Framework for R,
    author = Winston Chang and Joe Cheng and JJ Allaire and Yihui Xie
                  and Jonathan McPherson,
    year = 2019,
    note = R package version 1.4.0,
    url = https://CRAN.R-project.org/package=shiny,
   [↩](#834ac534f77f47a4c55b352119d1a346)

<a id="Core19"></a>[Core19] @ManualCore19,
title = R: A Language and Environment for Statistical Computing,
author = R Core Team,
organization = R Foundation for Statistical Computing,
address = Vienna, Austria,
year = 2019,
url = http://www.R-project.org/,
 [↩](#4a3b4bb79c4511e11e837fb04f7b66b0)

<a id="CBBD15"></a>[CBBD15] Conrad, Bechtel, Bock, , Dietrich, Fischer, Gerlitz, , Wehberg, Wichmann, & B\"ohner, System for automated geoscientific analyses (SAGA) v. 2.1. 4, <i>Geoscientific Model Development</i>, <b>8(7)</b>, 1991-2007 (2015). [↩](#f8a440497b1cd6ff02337891691ca6f3)

<a id="Leep17"></a>[Leep17]   @ManualLeep17,
    title = dataverse: R Client for Dataverse 4,
    author = Thomas J. Leeper,
    year = 2017,
    note = R package version 0.2.0,
   [↩](#6d166ff2ee01be4cb1f7664f2b5c9dd2)

<a id="BPGR13"></a>[BPGR13] Roger Bivand, Edzer Pebesma & Virgilio Gomez-Rubio, Applied spatial data analysis with R, Second edition, Springer, NY (2013). [↩](#d9b8eba189b5d10464e23f2df05daf7f)

<a id="Lava55"></a>[Lava55] Lavalle, Histoire et statistique de la vigne et des grands vins de  la Côte d'Or, Daumier, Dijon (1855). [↩](#840f03a33b6be088fc48b363669ed75e)

<a id="Luca17"></a>[Luca17] Lucand, Le vin et la guerre: Comment les nazis ont fait main basse  sur le vignoble fran\ccais, Armand Colin (2017). [↩](#a2b61fcab0e2c21259e8b2462f32d1b6)

<a id="Hila20"></a>[Hila20] Hilal, Land Use Land Cover High Resolution Map (5-m) for Côte-d’Or  (21), <i>Portail Data INRAE</i>, <b>https://doi.org/10.15454/ECLYGT</b>, (2020). [↩](#8a2f7acf7c07300154df56c90df0c68b)

<a id="RFu00"></a>[RFu00] Rich & Fu, Topoclimatic Habitat Models, <i>Proceedings of the Fourth International Conference on
                  Integrating GIS and Environmental Modeling</i>,  (2000). [↩](#b5726be6c56a4db97e85e4116e63bb65)

<a id="Ay11"></a>[Ay11] @phdthesisAy11,
  TITLE = Hétérogénéité de la terre et rareté économique,
  AUTHOR = Ay, Jean-Sauveur,
  URL = https://tel.archives-ouvertes.fr/tel-00629142,
  SCHOOL = Universit\'e de Bourgogne,
  YEAR = 2011,
  MONTH = Jul,
  TYPE = Theses,
  PDF = https://tel.archives-ouvertes.fr/tel-00629142/file/THESE.pdf,
  HAL_ID = tel-00629142,
  HAL_VERSION = v1,
 [↩](#208d1d7a07cf6fffe3fa96d1717b7a1f)

<a id="AKat17"></a>[AKat17] Agresti & Kateri, Ordinal probability effect measures for group comparisons in  multinomial cumulative link models, <i>Biometrics</i>, <b>73(1)</b>, 214-219 (2017). [↩](#ba4181a0e7dae7fbb217e69ee0b575b4)

<a id="Wood17"></a>[Wood17] Wood, Generalized additive models: An introduction with R, Chapman and Hall/CRC, second edition (2017). [↩](#7428cca95c8f1a0339bd46afd86d6e00)

<a id="Jacq09"></a>[Jacq09] Jacquet, Un si\`ecle de construction du vignoble bourguignon. Les  organisations vitivinicoles de 1884 aux AOC, Editions Universitaires de Dijon (2009). [↩](#aabd8d871d4bfd7dce750e0ec786fb3d)

<a id="Pebe18"></a>[Pebe18] Edzer Pebesma, Simple Features for R: Standardized Support for Spatial Vector Data, <i>The R Journal</i>, <b>10(1)</b>, 439-446 (2018). <a href="https://doi.org/10.32614/RJ-2018-009">link</a>. <a href="http://dx.doi.org/10.32614/RJ-2018-009">doi</a>. [↩](#d28fa3b046391e9f1547f8ad0fb60b70)

<a id="ADRW18"></a>[ADRW18] @ManualADRW18,
    title = mapview: Interactive Viewing of Spatial Data in R,
    author = Tim Appelhans and Florian Detsch and Christoph
                  Reudenbach and Stefan Woellauer,
    year = 2018,
    note = R package version 2.6.3,
    url = https://CRAN.R-project.org/package=mapview,
   [↩](#a73e7107e57e4bb16786b47e76ff2f7c)

<a id="DChe15"></a>[DChe15] Delay & Chevallier, Roger Dion, toujours vivant!, <i>Cybergeo: European Journal of Geography</i>, <b>GeOpenMod, document 721</b>, (2015). [↩](#295ae69c19e4b3eca519fcac1e12d462)

<a id="LLDe19"></a>[LLDe19] Lammoglia, Leturcq & Delay, Le mod\`ele VitiTerroir pour simuler la dynamique  spatiale des vignobles sur le temps long  (1836-2014), <i>Cybergeo: European Journal of Geography</i>, <b>GeOpenMod, document 820</b>, (2019). [↩](#2a22ed4f28a88b0ca8826f77f697e411)


# Annexes

**Annexe 1 : Configuration logicielle**

    sessionInfo()

    R version 3.6.0 (2019-04-26)
    Platform: x86_64-pc-linux-gnu (64-bit)
    Running under: Ubuntu 18.04.2 LTS
    
    Matrix products: default
    BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.7.1
    LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.7.1
    
    locale:
     [1] LC_CTYPE=fr_FR.UTF-8       LC_NUMERIC=C              
     [3] LC_TIME=fr_FR.UTF-8        LC_COLLATE=fr_FR.UTF-8    
     [5] LC_MONETARY=fr_FR.UTF-8    LC_MESSAGES=fr_FR.UTF-8   
     [7] LC_PAPER=fr_FR.UTF-8       LC_NAME=C                 
     [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    [11] LC_MEASUREMENT=fr_FR.UTF-8 LC_IDENTIFICATION=C       
    
    attached base packages:
    [1] stats     graphics  grDevices utils     datasets  methods  
    [7] base     
    
    other attached packages:
    [1] latticeExtra_0.6-28 lattice_0.20-38     mgcv_1.8-28        
    [4] nlme_3.1-140        rgdal_1.3-6         sf_0.7-2           
    [7] mapview_2.6.3       RColorBrewer_1.1-2  sp_1.3-1           
    
    loaded via a namespace (and not attached):
     [1] Rcpp_1.0.0        compiler_3.6.0    later_0.7.5      
     [4] base64enc_0.1-3   class_7.3-15      tools_3.6.0      
     [7] digest_0.6.18     satellite_1.0.1   viridisLite_0.3.0
    [10] png_0.1-7         Matrix_1.2-17     shiny_1.2.0      
    [13] DBI_1.0.0         crosstalk_1.0.0   e1071_1.7-0      
    [16] raster_2.8-4      htmlwidgets_1.3   stats4_3.6.0     
    [19] classInt_0.3-1    leaflet_2.0.2     grid_3.6.0       
    [22] webshot_0.5.1     R6_2.4.0          magrittr_1.5     
    [25] scales_1.0.0      codetools_0.2-16  promises_1.0.1   
    [28] htmltools_0.3.6   units_0.6-2       splines_3.6.0    
    [31] mime_0.6          xtable_1.8-3      colorspace_1.3-2 
    [34] httpuv_1.4.5      munsell_0.5.0

**Annexe 2 : Configuration graphique**

    ## Pour Figure 2
    my.lab= c(BGOR= "Coteaux b.", BOUR= "Bourgogne", VILL= "Village",
              PCRU= "Premier cru", GCRU= "Grand cru")
    library(RColorBrewer)
    my.pal= brewer.pal(n= 9, name = "BuPu")[ 2: 8]
    library(lattice)
    my.key= list(space= "top", points= F, rectangles= T, columns= 5, text= my.lab)
    my.par= list(superpose.polygon= list(col= my.pal))
    my.pan= function(x, y, ...) {
                 panel.grid(h= 0, v = -11, col= "grey60")
                 panel.barchart(x, y, ...)
                 ltext(fig.crd, y, lab= ifelse(fig.lab> 0, fig.lab, ""))}
    ## Pour Tableau 7
    library(stargazer)          
    tb.lab <-
        c(AREA= "Surface [1000 m$^2$]", DEM= "Altitude [1000 m]",
          SLOPE= "Pente [degrés]", SOLAR=  "Radiation solaire [millions J]",
          X= "Longitude [degrés]", Y= "Latitude [degrés]",
          AOC1= "Niveau AOC Coteaux", AOC2= "Niveau AOC Régional",
          AOC3= "Niveau AOC Village", AOC4= "Niveau AOC Premier Cru",
          AOC5= "Niveau AOC Grand Cru",
          EXPO1= "Exposition [$0-45$]"   , EXPO2= "Exposition [$45-90$]",
          EXPO3= "Exposition [$90-135$]" , EXPO4= "Exposition [$135-180$]",
          EXPO5= "Exposition [$180-225$]", EXPO6= "Exposition [$225-270$]",
          EXPO7= "Exposition [$270-315$]", EXPO8= "Exposition [$315-360$]")
    ## Pour Figure 4
    plogi <- function(x) exp(x/ sqrt(2))/ (1+ exp(x/ sqrt(2)))
    mso.key <- list(x = .35, y = .95, corner = c(1, 1),
                text = list(c("Côte de Beaune", "Côte de Nuits")),
                rectangle = list(col = c("chartreuse", "tomato"))) 

**Annexe 3 : Dictionnaire des variables**

<table id="org2bc3466" border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
<caption class="t-above"><span class="table-number">Table 1:</span> **Dictionnaire des variables disponibles dans la base de données**</caption>

<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">NOM</th>
<th scope="col" class="org-left">&#xa0;</th>
<th scope="col" class="org-left">TYPE</th>
<th scope="col" class="org-left">&#xa0;</th>
<th scope="col" class="org-left">DESCRIPTION</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">`IDU`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Identifiant de la parcelle cadastrale (14 caractères)</td>
</tr>


<tr>
<td class="org-left">`CODECOM`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Code INSEE de la commune d'appartenance (5 caractères)</td>
</tr>


<tr>
<td class="org-left">`AREA`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Surface calculée de la parcelle cadastrale (en mètres carrés)</td>
</tr>


<tr>
<td class="org-left">`PERIM`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Périmètre calculé de la parcelle cadastrale (en mètres)</td>
</tr>


<tr>
<td class="org-left">`MAXDIST`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Distance maximale calculée entre deux sommets (en mètres)</td>
</tr>


<tr>
<td class="org-left">`PAOC`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Indicatrice*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">1 si la parcelle est dans au moins une AOC</td>
</tr>


<tr>
<td class="org-left">`BGOR`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Indicatrice*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">1 si la parcelle est dans le niveau Coteaux bourguignon</td>
</tr>


<tr>
<td class="org-left">`BOUR`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Indicatrice*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">1 si la parcelle est dans le niveau Bourgogne régional</td>
</tr>


<tr>
<td class="org-left">`VILL`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Indicatrice*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">1 si la parcelle est dans le niveau Bourgogne village</td>
</tr>


<tr>
<td class="org-left">`COMM`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Indicatrice*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">1 si la parcelle est dans le niveau Bourgogne communal</td>
</tr>


<tr>
<td class="org-left">`PCRU`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Indicatrice*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">1 si la parcelle est dans le niveau Premier cru</td>
</tr>


<tr>
<td class="org-left">`GCRU`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Indicatrice*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">1 si la parcelle est dans le niveau Grand cru</td>
</tr>


<tr>
<td class="org-left">`AOC`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Rang de la parcelle dans la hiérarchie des AOC (entre 0 et 5)</td>
</tr>


<tr>
<td class="org-left">`AOCtp`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Modalité `Appel` pour une appellation ou `Denom` pour une dénomination</td>
</tr>


<tr>
<td class="org-left">`AOClb`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Libellé de l'appellation ou de la dénomination selon la variable `AOCtp`</td>
</tr>


<tr>
<td class="org-left">`AOC36lab`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Libellé de l'appellation en 1936 (56 modalités)</td>
</tr>


<tr>
<td class="org-left">`AOC36lvl`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Rang de la parcelle dans la hiérarchie des AOC de 1936 (0, 3 ou 5)</td>
</tr>


<tr>
<td class="org-left">`LIEUDIT`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Libellé du lieu dit de la parcelle (2691 modalités)</td>
</tr>


<tr>
<td class="org-left">`CLDVIN`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Identifiant du lieu dit de la parcelle (2691 modalités)</td>
</tr>


<tr>
<td class="org-left">`LIBCOM`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Libellé de la commune de la parcelle (31 modalités)</td>
</tr>


<tr>
<td class="org-left">`XCHF`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Latitude du chef-lieu de la commune (système Lambert 93)</td>
</tr>


<tr>
<td class="org-left">`YCHF`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Longitude du chef-lieu de la commune (système Lambert 93)</td>
</tr>


<tr>
<td class="org-left">`ALTCOM`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Altitude du point culminant de la commune (mètre)</td>
</tr>


<tr>
<td class="org-left">`SUPCOM`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Superficie de la commune de la parcelle (hectare)</td>
</tr>


<tr>
<td class="org-left">`POPCOM`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Population de la commune de la parcelle en 2015 (millier d'hab)</td>
</tr>


<tr>
<td class="org-left">`CODECANT`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Identifiant du canton d'appartenance (2 caractères)</td>
</tr>


<tr>
<td class="org-left">`REGION`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Region viticole (`CDB` pour côte de Beaune, `CDN` pour côte de Nuits)</td>
</tr>


<tr>
<td class="org-left">`PAR2RAS`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Identifiant pour appariement entre vecteurs et raster</td>
</tr>


<tr>
<td class="org-left">`XL93`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Latitude du centroïde de la parcelle (système Lambert 93)</td>
</tr>


<tr>
<td class="org-left">`YL93`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Longitude du centroïde de la parcelle (système Lambert 93)</td>
</tr>


<tr>
<td class="org-left">`NOMOS`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Part de la parcelle hors du mode d'occupation des sol (entre 0 et 1)</td>
</tr>


<tr>
<td class="org-left">`URBAN`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Part de la parcelle en usage urbain selon le MOS (entre 0 et 1)</td>
</tr>


<tr>
<td class="org-left">`FOREST`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Part de la parcelle en usage forestier selon le MOS (entre 0 et 1)</td>
</tr>


<tr>
<td class="org-left">`WATER`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Part de la parcelle en eau selon le MOS (entre 0 et 1)</td>
</tr>


<tr>
<td class="org-left">`DEM`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Altitude moyenne de la parcelle selon le MNT (en mètres)</td>
</tr>


<tr>
<td class="org-left">`SLOPE`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Pente moyenne de la parcelle selon le MNT (en degrés)</td>
</tr>


<tr>
<td class="org-left">`ASPECT`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Exposition moyenne de la parcelle selon le MNT (en degrés)</td>
</tr>


<tr>
<td class="org-left">`SOLAR`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Radiation solaire moyenne sur la parcelle (en Joules)</td>
</tr>


<tr>
<td class="org-left">`CODE`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Code de la géologie (31 modalités)</td>
</tr>


<tr>
<td class="org-left">`NOTATION`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Notation stratrigraphique harmonisée (31 modalités)</td>
</tr>


<tr>
<td class="org-left">`DESCR`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Description géologie (31 modalités)</td>
</tr>


<tr>
<td class="org-left">`TYPEGEOL`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type superficiel (4 modalités)</td>
</tr>


<tr>
<td class="org-left">`APLOCALE`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Colluvions, Eboulis, etc. (28 modalités)</td>
</tr>


<tr>
<td class="org-left">`TYPEAP`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type de formation (7 modalités)</td>
</tr>


<tr>
<td class="org-left">`GEOLNAT`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Nature Géologique (3 modalités)</td>
</tr>


<tr>
<td class="org-left">`ISOPIQUE`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Faciès des couches (4 modalités)</td>
</tr>


<tr>
<td class="org-left">`AGEDEB`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Age de la couche (24 modalités)</td>
</tr>


<tr>
<td class="org-left">`ERADEB`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Céno ou Méso (2 modalités)</td>
</tr>


<tr>
<td class="org-left">`SYSDEB`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Age autre (5 modalités)</td>
</tr>


<tr>
<td class="org-left">`LITHOLOGIE`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Litho (16 modalités)</td>
</tr>


<tr>
<td class="org-left">`DURETE`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Dureté (3 modalités)</td>
</tr>


<tr>
<td class="org-left">`ENVIRONMT`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Environnement (9 modalités)</td>
</tr>


<tr>
<td class="org-left">`GEOCHIMIE`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Géochimie (5 modalités)</td>
</tr>


<tr>
<td class="org-left">`LITHOCOM`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Litho détaillée (30 modalités)</td>
</tr>


<tr>
<td class="org-left">`NOUC`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Numéro de l'unité cartographique (2 caractères)</td>
</tr>


<tr>
<td class="org-left">`SURFUC`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Surface de l'unité cartographique (en hectares)</td>
</tr>


<tr>
<td class="org-left">`TARG`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Taux d'argile de l'unité typologique dominante (pourcentage)</td>
</tr>


<tr>
<td class="org-left">`TSAB`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Taux de sable de l'unité typologique dominante (pourcentage)</td>
</tr>


<tr>
<td class="org-left">`TLIM`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Taux de limons de l'unité typologique dominante (pourcentage)</td>
</tr>


<tr>
<td class="org-left">`TEXTAG`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Classes de textures agrégées en 9 modalités (voir Ay, 2011)</td>
</tr>


<tr>
<td class="org-left">`EPAIS`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Épaisseur des sols de l'unité typologique dominante (centimètre)</td>
</tr>


<tr>
<td class="org-left">`TEG`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Taux d'éléments grossiers de l'unité typologique dominante (pour mille)</td>
</tr>


<tr>
<td class="org-left">`TMO`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Taux de Matière organique de l'unité typologique dominante (pourcentage)</td>
</tr>


<tr>
<td class="org-left">`RUE`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Réserve Utile par excès de l'unité typologique dominante (millimètre)</td>
</tr>


<tr>
<td class="org-left">`RUD`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Réserve Utile par défaut de l'unité typologique dominante (millimètre)</td>
</tr>


<tr>
<td class="org-left">`OCCUP`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Numérique*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Part de l'unité typologique dominante dans l'unité cartographique (entre 0 et 1)</td>
</tr>


<tr>
<td class="org-left">`DESCRp`</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">*Caractère*</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Libellé de la classe pédologique en 33 modalités</td>
</tr>
</tbody>
</table>

**Annexe 4 : Unités géologiques et pédologiques**

**Annexe 5 : Interface utilisateur de l'application**

    ui <- dashboardPage(
        dashboardHeader(
            titleWidth= 550, 
            title= "Classification statistique des vignobles de la Côte d'Or"),
        dashboardSidebar(disable = TRUE),
        dashboardBody(
            fluidRow(
                box(width= 4,
                    column(width= 12,
                           selectInput(
                               "niveau", label= "Niveau de l'appellation",
                               choices=
                                   c(as.character(unique(Poly.Ras$NIVEAU)),
                                     "TOUS"),
                               selected= 1),
                           selectInput(
                               "commune", 
                               label= "Commune de la parcelle",
                               choices= c(
                                   as.character(unique(Poly.Ras$LIBCOM)),
                                   "TOUTES"), selected= 1),
                           selectInput(
                               "nom",
                               label= "Lieu dit de la parcelle",
                               choices= c(
                                   as.character(unique(Poly.Ras$NOM)),
                                   "TOUS"), selected = 1),
                           plotOutput("miplot", height= 510, width= 200))),
                box(width= 7, 
                    column(width = 12, 
                           leafletOutput("mymap", height= 745),
                           fluidRow(verbatimTextOutput("mymap_shape_click"))
                           )
                    )
            )
        )
    )

**Annexe 6 : Partie serveur de l'application**

    server <- function(input, output, session) {
        ## Reactive values 
        values <- reactiveValues(niveau= NULL, commune= NULL, nom= NULL)  
        ## Initialisation reactive values
        observe({
            if (is.null(values$niveau))  values$niveau  <- input$niveau
            if (is.null(values$commune)) values$commune <- input$commune
            if (is.null(values$nom))     values$nom     <- input$nom
        })
        ## MAJ des reactive values apres un click sur un polygone
        observeEvent(input$mymap_shape_click,{
            values$niveau  <- Pts.Crd$NIVEAU[Pts.Crd$Concat==
                                             input$mymap_shape_click$id]
            values$nom     <- Pts.Crd$NOM[Pts.Crd$Concat==
                                          input$mymap_shape_click$id]
            values$commune <-Pts.Crd$LIBCOM[Pts.Crd$Concat==
                                            input$mymap_shape_click$id]
        })
        ## MAJ des reactive values apres un choix dans menus deroulants
        observeEvent(c(input$commune, input$niveau, input$nom),{
            if (values$niveau  != input$niveau) {
                values$niveau  <- input$niveau
                values$commune <- Pts.Crd$LIBCOM[Pts.Crd$NIVEAU==
                                                 values$niveau][ 1]
                values$nom     <- Pts.Crd$NOM[Pts.Crd$LIBCOM==
                                              values$commune][ 1]
            }
            else if (values$commune != input$commune) {
                values$commune <- input$commune
                values$nom <- Pts.Crd$NOM[Pts.Crd$LIBCOM== values$commune][ 1]
            }           
            else if (values$nom!=input$nom){
                values$nom<-input$nom
            }})
        ## MAJ menus deroulants
        observeEvent(c(values$commune, values$niveau, values$nom),{
            updateSelectInput(session, "niveau",
                              choices= c(as.character(
                                  unique(Poly.Ras$NIVEAU))),
                              selected=values$niveau)
            updateSelectInput(session, "commune",
                              choices= c(as.character(
                                  unique(Poly.Ras$LIBCOM[Poly.Ras$NIVEAU %in%
                                                         values$niveau]))),
                              selected=values$commune)
            updateSelectInput(session, "nom",
                              choices= c(as.character(
                                  unique(Poly.Ras$NOM[Poly.Ras$LIBCOM %in%
                                                      values$commune &
                                                      Poly.Ras$NIVEAU %in%
                                                      values$niveau]))),
                              selected=values$nom)
        })
        ## Subset donnees
        getPts <- reactive({
            Pts.Crd[Pts.Crd$NIVEAU %in% values$niveau &
                    Pts.Crd$LIBCOM %in% values$commune &
                    Pts.Crd$NOM    %in% values$nom, ]})
        ## Carte de base
        output$mymap <- renderLeaflet({
            map@map
        })
        ## Rafraichissement carte
        observe({
            gg <- getPts()
            if (nrow(gg)== 0) return(NULL)
            else {
                bound_box <- as.numeric(st_bbox(Poly.Ras[Poly.Ras$Concat %in%
                                                         gg$Concat,]))
                leafletProxy("mymap") %>%
                    clearMarkers() %>%
                    fitBounds(lng1= bound_box[ 3], lng2= bound_box[ 1],
                              lat1= bound_box[ 4], lat2= bound_box[ 2]) %>%
                    addCircleMarkers(data= (getPts()))}
        })
        ## Violon Plot de base
        output$miplot <- renderPlot({
            yop <- getPts()$SCORE_c
            if (length(yop)==0) return(NULL)
            top <- round(100-
                         aggregate(I(Poly.Ras$SCORE_c< yop)* 100,
                                   by= list(Poly.Ras$NIVEAU), mean)[, 2])
            ggplot(Poly.Ras, aes(x= factor(NIVEAU),
                                 y= SCORE_c, fill= factor(NIVEAU)))+
                geom_violin(trim= FALSE)+ theme_minimal()+ ylim(40, 100)+
                geom_boxplot(width=0.1, fill= "white")+
                annotate("text", x= 1: 5, y= 100,
                         label= paste("", top, "%"), col= "red", size= 5)+
                labs(title= "Comparaison avec les autres parcelles",
                     x= "",
                     y = "Niveau sur une échelle de 1 à 100")+ 
                scale_fill_manual(values= AocPal)+ 
                theme(legend.position= "none",
                      plot.title = element_text(hjust = 0, size = 16),
                      axis.text.x = element_text(size= 12),
                      axis.title.x = element_text(hjust= 0, size= 14),
                      axis.title.y = element_text(size= 14))+
                scale_x_discrete(expand= expand_scale(mult= 0, add= 1),
                                 drop= T)+
                geom_hline(yintercept= yop, lty= 2, col= "red")+
                annotate("text", x= 0.35, y= yop+ 2,
                         label= round(yop, 2), col= "red", size= 5)
        }, height = 500, width = 400)}

