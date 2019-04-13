---
title:  Déterminants biophysiques des AOC viticoles, Construction des données et modélisation
author: Jean-Sauveur Ay et Mohamed Hilal
date:   UMR CESAER, AgroSup, INRA, Université Bourgogne Franche-Comté
---

# Résumé

<div class="abstract">
Nous présentons le détails de la construction de données à l'échelle parcellaire pour étudier statistiquement les relations existantes entre les caractéristiques biophysiques (topographie, géologie, pédologie) des parcelles viticoles et les appellations d'origine contrôlée (AOC). La zone d'étude comprend actuellement 31 communes de la Côte d'Or entre Dijon et Santenay, incluses dans la Côte de Beaune et la Côte de Nuits. L'intérêt de ces données est illustré par une modélisation de l'effet des caractéristiques biophysiques des parcelles sur leur probabilité d'être dans les différents niveaux d'AOC. Ce modèle permet en outre d'affiner le classement actuel des parcelles dans un sens qui sera précisé, tout en restant fidèle à ses principes. Les données et prédictions du modèle sont disponibles sous licence XX sur le portail Data de l'INRA: <https://data.inra.fr>.

**Mots-clés**: Recherche reproductible ; économie viti-vinicole ; signes de qualité ; système d'information géographique ; modélisation économétrique.

</div>


# Table des matières

1.  [Introduction](#org1c66928)
2.  [Construction des données](#org2af311b)
    1.  [Les parcelles cadastrales](#orgeb0beb3)
    2.  [Enrichissement de la topographie](#org2f1d018)
    3.  [Enrichissement de la géologie](#org3927802)
    4.  [Enrichissement de la pédologie](#org3cd4d58)
    5.  [Enrichissement des AOC de 1936](#orgcd3aafe)
    6.  [Enrichissement des lieux dits](#org1fae0b6)
    7.  [Enregistrement de la base](#orga9df99d)
3.  [Statistiques descriptives](#org6a89924)
    1.  [Général](#org49f7412)
    2.  [Bilan surfacique des AOC](#orgd259b5a)
    3.  [Liens avec les AOC historiques](#orgd1aec5a)
    4.  [Distribution spatiale](#orgc7ca565)
4.  [Modèle ordonné de désignation](#org5997c05)
    1.  [Variable transformations](#org9db842c)
    2.  [Spécification du modèle](#org58687b5)
    3.  [Effets des variables biophysiques](#org06ce969)
    4.  [Prédiction du score et classifications](#org3f1d3f7)
5.  [Mise en cartographie dynamique](#org9c523e0)
6.  [Conclusion](#orgeb1cc51)
7.  [Bibliographie](#orgafad594)
8.  [Annexes](#org7203e70)
    1.  [Annexe 1: incohérence des AOC](#orgb4257fe)
    2.  [Annexe 2: les intitulés pédologiques](#org0f434b1)


<a id="org1c66928"></a>

# <a id="org4ae8925"></a> Introduction

Les Appellations d'Origines Contrôlées (AOC) en Bourgogne sont issues de processus humains qui ont travaillées, répertoriés puis classés les parcelles en fonction de leur capacité à produire des vins de qualité. . Niveaux.

Christophe Lucand (dans \cite{WJac11}) cite les experts fondateurs (les mêmes qu'Olivier): Jullien, Morelot et Lavalle, supposent l'existence d'une hiérarchie commune en trois ou quatre catégories, avec au sommet les "têtes de cuvée" puis les premières cuvées. Puis il cite la thèse d'Olivier. A cette hiérarchie transversale se superpose une hiérarchie par villages qui ne détermine cependant en rien la réalité des zones d'approvisionnement concernées. Il s'agit plutôt d'identifications commerciales communes, investies d'un plus ou moins grand capital symbolique hérité. Ce capital symbolique hérité attribut un prestige plus ou moins grand à certaines communes ou propriétaires particulier.

le décret instaurant les Premiers Crus ne fut toutefois adopté qu’en 1943. Deux classements historiques servirent de principales références à la désignation de ces ceux-ci: celui de Jules Lavalle de 1855 et le Classement du Comité d’Agriculture et de Viticulture de l’Arrondissement de Beaune de 1860.

D'un point de vue économique, les AOc sont un signe de qualité bla mais peuvent aussi faire l'objet d'une demande pour eux mêmes.

Une analyse économique des "signes de qualité". Labels et certification des produits Laurent Linnemer sem-linkAnne Perrot Revue économique Année 2000 51-6 pp. 1397-1418

Asymétrie de l'information, réputation et certification Bénédicte Coestier Annales d'Économie et de Statistique No. 51 (Jul. - Sep., 1998

L'objet de cet article est premièrement de présenter la construction de la base de données. carte de la zone pas les hoautes cotes ni le châtillonnais. corresond à l'unesco? <https://whc.unesco.org/fr/list/1425/>

Une aire parcellaire délimitée désigne une délimitation qui repose sur les limites administratives du cadastre et dont le maillage suffisamment fin permet de tenir compte de variations très localisées des éléments du milieu physique (règlements européens 510/2006 et 1234/2007) AOC en Cote d'Or: PCI-Vecteur ou cadastre de l'IGN. Peut comprendre des parcelle découpées.

Nous présentons également une application de cette base de données pour proposer une analyse statistique de l'information présente dans les AOC. En lien avec leur structuration hiérarchique en niveau,

Ce document contient le code R, packages, github, etc. Les bases de données sources qui entrent dans le travail sont disponibles auprès des auteurs sur demande.


<a id="org2af311b"></a>

# <a id="orgee46409"></a> Construction des données


<a id="orgeb0beb3"></a>

## Les parcelles cadastrales

Le travail porte sur l'ensemble des parcelles cadastrales des 31 communes de la Côte de Beaune et de la Côte de Nuits reportées dans la Figure XX en Annexe A. La géométrie du parcellaires est issue de la BD parcellaire de l'IGN version X.XX téléchargée le XX/XX/2018. Deux traitements ont été effectués au préalable, nous avons calculé à l'aide d'un système d'information géographique (SIG) des caractéristiques géométriques des parcelles (surface, périmètre, et distance maximale entre deux sommets, voir Table [1](#org36545b7)) et appariée l'information sur les AOC à partir du fichier de l'INAO sur \url{data.gouv.fr}. Sur ce deuxième point, blabla.

À partir du Shapefile `dicopar` disponible sur le cloud au <span class="timestamp-wrapper"><span class="timestamp">&lt;2019-01-11 ven.&gt; </span></span> projection Lambert 93, nous créons un code INSEE par concaténation du département et du code commune:

```R
library(sp) ; library(rgdal)
Geo.Cada <- readOGR("./Carto", "CadaParc")
sapply(Geo.Cada@data, function(x) sum(is.na(x)))
```

    OGR data source with driver: ESRI Shapefile 
    Source: "/home/jsay/geoIndic/Carto", layer: "CadaParc"
    with 110350 features
    It has 17 fields
        IDU CODECOM    AREA   PERIM MAXDIST PAR2RAS    PAOC    ALIG 
          0       0       0       0       0       0       0       0 
       BPTG    CREM    MOUS    BGOR    BOUR    VILL    COMM    PCRU 
          0       0       0       0       0       0       0       0 
       GCRU 
          0

La base parcellaire contient donc \(110\,350\) observations et 30 variables issues des données cadastrales IGN (variables 1 à 8), des descripteurs de la géométrie des parcelles (variables 9 à 16), un identifiant pour l'appariement avec les données raster, un identifiant cadastral et les variables issues de l'INAO (variables 19 à 29):

|    | NOM     | TYPE | LABEL                                    |
|--- |------- |---- |---------------------------------------- |
| 1  | IDU     | 1    | Identifiant cadastral                    |
| 2  | CODECOM | 2    | Code INSEE commune                       |
| 3  | AREA    | 3    | Surface de la parcelle                   |
| 4  | PERIM   | 4    | Périmètre de la parcelle                 |
| 5  | MAXDIST | 5    | Distance maximale entre deux sommets     |
| 6  | PAR2RAS | 6    | Identifiant pour appariement avec raster |
| 7  | PAOC    | 7    | Hors périmètre AOC                       |
| 8  | ALIG    | 8    | Bourgogne Aligoté                        |
| 9  | BPTG    | 9    | Bourgogne Passe Tout Grain               |
| 10 | CREM    | 10   | Crémant de Bourgogne                     |
| 11 | MOUS    | 11   | Bourgogne Mousseux                       |
| 12 | BGOR    | 12   | Coteaux Bourguignon                      |
| 13 | BOUR    | 13   | Bourgogne Régional                       |
| 14 | VILL    | 14   | Bourgogne Village                        |
| 15 | COMM    | 15   | Bourgogne Communal                       |
| 16 | PCRU    | 16   | Premier Cru                              |
| 17 | GCRU    | 17   | Grand Cru                                |


<a id="org2f1d018"></a>

## Enrichissement de la topographie

Les données raster sont également issues du cloud, avec le fichier `vitidem.csv`. Nous transformons la variable catégorielle `MOS` sur les modes d'occupation du sol en indicatrices afin de pouvoir l'agréger au niveau des parcelles. Ensuite, les autres variables quantitatives seront simplement moyennées au niveau des parcelles. Nous pourrions imaginer d'autres méthodes d'agrégation et reporter d'autres statistiques: pour plus tard. Les données sont lourdes donc les codes suivants sont assez longs à tourner (surtout le `model.matrix`) et il faut veiller à effacer les bases lorsqu'elles ne servent plus. 14253070

```R
library(data.table)
dim(Dat.Ras <- fread("./Data/DatRas.csv"))
Cad.Ras <- Dat.Ras[, lapply(.SD, mean), by= list(PAR2RAS),
                   .SDcols= names(Dat.Ras)[ -c(1, 4)]]
Geo.Ras <- merge(Geo.Cada, Cad.Ras, by= "PAR2RAS")
sapply(Geo.Ras@data[, 18: 28], function(x) sum(is.na(x))); rm(Dat.Ras)
```

    data.table 1.11.4  Latest news: http://r-datatable.com
    [1] 14253070       13
      XL93   YL93  NOMOS  URBAN FOREST  WATER    DEM  SLOPE ASPECT  SOLAR 
      2096   2096   2096   2096   2096   2096   2096   2096   2096   2096 
    PERMEA 
      2096

Il y a \(2\,096\) parcelles pour lesquelles le code `Par2ras` ne correspond à aucun des quelques 14 millions de raster. Ce sont *a priori* des petites parcelles avec une taille médiane de 10 m\(^2\) (max. 339) alors que pour l'ensemble la médiane est de \(3\,084\) m\(^2\). Il faudrait connaître le détails de la jonction entre les données parcelles et les données raster pour comprendre l'origine de ces valeurs manquantes.

Même tableau que précédemment


<a id="org3927802"></a>

## Enrichissement de la géologie

Depuis mars 2019, le BRGM a libéré l'accès aux cartes géologiques au \(1/50\,000\) Bd Charm-50 sous licence Ouverte / Open Licence Etalab Version 2.0 (<http://infoterre.brgm.fr/page/conditions-dutilisation-donnees>). Les données utilisées ici sont une extraction de la Côte d'Or, téléchargées en avril 2019 sur le site <http://infoterre.brgm.fr>. Les données sont constituées de différentes couches SIG décrivant les formations géologiques, les éléments linéaires et ponctuels structuraux et divers.

```R
Geol.Map <- readOGR("./Carto/", "GeolMap")
Pts.Cad <- SpatialPoints(Geo.Ras, proj4string= CRS(proj4string(Geo.Ras)))
Geo.Ras@data <- cbind(Geo.Ras@data, over(Pts.Cad, Geol.Map))
sapply(Geo.Ras@data[, 29: 44], function(x) sum(is.na(x)))
```

    OGR data source with driver: ESRI Shapefile 
    Source: "/home/jsay/geoIndic/Carto", layer: "GeolMap"
    with 13960 features
    It has 16 fields
          CODE   NOTATION      DESCR  TYPE_GEOL  AP_LOCALE    TYPE_AP 
            31         31         31         31        862        862 
      GEOL_NAT   ISOPIQUE    AGE_DEB    ERA_DEB    SYS_DEB LITHOLOGIE 
            31         31         31         31         31         31 
        DURETE  ENVIRONMT  GEOCHIMIE  LITHO_COM 
            69         31         31         69

On a fait une sélection sur les valeurs omises et sur la redondance d'information.


<a id="org3cd4d58"></a>

## Enrichissement de la pédologie

La couche pédologique est issue du Référentiel Pédologique de Bourgogne : Régions naturelles, pédopaysage et sols de Côte d'Or (étude 25021) au \(1/250\,000\), compatible avec la base de données nationale DoneSol. La localisation des types de sol s'opère par des Unités Cartographiques de Sols ou Pédopaysages qui regroupent différents types de sols mais sans que ces derniers puissent être localisés plus précisément. En l'absence de données plus fines spatialement, les données parcellaires seront enrichies des code des unités cartographiques censées regroupés des sols homogènes. Les intitulés des UCS sont obtenus par un travail manuel reporté à l'annexe 2 (par le site <https://bourgogne.websol.fr/carto>). On peut cite ma thèse.

```R
Pedo.Map <- readOGR("./Carto", "PedoMap")
Geo.Ras@data <- cbind(Geo.Ras@data, over(Pts.Cad, Pedo.Map))
sapply(Geo.Ras@data[, 45: 60], function(x) sum(is.na(x)))
```

    OGR data source with driver: ESRI Shapefile 
    Source: "/home/jsay/geoIndic/Carto", layer: "PedoMap"
    with 194 features
    It has 16 fields
        NOUC    NO_UC NO_ETUDE   SURFUC     TARG     TSAB     TLIM 
       14645    14645    14645    14645    14645    14645    14645 
      TEXTAG    EPAIS      TEG      TMO      RUE      RUD     NOUS 
       14645    14645    14645    14645    14645    14645    14645 
       OCCUP   DESCRp 
       14645    14645

Il apparaît que les descriptions des Pédopaysages combinent des caractéristiques topographiques (Plaines, massifs, piedmonts), des caractéristiques d'occupation (forestiers, vignoble) et des caractéristiques géologiques (plio-pléistocènes, calcaires). Le redondance de ce découpage avec les variables topographiques, le découpage géologique et le mode d'occupation des sols se pose effectivement. Les valeurs manquantes correspondent aux espaces urbanisés (pas vraiment à partir du MOS)


<a id="orgcd3aafe"></a>

## Enrichissement des AOC de 1936

```R
Hist.Aoc <- readOGR("Carto/", "Aoc1936")
Geo.Ras@data <- cbind(Geo.Ras@data, over(Pts.Cad, Hist.Aoc))
sapply(Geo.Ras@data[, 61: 62], function(x) sum(is.na(x)))
```

    OGR data source with driver: ESRI Shapefile 
    Source: "/home/jsay/geoIndic/Carto", layer: "Aoc1936"
    with 56 features
    It has 2 fields
    AOC36lab AOC36lvl 
          70       70

Nous obtenons des aires sensiblement plus réduites que les actuelles, 27% au lieu de 55% trouvés ci-dessus. Hormis le creux de 1938, entre 10 et 15% des parcelles sont classées chaque années, sachant qu'il y a du double compte. Dans le Data paper, il s'agira d'identifier les grands crus des villages avec et sans nom reconnus pour retrouver la structure hiérarchique. Par contre les premiers crus ne pourront pas apparaître car ils n'existaient pas à l'époque. Il faudrait voir avec Florian pourquoi les aires en Côte de Beaune sont moins étendues que les aires villages avec nom (vérifié pour Auxey-Duresses et Chassagne-Montrachet). Dans le cas de Meursault, les Côtes de Beaune associés sont les parcelles périphériques, inclues toutefois dans l'aire de Meursault. Par contre l'aire `Meursault_Blagny` (renommée) en Côte de Beaune est disjointe. En 1937, on a un polygone Côte de Beaune ou Côte de Beaune Village qui est disjoint de toutes les couches de cette année donc on l’inclut comme une modalité. Un polygone "Côte de Beaune" en 1939 plus étendu est ajouté à la variable Cote39, modalité `Beaune`. Les "vins fins de la cote de nuits" délimités en 1937 entrent comme une modalité dans la variable `Com37` car ils sont disjoint avec l'ensemble des polygones de cette année. Il y a deux ensembles: le nord de Gevrey et le sud de Nuits. La variable `Com40` ne compte que des `NONE` car les couches de cette année sont uniquement en Saône et Loire.

L'appellation Vins fins de la Côte de Nuits a été remplacée le 20/08/1964 par l'appellation Côte de Nuits Villages. Mais, le nom de Vins fins de la Côte de Nuits peut toujours être utilisé. ce terroir est quasi-exclusivement consacré à la production de vins rouges.

**Remarques:** Éric Vincent (INAO) s'est dit intéressé pour vectoriser les données 1860 avec de nouvelles variables sur le prix des terres en particulier, il s'agira de voir si l'on peu les intégrer dans une version 2 de la base. Je n'ai ces données pour l'instant que pour 5 communes qui peuvent servir de pilote. Des analyses descriptives m'ont fait apparaître une corrélation forte entre la forme du parcellaire et les AOC anciennes (parcelles en ligne), il faudrait regarder dans quelle mesure cela colle avec les nouvelles AOCs.

**Actualisation** <span class="timestamp-wrapper"><span class="timestamp">&lt;2019-02-01 ven.&gt; </span></span> Rien à Chenove/Marsannay/Couchey. Voir callage Griotte chambertin par exemple.


<a id="org1fae0b6"></a>

## Enrichissement des lieux dits

Il s'agit ici d'inclure de l'information cadastrale à partir des sources `data.gouv.fr`. Nous utilisons le Plan Cadastral Informatisé Vecteur (Format EDIGÉO, <https://cadastre.data.gouv.fr/datasets/plan-cadastral-informatise>) téléchargé pour la Côte d'Or (21) le <span class="timestamp-wrapper"><span class="timestamp">&lt;2019-01-13 dim.&gt;</span></span>. License ouverte Etalab. La difficulté avec les lieux dit est qu'ils doivent être croisés avec les communes car un même nom lieu dit peut être présent sur plusieurs communes. Comme la géométrie des lieux dits et des parcelles colle parfaitement, nous pouvons enrichir les données parcellaires directement par le centroïde. Ajout <span class="timestamp-wrapper"><span class="timestamp">&lt;2019-01-23 mer.&gt;</span></span>, des données communales, nous extrayons également les coordonnées des chefs-lieux pour calculer une distance à vol d'oiseaux, la population (peuvent être des sur-identifications sur le land use) et la distinction Côte de Beaune / Côtes de Nuits. Nous enregistrons également une shapefile `MapCom` qui permet de cartographier les contours communaux dans les figures.

```R
Lieu.Dit <- readOGR("./Carto/", "LieuDit")
Geo.Ras@data <- cbind(Geo.Ras@data, over(Pts.Cad, Lieu.Dit[, -1]))
sapply(Geo.Ras@data[, 63: 72], function(x) sum(is.na(x)))
```

    OGR data source with driver: ESRI Shapefile 
    Source: "/home/jsay/geoIndic/Carto", layer: "LieuDit"
    with 3285 features
    It has 11 fields
     LIEUDIT   CLDVIN   LIBCOM     XCHF     YCHF   ALTCOM   SUPCOM 
        4494     4494     4494     4494     4494     4494     4494 
      POPCOM CODECANT   REGION 
        4494     4494     4494

Pour 4% des parcelles, aucun lieu dit n'a été apparié. Ces parcelles se concentrent sur les communes de Chenôve, Marsannay-la-Côte et Beaune (Corgoloin dans une moindre mesure). Ces "trous" apparaissent déjà dans le fichier source et ne sont donc pas un résultat de l'appariement. Ils semblent être des espaces bâtis sur la carte, mais ce n'est pas confirmé par le MOS.


<a id="orga9df99d"></a>

## Enregistrement de la base

Pour l'instant, on est à moins de 500 Mo.

```R
dim(Geo.Ras)
save(Geo.Ras, file= "Inter/GeoRas.Rda")
writeOGR(Geo.Ras, "Carto/", "GeoRas", driver= "ESRI Shapefile")
```

    [1] 110350     72


<a id="org6a89924"></a>

# <a id="org7ada1fa"></a> Statistiques descriptives


<a id="org49f7412"></a>

## Général

Avant ici pas de stat des

```R

Reg.Rank$AOCc <- ifelse(Reg.Rank$GCRU== 1, 5,
                 ifelse(Reg.Rank$PCRU== 1, 4,
                 ifelse(Reg.Rank$VILL== 1 | Reg.Rank$COMM== 1, 3,
                 ifelse(Reg.Rank$BOUR== 1, 2, 1))))

tmp <- DatCom$LIBCOM[order(DatCom$YCHF, decreasing= TRUE)]
GCDtmp5$LIBCOM <- factor(GCDtmp5$LIBCOM, levels= tmp)
GCDtmp5$DISTCHF <- sqrt((GCDtmp5$XL93- GCDtmp5$XCHF* 100)^2
                        + (GCDtmp5$YL93- GCDtmp5$YCHF* 100)^2)

```


<a id="orgd259b5a"></a>

## Bilan surfacique des AOC

Définition de nos niveaux et implications en termes de surfaces sur la pyramides des AOC.

The endogeneity is about the size or the shape of parcels, but not the pedoclimatic variables. The endogeneity of the size/ shape of parcel can be due both to simultaneity and omitted land quality effects. Both seems to be intuitively treated. Size of parcels multiples of ha, m2 or ouvrée (= 428 m2)?


<a id="orgd1aec5a"></a>

## Liens avec les AOC historiques

First load the `.shp` file in the R workspace.

The database contains &#x2026;

Hiérachisation des données historiques par les nom de crus et s'il sont présents dans les nouvelles données.

\begin{equation}\label{eq:2}
y= ax+ b
\end{equation}

Retravail des données brutes AOC (XX et XXI) et création des niveaux hiérachiques.


<a id="orgc7ca565"></a>

## Distribution spatiale


<a id="org5997c05"></a>

# <a id="org95a87e0"></a> Modèle ordonné de désignation


<a id="org9db842c"></a>

## Variable transformations

```R
RegRank$RAYAT <- with(RegRank@data, (SOLAR- mean(SOLAR))/ sd(SOLAR))
RegRank$EXPO <- factor(ifelse(RegRank$ASPECT< 45, "0-45",
                       ifelse(RegRank$ASPECT< 90, "45-90",
                       ifelse(RegRank$ASPECT<135, "90-135",
                       ifelse(RegRank$ASPECT<180, "135-180",
                       ifelse(RegRank$ASPECT<225, "180-225",
                       ifelse(RegRank$ASPECT<270, "225-270",
                       ifelse(RegRank$ASPECT<315, "270-315", "315-360"))))))),
                       levels= c("0-45", "45-90", "90-135", "135-180",
                                 "180-225","225-270","270-315","315-360"))

RRank <- spTransform(RegRank, CRS("+proj=longlat +ellps=WGS84"))
SSank <- as(RRank, "data.frame")
RRank$X= SSank$coords.x1
RRank$Y= SSank$coords.x2



```


<a id="org58687b5"></a>

## Spécification du modèle

La différence avec le multinomial c'est dans l'interprétation des données. Dans le MNL, tu dis c'est VILL est la meilleure AOC pour cette parcelle. Dans le OP, tu dis cette parcelle peut est mieux que Bourgogne, mieux que VILL, mais moins bien que PCRU et Grand cru. L'OP intègre mieux l'information, il ne faut pas mettre les 2 en concurrence. cette pratique est liée au principe de hiérarchisation des appellations d'origine, qui [&#x2026;] s'emboîtent de manière pyramidale à partir d'une appellation régionale socle […]. Dans cette optique, le vin élaboré selon le cahier des charges d'une appellation hiérarchiquement supérieure répondrait de facto aux exigences de l'appellation régionale, dont les conditions de production sont moins contraignantes.

```R
library(mgcv) ## ASSEZ LONG
gam2 <- gam(AOCc~ s(DEM, k= 10)+ s(SLOPE)+ s(ASPECT)+ s(RAYAT)+ s(PERMEABILITY)
            + s(XREG, YREG, k= 200)+ LIBCOM
          , data= RegRank, family= ocat(R= 5))

summary(gam2)
plot(gam2, scale= 0)

plot(density((gam2$linear.pred- min(gam2$linear.pred))/
             (max(gam2$linear.pred)- min(gam2$linear.pred))))
prdat <- RegRank
prdat$LIBCOM <- "BROCHON"

gg <- predict(gam2, type= "response", newdata= prdat)
hh <- ifelse(gg[, 1]> 1- 1/1e16, 1- 1/1e16, gg[, 1])
prdat$score <- qlogis(1- hh)
RegRank$SCORE <- (prdat$score- min(prdat$score))/
    (max(prdat$score)- min(prdat$score))

plot(density(RegRank$SCORE))
library(plyr)
ee <- ddply(RegRank, .(CODEld),
            function(x) data.frame(Mean= mean(x$SCORE),
                                   Median= median(x$SCORE),
                                   WMean= weighted.mean(x$SCORE, x$Area)))
head(ee[order(ee$Mean, decreasing= TRUE), ], 20)

ff <- ddply(RegRank, .(LIBCOM),
            function(x) data.frame(Mean= mean(x$SCORE),
                                   Median= median(x$SCORE),
                                   WMean= weighted.mean(x$SCORE, x$Area)))
ff[order(ff$Mean, decreasing= TRUE), ]
ff[order(ff$WMean, decreasing= TRUE), ]
```


<a id="org06ce969"></a>

## Effets des variables biophysiques


<a id="org3f1d3f7"></a>

## Prédiction du score et classifications


<a id="org9c523e0"></a>

# <a id="orge8af311"></a> Mise en cartographie dynamique

AGGREGATION PAR LIEUX DITS

On utilise mapview, <https://r-spatial.github.io/mapview/>

-   sudo apt install libgdal-dev
-   sudo ln -s /usr/lib/rstudio/bin/pandoc/pandoc /usr/local/bin
-   webshot::install<sub>phantomjs</sub>()

On pourrait également utiliser:

-   <http://symbolixau.github.io/googleway/articles/googleway-vignette.html>
-   <https://www.osgeo.org/projects/mapguide-open-source/>
-   <http://geoserver.org/>
-   <https://rstudio.github.io/leaflet/shiny.html>
-   <https://github.com/mtennekes/tmap>

On peut mettre des graphiques quand on clique sur un polygone: <https://r-spatial.github.io/mapview/articles/articles/mapview_04-popups.html>

also show info on the epsg code and the proj4string press and hold Ctrl and move the mouse. addMouseCoordinates also allows us to copy the info about the current mouse position to the clipboard by holding the Ctrl and left-clicking on the map.

```R
library(rgdal)
Geo.Cada <- readOGR("./Data/VITI_JSA_MH", "dicopar", verbose= F)
MapCom <- readOGR("Carto/", "MapCom")
mapviewOptions()
mapviewOptions(maxpolygons= 150000)
library(mapview)

Geo.Cada$AOC <- factor(ifelse(Geo.Cada$GCRU== 1, "Grand Cru",
                       ifelse(Geo.Cada$PCRU== 1, "Premier Cru",
                       ifelse(Geo.Cada$COMM== 1 |
                              Geo.Cada$VILL== 1, "Communale",
                       ifelse(Geo.Cada$BOUR== 1, "Régionale",
                              "Coteaux")))),
                       levels= c("Coteaux", "Régionale", "Communale",
                                 "Premier Cru", "Grand Cru"))

n <- mapview(subset(Geo.Cada, PAOC== 1 & Nom_com== "Chenôve"),
             zcol= "AOC", alpha.regions= .6,
             col.regions= paste0("purple", c("1", "2", "", "3", "4")),
             color= "white",
             label= com1$IDU,
             layer.name= "Chenôve",
             popup = popupTable(com1,
                                zcol = c("Area", "Perimeter", "P_a")))+
    
    mapview(subset(Geo.Cada, PAOC== 1 & Nom_com== "Marsannay-la-Côte"),
            zcol= "AOC", alpha.regions= .6,
            col.regions= paste0("purple", c("1", "2", "", "3", "4")),
            color= "white",
              label= com2$IDU,
            layer.name= "Marsannay-la-Côte",
            popup = popupTable(com2,
                               zcol = c("Area", "Perimeter", "P_a")))+
    
    mapview(subset(Geo.Cada, PAOC== 1 & Nom_com== "Couchey"),
            zcol= "AOC", alpha.regions= .6,
            col.regions= paste0("purple", c("1", "2", "", "3", "4")),
            color= "white",
              label= com2$IDU,
            layer.name= "Couchey",
            popup = popupTable(com2,
                               zcol = c("Area", "Perimeter", "P_a")))+
    
    mapview(subset(Geo.Cada, PAOC== 1 & Nom_com== "Fixin"),
            zcol= "AOC", alpha.regions= .6,
            col.regions= paste0("purple", c("1", "2", "", "3", "4")),
            color= "white",
              label= com2$IDU,
            layer.name= "Fixin",
            popup = popupTable(com2,
                               zcol = c("Area", "Perimeter", "P_a")))+
    
    mapview(subset(Geo.Cada, PAOC== 1 & Nom_com== "Brochon"),
            zcol= "AOC", alpha.regions= .6,
            col.regions= paste0("purple", c("1", "2", "", "3", "4")),
            color= "white",
              label= com2$IDU,
            layer.name= "Brochon",
            popup = popupTable(com2,
                               zcol = c("Area", "Perimeter", "P_a")))+
    
    mapview(subset(Geo.Cada, PAOC== 1 & Nom_com== "Gevrey-Chambertin"),
            zcol= "AOC", alpha.regions= .6,
            col.regions= paste0("purple", c("1", "2", "", "3", "4")),
            color= "white", label= com2$IDU,
            layer.name= "Gevrey-Chambertin",
            popup = popupTable(zcol = c("Area", "Perimeter", "P_a")))
+
    
    mapview(subset(Geo.Cada, PAOC== 1 & Nom_com== "Morey-Saint-Denis"),
            zcol= "AOC", alpha.regions= .6,
            col.regions= paste0("purple", c("1", "2", "", "3", "4")),
            color= "white", lwd= .25,
            label= com2$IDU,
            layer.name= "Morey-Saint-Denis",
            popup = popupTable(com2,
                               zcol = c("Area", "Perimeter", "P_a")))



## addLogo(n, "http://www7.inra.fr/fournisseurs/images/logo.jpg",
##         width = 200, height = 100, offset.x= 75, offset.y= 20)
n
## create standalone .html
mapshot(n, url = paste0(getwd(), "/DynMap/tst.html"))

## create .html and .png
mapshot(m, url = paste0(getwd(), "/DynMap/test.html"),
        file = paste0(getwd(), "/DynMap/test.png"),
        remove_controls = c("homeButton", "layersControl"))
```


<a id="orgeb1cc51"></a>

# <a id="org8984019"></a> Conclusion

Le chiffres d’affaire des signes de qualité c’est 32 milliards d’euros et le budget de l’INAO 32 millions d’euros, c’est un millième du chiffre d’affaires.

```R
sessionInfo()
```


<a id="orgafad594"></a>

# <a id="orgf828882"></a> Bibliographie

<Biblio.bib>


<a id="org7203e70"></a>

# <a id="org8e1fa44"></a> Annexes


<a id="orgb4257fe"></a>

## Annexe 1: incohérence des AOC

```R
as.vector(Geo.CDem$IDU[Geo.CDem$AOC== "BGOR" & rowSums(Geo.CDem@data[, c(24, 26: 29)])> 0])
as.vector(Geo.CDem$IDU[Geo.CDem$AOC== "BOUR" & rowSums(Geo.CDem@data[, 26: 29])> 0])
as.vector(Geo.CDem$IDU[Geo.CDem$AOC== "VILL" & rowSums(Geo.CDem@data[, c(26, 29)])> 0])
as.vector(Geo.CDem$IDU[Geo.CDem$AOC== "PCRU" & Geo.CDem@data[, 26]> 0])
```

     [1] "21412000AZ0139" "21464000AN0094" "21492000AR0011"
     [4] "21492000BN0045" "215690000C0840"
    
     [1] "210370000A0507" "21110000AK0116" "21150000AM0096"
     [4] "21428000AA0019" "21582000BC0069"
    
     [1] "21037000AH0094" "21037000AH0096" "21110000AM0101"
     [4] "21133000AB0401" "21133000AC0005" "21133000AC0003"
     [7] "21133000AC0002" "21133000AC0004" "21512000AE0292"
    [10] "21582000AL0049"
    
     [1] "21442000AB0315"


<a id="org0f434b1"></a>

## Annexe 2: les intitulés pédologiques

Pour retrouver les intitulés des UCS, nous utilisons le site web <https://bourgogne.websol.fr/carto> où les différents types de sols qui composent les UCS sont consultables. Le travail manuel a consisté à extraire les coordonnées Lambert 93 d'au moins une parcelle par UCS et d'aller chercher sur le site le nom de l'UCS correspondante. Nous voyons également que lorsque l'UCS est un numéro manquant c'est qu'il s'agit de sols artificialisés (Chenôve, Nuits et Beaune). Il y a un léger effet frontière au sud sur les valeurs qui ne sont pas appariées.

```R
yy <- data.frame(coordinates(GCDtmp3), GCDtmp3$NOUC)
yy[!duplicated(GCDtmp3$NOUC), ]
plot(GCDtmp3)
plot(GCDtmp3[GCDtmp3$NOUC== "0",], col= "blue", add= T, pch= 20)
```
