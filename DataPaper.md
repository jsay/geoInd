---
title:  Déterminants biophysiques des AOC viticoles, Construction des données et modélisation
author: |
  | Jean-Sauveur Ay et Mohamed Hilal
  | UMR CESAER, AgroSup, INRA, Université Bourgogne Franche-Comté
---

# Résumé

<div class="abstract">
Cet article présente la construction de données au niveau des parcelles cadastrales pour étudier les liens entre les caractéristiques biophysiques (topographie, géologie, pédologie) et les appellations d'origine contrôlée (AOC). Sur les 31 communes de la Côte d'Or qui forment la Côte de Beaune et la Côte de Nuits, nous proposons une modélisation économétrique qui permet de classer l'ensemble des parcelles sur une échelle continue à partir de leurs caractéristiques biophysiques. Nous montrons également la persistance d'effets communaux que nous interprétons comme issus d'éléments historiques. Les données, méthodes et prédictions sont disponibles sous licence GNU GPL v3 sur <https://data.inra.fr/geoInd/> et sont consultables par le biais d'une application *Shiny* présenté sur <http://github.com/jsay/geoInd/>.

**Mots-clés**: Économie viti-vinicole ; signes de qualité ; recherche reproductible ; système d'information géographique ; modélisation économétrique.

</div>


# Table of Contents

1.  [Introduction](#orgc9384a1)
2.  [Construction des données](#Sec:1)
    1.  [Les AOC au niveau des parcelles](#orgd85a070)
    2.  [Enrichissement de la topographie](#org517e7b3)
    3.  [Enrichissement de la géologie](#org1093861)
    4.  [Enrichissement de la pédologie](#org9c95ed7)
    5.  [Enrichissement des AOC de 1936](#org89599a3)
    6.  [Enrichissement des lieux dits](#org3cf0172)
    7.  [Enregistrement de la base](#org45d961e)
3.  [Statistiques descriptives](#Sec:2)
    1.  [Sélection des données](#org9dbe000)
    2.  [Distribution des AOC](#orgdf859cd)
    3.  [La pyramide des AOC](#org4ea144a)
    4.  [Tableau des variables utilisées](#orgf38d83f)
4.  [Modèle économétrique](#Sec:3)
    1.  [Estimation du modèle](#org08cde19)
    2.  [Variables biophysiques](#org75b9236)
    3.  [Effets communaux](#org2c65138)
    4.  [Prédiction continue](#org33b3078)
    5.  [Agrégation par lieux dits](#org9e77d62)
5.  [Application *Shiny*](#Sec:4)
    1.  [Cartographie dynamique](#orga51e8d4)
    2.  [Lancer l'application localement](#org5db11eb)
    3.  [Utilisation](#org316bfc4)
    4.  [Développements à venir](#org349f98d)
6.  [Conclusion](#Sec:5)
7.  [Bibliographie](#Sec:6)
8.  [Annexes](#Sec:A)


<a id="orgc9384a1"></a>

# <a id="org4b353cc"></a> Introduction

Les appellations d'origine contrôlée (AOC) viticoles en Bourgogne résultent de processus historiques complexes au cours desquels les parcelles ont été classifiées selon leurs caractéristiques biophysiques au grès des rapports économiques, politiques et sociaux en vigueur <sup id="121170804c03a6ffd9b6598b03e5ae59"><a href="#Garc11" title="Garcia, Les \emph{climats} du vignoble de {B}ourgogne comme patrimoine mondial de l'humanit{\'e}, Ed. Universitaires de Dijon (2011).">Garc11</a></sup><sup>,</sup><sup id="7e3cc4e952baf2ace29bc97117ad514c"><a href="#WJac11" title="Wolikow \&amp; Jacquet, Territoires et terroirs du vin du XVIIIe au XXIe si&#232;cles, &#201;ditions Universitaires de Dijon (2011).">WJac11</a></sup>. La classification actuelle est issue de plusieurs siècles de culture de la vigne, de production de vin et de négociation sur les dénominations. Ces trois ensembles de pratiques forment les usages loyaux et constants définis dans la doctrine de l'institut national de l'origine et de la qualité (INAO) pour définir, reconnaître et gérer les AOC <sup id="95abb746101aa32ae2b154f5bdee7ad0"><a href="#Capu47" title="Capus, L'{\'E}volution de la l{\'e}gislation sur les appellations d'origine. Gen{\`e}se des appellations contr{\^o}l{\'e}es, L. Larmat (1947).">Capu47</a></sup><sup>,</sup><sup id="36d1387edd76d672ddb30e2817a44c44"><a href="#Humb11" title="@phdthesis{Humb11, title={L'INAO, de ses origines {\`a} la fin des ann{\'e}es 1960: gen{\`e}se et {\'e}volutions du syst{\`e}me des vins d'AOC}, author={Humbert, Florian}, year={2011}, school={Universit{\'e} de Bourgogne} }">Humb11</a></sup>. La complexité des informations contenues dans la référence au lieu de production et leurs évolutions dans le temps sont à la fois des forces et des faiblesses pour les AOC. Elles permettent de simplifier les nombreux déterminants biophysiques de la qualité des vins au risque d'une faible pertinence et d'une opacité croissante pour les acteurs du marché du vin.

La question de la transmission de l'information sur la qualité des biens fait l'objet d'une littérature économique abondante <sup id="90e8d3da1815242f3136e232bea3b79b"><a href="#CMar04" title="Coestier \&amp; Marette, Economie de la qualit{\'e}, La d{\'e}couverte (2004).">CMar04</a></sup>. L'asymétrie d'information y est décrite comme une défaillance de marché qui invalide le premier théorème du bien-être et par là même l'efficience de l'allocation par le libre marché. Par contre, le recours aux indications géographiques apparaît comme une solution partielle qui segmente artificiellement la production et génère des rentes non justifiées pour les producteurs au détriment des consommateurs. Nous nous concentrons dans cet article sur la capacité des AOC à simplifier l'information sur les caractéristiques des lieux de production, en laissant de côté la question de la pertinence de cette information pour le marché. Nous proposons de démêler économétriquement les déterminants biophysiques et historiques des AOC par l'utilisation de données exhaustives à l'échelle des parcelles cadastrales. Nous proposons également d'affiner l'information contenue dans les AOC actuelles par une classification continue des vignes corrigée des effets communaux issus de l'histoire. Les résultats obtenus sont consultables par le bais d'une application *Shiny* présentée en détails dans cet article.

Le travail sur les données consiste à apparier les informations biophysiques des parcelles cadastrales aux AOC par l'utilisation d'un système d'information géographique. La Section [2](#Sec:1) suivante présente la construction des données avec les codes `R` utilisés, afin d'assurer la reproductibilité de nos analyses. La parcelle cadastrale est l'unité géographique de base qui permet l'enrichissement de variables topographiques (issues de IGN 5 m), de variables géologiques (issues du BRGM), de variables pédologiques (issues du RPB) et de variables complémentaires sur les AOC en 1936 et les lieux dits administratifs. Les données se limitent actuellement aux 31 communes de la Côte de Beaune et la Côte de Nuits, soient le département de la Côte d'Or à l'exception des Hautes Côtes et du Châtillonnais (voir Figure XX). Les principales statistiques descriptives sont présentées dans la Section [3](#Sec:2).

La Section [4](#Sec:3) contient ensuite le détails de l'estimation du modèle économétrique décrit plus extensivement dans un article associé (Ay, 2019). Nous utilisons la structure hiérarchique des niveaux d'AOC, à savoir Côteaux Bourguignons < Bourgogne Régional < Bourgogne Village < Premier Cru < Grand Cru, pour simplifier le rôle des caractéristiques biophysiques des parcelles au travers d'une variable latente de qualité des vignes. Nous estimons une série de modèles ordonnés additivement semi-paramétriques (OGAM) qui permettent de prédire correctement jusqu'à 90% des AOC de la zone par un lissage spatial fin. Ces modèles permettent également d'identifier des effets communaux indépendants des variables biophysiques, potentiellement issus de facteurs humains tels que la réputation de la commune, la proximité à la ville centre associée (Dijon) ou l'antériorité des syndicats de producteurs <sup id="aabd8d871d4bfd7dce750e0ec786fb3d"><a href="#Jacq09" title="Jacquet, Un si{\`e}cle de construction du vignoble bourguignon. Les organisations vitivinicoles de 1884 aux AOC, Editions Universitaires de Dijon (2009).">Jacq09</a></sup>. L'estimation de ces effets communaux permet de les corriger dans les prédictions, ce qui permet de proposer une classification continue de parcelles plus informative des caractéristiques biophysiques. Nous présentons alors l'application *Shiny* qui permet de consulter les prédictions du modèle dans la section [5](#Sec:4).

La base de données utilisée pour l'analyse économétrique est disponible en shapefile and Rdata sur le serveur *dataverse* de l'INRA <https://data.inra.fr/geoInd/> (licence GNU GPL v3). Ce n'est pas le cas des fichiers sources brutes utilisés dans la section suivante qui sont trop volumineux. Ils peuvent cependant être obtenus sur demande motivée auprès des auteurs. Le caractère reproductible des analyses commence donc à la section XX.


<a id="Sec:1"></a>

# Construction des données


<a id="orgd85a070"></a>

## Les AOC au niveau des parcelles

L'unité géographique de base est la parcelle cadastrale dont la géométrie est issue de la BD parcellaire de l'IGN version X.XX téléchargée le XX/XX/2018 à l'adresse \url{XX}. Ces données sont sous licence `Etalab open data`. Trois traitements ont été effectués au préalable et ne sont pas reportés en détail ici. Nous avons calculé avec un système d'information géographique les caractéristiques géométriques (surface, périmètre, et distance maximale entre deux sommets). Nous avons ensuite créé un identifiant pour apparier les parcelles avec les données du modèle numérique de terrain présenté dans la sous-section suivante. Nous avons enfin apparié les délimitations parcellaire des AOC Viticoles de l'INAO disponible à l'adresse \url{https://www.data.gouv.fr/fr/datasets/delimitation-parcellaire-des-aoc-viticoles-de-linao} sous licence ouverte. Le résultat de ces traitements se trouve dans le fichier `/Carto/GeoCad.shp` (disponible auprès des auteurs sur demande) utilisé dans le code suivant :

```R
library(sp) ; library(rgdal)
Geo.Cad <- readOGR("./Carto", "GeoCad")
sapply(Geo.Cad@data, function(x) sum(is.na(x)))
```

    OGR data source with driver: ESRI Shapefile 
    Source: "/home/jsay/geoInd/Carto", layer: "GeoCad"
    with 110350 features
    It has 16 fields
    
        IDU CODECOM    AREA   PERIM MAXDIST PAR2RAS    PAOC    BGOR 
          0       0       0       0       0       0   49718   49718 
       BOUR    VILL    COMM    PCRU    GCRU     AOC   AOCtp   AOClb 
      49718   49718   49718   49718   49718       0   49718   49718

Ce fichier contient \(110\,350\) parcelles et 16 variables que la Table [1](#orgf936c56) suivante présente plus en détails. L'information brute issue de la superposition avec la couche INAO est présente dans les variables `PAOC` à `GCRU`. Les \(49\,718\) valeurs manquantes qui apparaissent ci-dessus correspondent aux parcelles hors AOC. Nous avons retravaillé cette information brute des données INAO dans les trois variables `AOC`, `AOCtp` et `AOClb` qui sont plus opérationnelles pour l'analyse économétrique. En effet, dans la doctrine de l'INAO, les parcelles d'un niveau hiérarchique supérieur peuvent toujours être revendiquées dans un niveau inférieur (c'est le principe des replis). La superposition des couches de l'INAO conduit à la présence de plusieurs AOC sur une même parcelle, ce qui entre en contradiction avec une autre partie de la doctrine de l'INAO, à savoir qu'il est interdit de revendiquer des AOC différentes pour un même produit. Dans les faits, les producteurs revendiquent très souvent l'AOC maximale à laquelle ils peuvent prétendre. La variable `AOC` représente cette AOC, elle est codée `0` pour les parcelles hors AOC, `1` pour les Coteaux Bourguignons, `2` pour les Bourgognes Régionaux, jusqu'à `5` pour les Grands Crus. Par contre, les informations présentes sur l'étiquette des vins peuvent être des appellations ou des dénominations au sein du système des AOC (même si cette distinction n'est pas toujours claires pour les individus, nous utilisons AOC comme le terme générique qui englobe les deux en précisant lorsque c'est nécessaire). Le libellé `AOClb` contient généralement le nom de l'appellation maximale de la parcelle, sauf pour les "Bourgognes Régionaux" (ou la dénomination "Bourgogne Côte d'Or" est plus haute dans la hiérarchie mais peu utilisée de fait de sa faible antériorité, 2015) et les "Premiers Crus" (qui ont chacun une dénomination qui permet de les distinguer). La commande `table(Geo.Cad$AOC, Geo.Cad$AOCtp)` permet de rendre compte de cette structuration des variables.

| NOM       |  | TYPE          |  | DESCRIPTION                                                              |
|--------- |--- |------------- |--- |------------------------------------------------------------------------ |
| `IDU`     |  | *Caractère*   |  | Identifiant cadastral de la parcelle (14 caractères)                     |
| `CODECOM` |  | *Caractère*   |  | Code INSEE de la commune d'appartenance (5 caractères)                   |
| `AREA`    |  | *Numérique*   |  | Surface calculée de la parcelle (en mètres carrés)                       |
| `PERIM`   |  | *Numérique*   |  | Périmètre calculé de la parcelle (en mètres)                             |
| `MAXDIST` |  | *Numérique*   |  | Distance maximale calculée entre deux sommets (en mètres)                |
| `PAR2RAS` |  | *Numérique*   |  | Identifiant pour appariement avec le modèle numérique de terrain         |
| `PAOC`    |  | *Indicatrice* |  | 1 si la parcelle est dans au moins une AOC                               |
| `BGOR`    |  | *Indicatrice* |  | 1 si la parcelle est dans le niveau Coteaux Bourguignon                  |
| `BOUR`    |  | *Indicatrice* |  | 1 si la parcelle est dans le niveau Bourgogne Régional                   |
| `VILL`    |  | *Indicatrice* |  | 1 si la parcelle est dans le niveau Village                              |
| `COMM`    |  | *Indicatrice* |  | 1 si la parcelle est dans le niveau Communal                             |
| `PCRU`    |  | *Indicatrice* |  | 1 si la parcelle est dans le niveau Premier Cru                          |
| `GCRU`    |  | *Indicatrice* |  | 1 si la parcelle est dans le niveau Grand Cru                            |
| `AOC`     |  | *Numérique*   |  | Rang de la parcelle dans la hiérarchie des AOC (entre 0 et 5)            |
| `AOCtp`   |  | *Caractère*   |  | `Appel` si le libellé est une appellation, `Denom` pour dénomination     |
| `AOClb`   |  | *Caractère*   |  | Libellé de l'appellation ou de la dénomination selon la variable `AOCtp` |


<a id="org517e7b3"></a>

## Enrichissement de la topographie

Les données sur la topographie sont issues du modèle numérique de terrain de l'IGN RESOLUTION, SITE, sous licence XX. Un premier traitement non reporté a été l'attribution de l'identifiant `PAR2RAS` aux cellules du raster par superposition avec la géographie du parcellaire présentée ci-dessus. Nous avons ensuite enrichi les données raster d'un mode d'occupation des sol (SOURCE) et d'une perméabilité calculée (SOURCE). Nous avons enfin calculé les variables topographiques que sont l'altitude, la pente, l'exposition et les radiations solaires (détails en Annexe). À partir des plus de 14 millions de cellules pour 13 variables, le code ci-dessous permet l'agrégation des variables raster au niveau des parcelle. Nous calculons des moyennes à l'échelle des parcelles, sachant que d'autres méthodes d'agrégation ont été utilisées sans différences sur les résultats. Le fichier `Data/DatRas` appariés aux données du cadastre peut être obtenu auprès des auteurs.

```R
library(data.table)
dim(Dat.Ras <- fread("./Data/DatRas.csv"))
Cad.Ras <- Dat.Ras[, lapply(.SD, mean), 
                   by= list(PAR2RAS), .SDcols= names(Dat.Ras)[ -c(1, 4)]]
Geo.Ras <- merge(Geo.Cad, Cad.Ras, by= "PAR2RAS")
sapply(Geo.Ras@data[, 17: 26], function(x) sum(is.na(x))); rm(Dat.Ras)
```

    data.table 1.11.4  Latest news: http://r-datatable.com
    
    [1] 14253070       13
    
      XL93   YL93  NOMOS  URBAN FOREST  WATER    DEM  SLOPE ASPECT  SOLAR 
      2096   2096   2096   2096   2096   2096   2096   2096   2096   2096

Le détails des variables issue du fichier raster est disponible dans la Table [2](#orgad71056) ci-dessous. Nous obtenons \(2\,096\) valeurs manquantes pour lesquelles le code `PAR2RAS` des parcelles ne s'apparie à aucune cellule raster. Ces parcelles sont de très petites parcelles avec des géométrie particulières et font penser à des "erreurs" du cadastre. Nous les enlèverons de l'analyse sachant que cela revient à enlever 2.7 ha, moins de 0.01 % de la surface totale. Nous n'utilisons qu'un sous ensemble du MOS principalement afin de distinguer le non agricole.

| NOM      |  | TYPE        |  | DESCRIPTION                                                          |
|-------- |--- |----------- |--- |-------------------------------------------------------------------- |
| `XL93`   |  | *Numérique* |  | Latitude du centroïde de la parcelle (système Lambert 93)            |
| `YL93`   |  | *Numérique* |  | Longitude du centroïde de la parcelle (système Lambert 93)           |
| `NOMOS`  |  | *Numérique* |  | Part de la parcelle hors du mode d'occupation des sol (entre 0 et 1) |
| `URBAN`  |  | *Numérique* |  | Part de la parcelle en usage urbain selon le MOS (entre 0 et 1)      |
| `FOREST` |  | *Numérique* |  | Part de la parcelle en usage forestier selon le MOS (entre 0 et 1)   |
| `WATER`  |  | *Numérique* |  | Part de la parcelle en eau selon le MOS (entre 0 et 1)               |
| `DEM`    |  | *Numérique* |  | Altitude moyenne de la parcelle selon le MNT (en mètres)             |
| `SLOPE`  |  | *Numérique* |  | Pente moyenne de la parcelle selon le MNT (en degrés)                |
| `ASPECT` |  | *Numérique* |  | Exposition moyenne de la parcelle selon le MNT (en degrés)           |
| `SOLAR`  |  | *Numérique* |  | Radiation solaire moyenne sur la parcelle (en Joules)                |
| `PERMEA` |  | *Numérique* |  | Perméabilité des sols moyenne (entre 0 et 4)                         |


<a id="org1093861"></a>

## Enrichissement de la géologie

Les données géologiques sont issues de la Bd Charm-50 du BRGM à l'échelle \(1/50\,000\) disponible sur le site <http://infoterre.brgm.fr> sous licence Ouverte. Nous utilisons ici une extraction du fichier `GEO050K_HARM_021_S_FGEOL_CGH_2154` effectuée en avril 2019 pour le département de la Côte d'Or. Le seul travail non reporté sur ces données est une sélection des variables bien renseignées et qui contiennent une variance non nulle sur la zone considérée. Nous apparions les \(13\,960\) polygones géologiques présent dans `/Carto/GeolMap` (disponible sur demande) sur la base du centroïde des parcelles cadastrales, comme présenté dans le code suivant. La faible taille moyenne des parcelles sous AOC (moins de 0.2 ha de moyenne) permet de s'assurer de la validité de cette procédure.

```R
Geol.Map <- readOGR("./Carto/", "GeolMap")
Pts.Cad <- SpatialPoints(Geo.Ras, proj4string= CRS(proj4string(Geol.Map)))
Geo.Ras@data <- cbind(Geo.Ras@data, over(Pts.Cad, Geol.Map))
sapply(Geo.Ras@data[, 28: 43], function(x) sum(is.na(x)))
```

    OGR data source with driver: ESRI Shapefile 
    Source: "/home/jsay/geoInd/Carto", layer: "GeolMap"
    with 13960 features
    It has 16 fields
    
          CODE   NOTATION      DESCR   TYPEGEOL   APLOCALE     TYPEAP 
            31         31         31         31        862        862 
       GEOLNAT   ISOPIQUE     AGEDEB     ERADEB     SYSDEB LITHOLOGIE 
            31         31         31         31         31         31 
        DURETE  ENVIRONMT  GEOCHIMIE   LITHOCOM 
            69         31         31         69

Les détails des 16 variables géologiques issues de la procédure sont disponibles dans la Table [3](#orge2a6491) suivante. La description des variables manque de détails car les données géologiques ne possèdent pas encore de dictionnaire (une demande est en cours auprès du BRGM). Ce manque de détails n'est pas fondamental pour l'analyse économétrique (il peut l'être pour d'autres usages des données) car les variables géologiques ne sont utilisées qu'au travers d'effets fixes qui permettent de s'affranchir de la nécessité de spécifier les relations entre les variable géologiques et les AOC. Cette méthode est par ailleurs la plus générale pour contrôler l'hétérogénéité associée à la géologie. Comme nous le voyons ci-dessus, les parcelles non appariées qui produisent des valeurs manquantes sont peut nombreuses (entre 31 et 862 selon les variables) et seront négligées dans l'analyse économétrique sans conséquences. Intitulés en Annexe.

| NOM          |  | TYPE        |  | DESCRIPTION                              |
|------------ |--- |----------- |--- |---------------------------------------- |
| `CODE`       |  | *Caractère* |  | Code de la géologie (31 modalités)       |
| `NOTATION`   |  | *Caractère* |  | Notation géologie (31 modalités)         |
| `DESCR`      |  | *Caractère* |  | Description géologie (31 modalités)      |
| `TYPEGEOL`   |  | *Caractère* |  | Type superficiel (4 modalités)           |
| `APLOCALE`   |  | *Caractère* |  | Colluvions, Eboulis, etc. (28 modalités) |
| `TYPEAP`     |  | *Caractère* |  | Type de formation (7 modalités)          |
| `GEOLNAT`    |  | *Caractère* |  | Nature Géologique (3 modalités)          |
| `ISOPIQUE`   |  | *Caractère* |  | Faciès des couches (4 modalités)         |
| `AGEDEB`     |  | *Caractère* |  | Age de la couche (24 modalités)          |
| `ERADEB`     |  | *Caractère* |  | Céno ou Méso (2 modalités)               |
| `SYSDEB`     |  | *Caractère* |  | Age autre (5 modalités)                  |
| `LITHOLOGIE` |  | *Caractère* |  | Litho (16 modalités)                     |
| `DURETE`     |  | *Caractère* |  | Dureté (3 modalités)                     |
| `ENVIRONMT`  |  | *Caractère* |  | Environnement (9 modalités)              |
| `GEOCHIMIE`  |  | *Caractère* |  | Géochimie (5 modalités)                  |
| `LITHOCOM`   |  | *Caractère* |  | Litho détaillée (30 modalités)           |


<a id="org9c95ed7"></a>

## Enrichissement de la pédologie

Les données pédologiques sont extraites du Référentiel Pédologique de Bourgogne : Régions naturelles, pédopaysage et sols de Côte d'Or (étude 25021) à l'échelle \(1/250\,000\), compatible avec la base de données nationale DoneSol, sous licence XX (Chrétien, 1998). La localisation des types de sol et l'appariement avec le cadastre s'opèrent par les 194 Unités Cartographiques de Sols de la zone, qui sont des polygones plutôt homogènes en termes de paysage mais qui contiennent différents types de sols. Ces derniers, regroupés en unités typologiques, ne peuvent pas être localisés plus précisément <sup id="208d1d7a07cf6fffe3fa96d1717b7a1f"><a href="#Ay11" title="@phdthesis{Ay11, TITLE = {H&#233;t&#233;rog&#233;n&#233;it&#233; de la terre et raret&#233; &#233;conomique}, AUTHOR = {Ay, Jean-Sauveur}, URL = {https://tel.archives-ouvertes.fr/tel-00629142}, SCHOOL = {{Universit{\'e} de Bourgogne}}, YEAR = {2011}, MONTH = Jul, TYPE = {Theses}, PDF = {https://tel.archives-ouvertes.fr/tel-00629142/file/THESE.pdf}, HAL_ID = {tel-00629142}, HAL_VERSION = {v1}, }">Ay11</a></sup>. En l'absence de données plus fines spatialement, les données parcellaires seront enrichies du code des unités cartographiques et les valeurs de l'unité typologique dominante, c'est-à-dire celle qui est la plus étendue au sein de chaque unité cartographique. Comme pour la géologie, les données pédologiques seront utilisées par des effets fixes au niveau des unités cartographiques, ce qui fait que cette procédure n'est pas limitante (elle peut cependant l'être pour d'autres usages). Les intitulés des unités cartographiques reportés en Annexe 3 sont obtenus par un travail manuel à partir du site <https://bourgogne.websol.fr/carto>.

```R
Pedo.Map <- readOGR("./Carto", "PedoMap")
Geo.Ras@data <- cbind(Geo.Ras@data, over(Pts.Cad, Pedo.Map))
Geo.Ras@data[, c(45: 48, 50: 55)] <-
    apply(Geo.Ras@data[, c(45: 48, 50: 55)], 2, as.numeric)
sapply(Geo.Ras@data[, 44: 56], function(x) sum(is.na(x)))
```

    OGR data source with driver: ESRI Shapefile 
    Source: "/home/jsay/geoInd/Carto", layer: "PedoMap"
    with 194 features
    It has 13 fields
    
      NOUC SURFUC   TARG   TSAB   TLIM TEXTAG  EPAIS    TEG    TMO    RUE 
     14645  14645  14645  14645  14645  14645  14645  14645  14645  14645 
       RUD  OCCUP DESCRp 
     14645  14645  14645

Les détails des 13 variables pédologiques issues de la procédure sont disponibles dans la Table [4](#org956451f) suivante. Les valeurs manquantes associées aux parcelles non couvertes par la pédologie sont \(14\,645\), soit XX %. Ces parcelle correspondent visuellement aux espaces urbanisés bien que cela ne se retrouve pas vraiment à partir du MOS. A DECIDER.

| NOM      |  | TYPE        |  | DESCRIPTION                                                              |
|-------- |--- |----------- |--- |------------------------------------------------------------------------ |
| `NOUC`   |  | *Caractère* |  | Numéro de l'unité cartographique (2 caractères)                          |
| `SURFUC` |  | *Numérique* |  | Surface de l'unité cartographique (en hectares)                          |
| `TARG`   |  | *Numérique* |  | Taux d'argile de l'unité typologique dominante (pourcentage)             |
| `TSAB`   |  | *Numérique* |  | Taux de sable de l'unité typologique dominante (pourcentage)             |
| `TLIM`   |  | *Numérique* |  | Taux de limons de l'unité typologique dominante (pourcentage)            |
| `TEXTAG` |  | *Caractère* |  | Classes de textures agrégées en 9 modalités (voir Ay, 2011)              |
| `EPAIS`  |  | *Numérique* |  | Épaisseur des sols de l'unité typologique dominante (centimètre)         |
| `TEG`    |  | *Numérique* |  | Taux d'éléments grossiers de l'unité typologique dominante (pour mille)  |
| `TMO`    |  | *Numérique* |  | Taux de Matière organique de l'unité typologique dominante (pourcentage) |
| `RUE`    |  | *Numérique* |  | Réserve Utile par excès de l'unité typologique dominante (millimètre)    |
| `RUD`    |  | *Numérique* |  | Réserve Utile par défaut de l'unité typologique dominante (millimètre)   |
| `OCCUP`  |  | *Numérique* |  | Part de l'unité typologique dominante dans l'unité carto (entre 0 et 1)  |
| `DESCRp` |  | *Caractère* |  | Libellé de la classe pédologique en 33 modalités                         |


<a id="org89599a3"></a>

## Enrichissement des AOC de 1936

Les AOC en vigueur en 1936 à la création de l'INAO ont été obtenues de la Maison des Sciences de l'Homme de Dijon (Licence?? avec l'aide de Florian Humbert). Un travail préalable a été effectué sur les AOC de 1936 afin de compiler les différentes années de 1936 à 1940. La localisation est effectuée par le centroïde des parcelles cadastrales car la géométrie des polygones ne correspond pas parfaitement (à la fois par la numérisation et parce que le cadastre a changé). Encore une fois, la faible taille des parcelle permet d'avoir confiance en cette procédure d'appariement.

```R
Hist.Aoc <- readOGR("Carto/", "Aoc1936")
Geo.Ras@data <- cbind(Geo.Ras@data, over(Pts.Cad, Hist.Aoc))
sapply(Geo.Ras@data[, 57: 58], function(x) sum(is.na(x)))
```

    OGR data source with driver: ESRI Shapefile 
    Source: "/home/jsay/geoInd/Carto", layer: "Aoc1936"
    with 56 features
    It has 2 fields
    AOC36lab AOC36lvl 
          70       70

Nous obtenons des aires sensiblement plus réduites que les actuelles, 27% au lieu de 55% trouvés ci-dessus. Hormis le creux de 1938, entre 10 et 15% des parcelles sont classées chaque années, sachant qu'il y a du double compte. Les premiers crus n'apparaissent pas car ils n'existaient pas à l'époque (création en 1948). le décret instaurant les Premiers Crus ne fut toutefois adopté qu’en 1943. Deux classements historiques servirent de principales références à la désignation de ces ceux-ci: celui de Jules Lavalle de 1855 et le Classement du Comité d’Agriculture et de Viticulture de l’Arrondissement de Beaune de 1860. Ces données sur les AOC de 1936 ne sont pas utilisées dans la suite de l'article.

| NOM        |  | TYPE        |  | DESCRIPTION                                                   |
|---------- |--- |----------- |--- |------------------------------------------------------------- |
| `AOC36lab` |  | *Caractère* |  | Libellé de l'appellation en 1936 (56 modalités)               |
| `AOC36lvl` |  | *Caractère* |  | Rang de la parcelle dans la hiérarchie des AOC (entre 0 et 5) |


<a id="org3cf0172"></a>

## Enrichissement des lieux dits

Il s'agit ici d'inclure de l'information cadastrale à partir des sources `data.gouv.fr`. Nous utilisons le Plan Cadastral Informatisé Vecteur (Format EDIGÉO, <https://cadastre.data.gouv.fr/datasets/plan-cadastral-informatise>) téléchargé pour la Côte d'Or (21) le <span class="timestamp-wrapper"><span class="timestamp">&lt;2019-01-13 dim.&gt;</span></span>. License ouverte Etalab. La difficulté avec les lieux dit est qu'ils doivent être croisés avec les communes car un même nom lieu dit peut être présent sur plusieurs communes. Comme la géométrie des lieux dits et des parcelles colle parfaitement, nous pouvons enrichir les données parcellaires directement par le centroïde. Ajout <span class="timestamp-wrapper"><span class="timestamp">&lt;2019-01-23 mer.&gt;</span></span>, des données communales, nous extrayons également les coordonnées des chefs-lieux pour calculer une distance à vol d'oiseaux, la population (peuvent être des sur-identifications sur le land use) et la distinction Côte de Beaune / Côtes de Nuits. Nous enregistrons également une shapefile `MapCom` qui permet de cartographier les contours communaux dans les figures.

```R
Lieu.Dit <- readOGR("./Carto/", "LieuDit")
Geo.Ras@data <- cbind(Geo.Ras@data, over(Pts.Cad, Lieu.Dit[, -1]))
sapply(Geo.Ras@data[, 59: 68], function(x) sum(is.na(x)))
```

    OGR data source with driver: ESRI Shapefile 
    Source: "/home/jsay/geoInd/Carto", layer: "LieuDit"
    with 3285 features
    It has 11 fields
    
     LIEUDIT   CLDVIN   LIBCOM     XCHF     YCHF   ALTCOM   SUPCOM 
        4494     4494     4494     4494     4494     4494     4494 
      POPCOM CODECANT   REGION 
        4494     4494     4494

Pour 4% des parcelles, aucun lieu dit n'a été apparié. Ces parcelles se concentrent sur les communes de Chenôve, Marsannay-la-Côte et Beaune (Corgoloin dans une moindre mesure). Ces "trous" apparaissent déjà dans le fichier source et ne sont donc pas un résultat de l'appariement. Ils semblent être des espaces bâtis sur la carte, mais ce n'est toujours pas confirmé par le MOS.

| NOM        |  | TYPE        |  | DESCRIPTION                                                     |
|---------- |--- |----------- |--- |--------------------------------------------------------------- |
| `LIEUDIT`  |  | *Caractère* |  | Libellé du lieu dit de la parcelle (2691 modalités)             |
| `CLDVIN`   |  | *Caractère* |  | Identifiant du lieu dit de la parcelle (2691 modalités)         |
| `LIBCOM`   |  | *Caractère* |  | Libellé de la commune de la parcelle (31 modalités)             |
| `XCHF`     |  | *Numérique* |  | Latitude du chef-lieu de la commune (système Lambert 93)        |
| `YCHF`     |  | *Numérique* |  | Longitude du chef-lieu de la commune (système Lambert 93)       |
| `ALTCOM`   |  | *Numérique* |  | Altitude du point culminant de la commune (mètre)               |
| `SUPCOM`   |  | *Caractère* |  | Superficie de la commune de la parcelle (hectare)               |
| `POPCOM`   |  | *Numérique* |  | Population de la commune de la parcelle en 2015 (millier d'hab) |
| `CODECANT` |  | *Caractère* |  | Identifiant du canton d'appartenance (2 caractères)             |
| `REGION`   |  | *Caractère* |  | Region viticole (`CDB` Côte de Beaune, `CDN` Côte de Nuits)     |


<a id="org45d961e"></a>

## Enregistrement de la base

Pour l'instant, on est à moins de 500 Mo. C'est le résultat de tous ces traitements que l'on va mettre sur le *dataverse* de l'INRA. La partie reproductible du data paper commence ici.

```R
dim(Geo.Ras)
save(Geo.Ras, file= "Inter/GeoRas.Rda")
writeOGR(Geo.Ras, "Carto/", "GeoRas", driver= "ESRI Shapefile")
```

    [1] 110350     68


<a id="Sec:2"></a>

# Statistiques descriptives


<a id="org9dbe000"></a>

## Sélection des données

Nous commençons l'analyse par le chargement du fichier `GeoRas.Rda` issue du serveur data de l'INRA que l'utilisateur doit télécharger puis placer dans un répertoire `Inter/` dans le répertoire de travail de R (soit le répertoire renvoyé par la commande `getwd()`). La première procédure à exécuter est présentée ci-dessous, elle consiste à :

-   Recoder les codes communaux selon le gradient Nord-Sud
-   Calculer la distance de chaque parcelle au chef lieu de sa commune
-   Centrer et réduire la variable sur les rayonnements solaires
-   Recoder la variable exposition en 8 catégories
-   Re-projeter les coordonnées dans le système WGS84
-   Enlever les valeurs manquantes de la base de données

```R
library(sp) ; load("Inter/GeoRas.Rda")
tmp <- unique(Geo.Ras$LIBCOM[order(Geo.Ras$YCHF, decreasing= TRUE)])
Geo.Ras$LIBCOM <- factor(Geo.Ras$LIBCOM, levels= tmp)
Geo.Ras$DISTCHF <- sqrt((Geo.Ras$XL93- Geo.Ras$XCHF* 100)^2
                        + (Geo.Ras$YL93- Geo.Ras$YCHF* 100)^2)
Geo.Ras$RAYAT <- (Geo.Ras$SOLAR- mean(Geo.Ras$SOLAR, na.rm= TRUE))/
    sd(Geo.Ras$SOLAR, na.rm= TRUE)
Geo.Ras$EXPO <- cut(Geo.Ras$ASPECT,
                    breaks= c(-2, 45, 90, 135, 180, 225, 270, 315, 360))
GR84 <- spTransform(Geo.Ras, CRS("+proj=longlat +ellps=WGS84"))
dd <- coordinates(GR84) ; Geo.Ras$X= dd[, 1] ; Geo.Ras$Y= dd[, 2]
dim(Reg.Ras <- subset(Geo.Ras, !is.na(AOClb) & !is.na(DEM) & !is.na(DESCR)
                      & !is.na(RUD) & !is.na(AOC36lab) & !is.na(REGION)))
```

    [1] 59113    73

Nous obtenons une base de données avec \(59\,113\) observations. Le principal critère de sélection des parcelles provient de la limitation aux parcelles ayant au moins une AOC. Sur la zone, nous avons \(60\,632\) (\(=110\,350-49\,718\)) parcelles dans ce cas, ce qui signifie que le retrait des valeurs manquantes cause la perte de seulement \(1\,519\) parcelles (\(=60\,632-59\,113\)).


<a id="orgdf859cd"></a>

## Distribution des AOC

Nous pouvons désormais présenter plus en détails la distribution des AOC sur les parcelles de la zone. Il y a en particulier 2 informations typiquement reportées sur les étiquettes des bouteilles de vins. Une première information est de type verticale, elle consiste à mentionner le niveau de l'AOC dans la hiérarchie régionale. Cette information est contenue dans la variable `AOC`. La deuxième information est de type horizontale, avec la mention de la commune d'appartenance de la parcelle, sans qu'il n'y ai de hiérarchie entre les communes. Cette information est contenue dans la variable `LIBCOM`. Le code ci-dessous permet de reproduire la Figure XX de Ay (2019) avec les pourcentages de chaque niveau d'AOC au sein de chaque commune.

```R
library(lattice) ; library(RColorBrewer)
fig.dat <- aggregate(model.matrix(~0+ factor(Reg.Ras$AOC))*
                     Reg.Ras$AREA/ 1000, by= list(Reg.Ras$LIBCOM), sum)
names(fig.dat) <- c("LIBCOM", "BGOR", "BOUR", "VILL", "PCRU", "GCRU")
fig.dat$LIBCOM <- factor(fig.dat$LIBCOM, lev= rev(levels(fig.dat$LIBCOM)))
fig.crd <- t(apply(fig.dat[, -1], 1, function(t) cumsum(t)- t/2))
fig.lab <- round(t(apply(fig.dat[, -1], 1, function(t) t/ sum(t)))* 100)
my.pal  <- brewer.pal(n= 9, name = "BuPu")[ 2: 8]
barchart(LIBCOM~ BGOR+ BOUR+ VILL+ PCRU+ GCRU, xlim= c(-100, 10200),
         xlab="Surfaces sous appellation d'origine contrôlée (hectare)",
         data= fig.dat, horiz= T, stack= T, col= my.pal, border= "black",
         par.settings= list(superpose.polygon= list(col= my.pal)),
         auto.key= list(space= "top", points= F, rectangles= T, columns= 5,
                        text=c("Coteaux b.", "Bourgogne",
                               "Village", "Premier cru", "Grand cru")),
         panel=function(x, y, ...) {
             panel.grid(h= 0, v = -11, col= "grey60")
             panel.barchart(x, y, ...)
             ltext(fig.crd, y, lab= ifelse(fig.lab> 0, fig.lab, ""))})
```

<./Figures/InterGIs.pdf>


<a id="org4ea144a"></a>

## La pyramide des AOC

Les AOC en Bourgogne sont souvent représentés sous forme pyramidale (voir par exemple <https://www.vins-bourgogne.fr/plan-de-site/classification-des-appellations,2314,12208.html>) en accord avec le principe qu'en montant dans la hiérarchie les surfaces de vigne concernées deviennent moins importantes. Cette structure pyramidale est *a priori* observable à l'échelle régionale mais pas à l'échelle départementale. Étant donné que nous travaillons sur un sous-échantillon des vignes de Bourgogne, limité au département de la Côte d'Or, nous n'obtenons pas cette structure pyramidale comme en atteste la Figure ci-dessous. Il apparaît que les AOC inférieures (Bourgogne régional, Coteaux Bourguignons) sont sous-représentées, à la fois dans la Côte de Beaune et la Côte de Nuits.

```R
ddd <- aggregate(Reg.Ras$AREA/ 10000,
                 by= list(Reg.Ras$AOC, Reg.Ras$REGION), sum, na.rm= TRUE)
names(ddd) <- c("AOC", "REGION", "SURFACES")
ddd$SURFACES[ddd$REGION== "CDB"] <- -ddd$SURFACES[ddd$REGION== "CDB"]
library(ggplot2)
ggplot(ddd, aes(x= AOC, y= SURFACES, fill= REGION))+ 
    geom_bar(data= subset(ddd, REGION== "CDB"), stat= "sum")+
    geom_bar(data= subset(ddd, REGION== "CDN"), stat= "sum")+
    coord_flip()+ theme_bw()+ ylab("Surfaces en hectares")+
    xlab("Niveau d'Indication Géographique")
```

<./Figures/PyramGIs.pdf>

Nous observons des distributions presque symétriques avec un niveau village majoritaire. Notons que la Côte de Nuits est relativement privilégiée par rapport à la Côte de Beaune en termes de grands crus mais compte moins de surfaces totales.


<a id="orgf38d83f"></a>

## Tableau des variables utilisées

Le détails des variables utilisées dans l'analyse économétrique est détaillé dans ce qui suit. Nous observons des surfaces faible (moyenne de 0.2 ha), des altitudes comprises entre 200 et 500 m (moyenne à 286), des pentes entre 0 et 37 (moyenne à 5.75) et des radiations solaires entre \(581\,000\) et 1.2 millions de Joules. Les vignobles sous AOC sont globalement orientés à l'Est.

```R
Stat.Ras <- data.frame(Reg.Ras@data, model.matrix(~0+ factor(Reg.Ras$AOC)),
                       model.matrix(~ 0+ factor(Reg.Ras$EXPO)))
names(Stat.Ras)[74: 78] <- paste0("AOC", 1: 5)
names(Stat.Ras)[79: 86] <- paste0("EXPO", 1: 8)
Stat.Ras$AREA  <- Reg.Ras$AREA/ 1000
Stat.Ras$DEM   <- Reg.Ras$DEM/ 1000
Stat.Ras$SOLAR <- Reg.Ras$SOLAR/ 1000000
lab <- c(AREA= "Surface [1000 m$^2$]", DEM= "Altitude [1000 m]",
         SLOPE= "Pente [degrés]", SOLAR=  "Radiation solaire [millions J]",
         X= "Longitude [degrés]", Y= "Latitude [degrés]",
         AOC1= "Niveau AOC Coteaux", AOC2= "Niveau AOC Régional",
         AOC3= "Niveau AOC Village", AOC4= "Niveau AOC Premier Cru",
         AOC5= "Niveau AOC Grand Cru",
         EXPO1= "Exposition [$0-45$]"   , EXPO2= "Exposition [$45-90$]",
         EXPO3= "Exposition [$90-135$]" , EXPO4= "Exposition [$135-180$]",
         EXPO5= "Exposition [$180-225$]", EXPO6= "Exposition [$225-270$]",
         EXPO7= "Exposition [$270-315$]", EXPO8= "Exposition [$315-360$]") 
library(stargazer)          
stargazer(Stat.Ras[, names(lab)], covariate.labels=lab, font.size= "small",
          column.sep.width= "0pt", float= T, digit.separate= c(0, 3),
          title= "\\textbf{Statistiques descriptives des variables utilisées}")
```


<a id="Sec:3"></a>

# Modèle économétrique


<a id="org08cde19"></a>

## Estimation du modèle

Nous abordons désormais l'estimation du modèle économétrique. Comme expliqué dans l'article académique associé (Ay, 2019), il s'agit d'un modèle ordonnée additivement semi-paramétrique (OGAM) qui prend en compte la structure hiérarchique des AOC. Nous supposons en effets que les désignations des AOC suivent une règle de décision basée sur une variable latente de qualité biophysique des vignes qui franchit des seuil. Ce type de modèle est estimé avec la fonction `gam` du package `mgcv` comme décrit récemment par <sup id="288ff4c397fcb33b93de861cedf4c4e5"><a href="#WPSa16" title="Wood, Pya \&amp; S\afken, Smoothing parameter and model selection for general smooth models, {Journal of the American Statistical Association}, v(516), 1548--1563 (2016).">WPSa16</a></sup>. Nous renvoyant à cette référence académique et au livre de l'auteur <sup id="7428cca95c8f1a0339bd46afd86d6e00"><a href="#Wood17" title="Wood, Generalized additive models: An introduction with R, Chapman and Hall/CRC, second edition (2017).">Wood17</a></sup> pour plus de détails.

Notons qu'en préalable nous opérons un regroupement des unités géologiques et pédologiques afin de pouvoir les inclure en effets fixes dans le modèle. En effet, un nombre trop faible d'observation au sein d'un effet fixe diminue sensiblement la précision de l'estimateur et peut poser des problème de convergence. Nous choisissons arbitrairement le seuil de \(1\,000\) observations, nos résultats sont néanmoins robustes à ce choix. Notons également que le modèle que nous estimons dans cet article opère un lissage spatial fin (avec un nombre maximal de degré de liberté de 900 sur les termes spatiaux) ce qui implique une procédure estimation assez longue (environ 9 heures avec un processeur Intel Core i7-7820HQ CPU 2.90 GHz x8 et 64 Go of RAM). D'autres modèles plus parcimonieux sont également présents dans l'objet `gamod.Rda` téléchargeable sur le serveur data de l'INRA. L'ensemble des modèle est présenté en détails dans l'article académique.

```R
Reg.Ras$NOTATION <- factor(Reg.Ras$NOTATION)
tmp <- table(Reg.Ras$NOTATION)< 1000
Reg.Ras$GEOL <- factor(
    ifelse(Reg.Ras$NOTATION %in% names(tmp[ tmp]), "0AREF",
           as.character(Reg.Ras$NOTATION)))
Reg.Ras$NOUC <- factor(Reg.Ras$NOUC)
tmp <- table(Reg.Ras$NOUC)< 1000
Reg.Ras$PEDO <- factor(
    ifelse(Reg.Ras$NOUC %in% names(tmp[tmp]), "0AREF",
           as.character(Reg.Ras$NOUC)))
library(mgcv) ; load("Inter/gamod.Rda")
## system.time(
##     gam900 <- gam(AOC~ 0+ LIBCOM+ EXPO+ GEOL+ PEDO 
##                   + s(DEM)+ s(SLOPE)+ s(RAYAT)+ s(X, Y, k= 900)
##                 , data= Reg.Ras, family= ocat(R= 5))
## )
## utilisateur     système      écoulé 
##    32271.43       93.78    32366.00 
## save(gam900, file= "Inter/gam900.Rda")
anova(gamod$gam900)
```

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

Ce modèle produit 90% de bonnes prédictions avec un pseudo R\(^2\) égal à 0.75. Au regard des statistiques de \(\chi^2\) ci-dessus, les coordonnées spatiales sont les variables explicatives les plus importantes, suivies des indicatrices communales, de l'altitude, le rayonnement solaire, la géologie, la pédologie, la pente et l'exposition.


<a id="org75b9236"></a>

## Variables biophysiques

Nous pouvons alors représenté l'effet marginal des variables biophysiques sur la variable latente de qualité continue des parcelles de vigne. La fonction `plot` par défaut du package `mgcv` permet de représenter graphiquement ces effets en fixant toutes les autres variables explicatives du modèle à leurs moyenne. Notons également dans le graphique ci-dessous que les effets ont une moyenne normalisée à 0 car le niveau des effets n'est pas identifiable semi-paramétriquement.

```R
plot(gamod$gam700, page= 1, scale= 0)
```

<./Figures/GamPlot.pdf>

Des Figures plus détaillées qui contiennent en particulier les effets associés aux autres modèles sont reportées dans l'article associé. La structure des effets reste cependant robuste à la spécification, elle reste proche de ce qui est observé dans la Figure XX. L'altitude et la pente ont des effets en U inversé, le rayonnement solaire a un effet linéaire à proximité de sa moyenne (la présence de valeur extrême entraîne de forte non linéarité qui concernent que très peu d'observations). Enfin, les effets spatiaux semblent se structurer dans une relation de centre/ périphérie.


<a id="org2c65138"></a>

## Effets communaux

Les valeurs estimées des effets fixes communaux sont d'un intérêt particulier car ils correspondent à la partie historique des désignations, au sein où ils représente la partie de la variable latente qui n'est pas expliquée par les caractéristiques biophysiques des vignes. Étant donné la finesse du lissage spatial, nous pouvons être confiant sur le contrôle d'effet de *terroir* potentiellement non captés par les variables topographiques, géologiques et pédologiques. Cette interprétation des effets fixes communaux se retrouve dans certains travaux d'historiens pour lesquels nos résultats offre une sorte de confirmation statistique. En effet, Christophe Lucand dans <sup id="7e3cc4e952baf2ace29bc97117ad514c"><a href="#WJac11" title="Wolikow \&amp; Jacquet, Territoires et terroirs du vin du XVIIIe au XXIe si&#232;cles, &#201;ditions Universitaires de Dijon (2011).">WJac11</a></sup> évoque l'existence d'une hiérarchie implicite des communes "qui ne détermine cependant en rien la réalité des zones d'approvisionnement concernées. Il s'agit plutôt d'identifications commerciales communes, investies d'un plus ou moins grand capital symbolique hérité. Ce capital symbolique hérité attribut un prestige plus ou moins grand à certaines communes ou propriétaires particulier." Les effets fixes que nous estimons peuvent alors être vus comme des mesure de ce capital symbolique. De manière complémentaire, <sup id="aabd8d871d4bfd7dce750e0ec786fb3d"><a href="#Jacq09" title="Jacquet, Un si{\`e}cle de construction du vignoble bourguignon. Les organisations vitivinicoles de 1884 aux AOC, Editions Universitaires de Dijon (2009).">Jacq09</a></sup> étudie la structuration des syndicats de viticulteurs qui s'opère quasi-exclusivement à l'échelle communale et mentionne le fait que (p.193) "plus l'appellation requise se calque sur le syndicat qui la défend, plus elle a de chance d'émerger et d'être délimitée strictement". Les effets fixes communaux peuvent donc également mesurer l'action des syndicats.

```R
library(latticeExtra) ; yop <- summary(gamod$gam900)
plogi <- function(x) exp(x/ sqrt(2))/ (1+ exp(x/ sqrt(2)))
cf <- yop$p.coeff[ 4: 31]- mean(yop$p.coeff[ 4: 31])
se <- yop$se[ 4: 31]
names(gamod$gam900$coef[ 4: 31])
zz <- data.frame(LIBCOM= substr(names(gamod$gam900$coef[ 4: 31]), 7, 30),
                 REGION= c(rep("tomato", 12), rep("chartreuse", 16)),
                 OS= 2* plogi(cf)- 1,
                 OSi= 2* plogi(cf- 1.5* se)- 1,
                 OSa= 2* plogi(cf+ 1.5* se)- 1)

foo_key <- list(x = .35, y = .95, corner = c(1, 1),
            text = list(c("Côte de Beaune", "Côte de Nuits")),
            rectangle = list(col = c("chartreuse", "tomato")))

segplot(reorder(factor(LIBCOM), OS)~ OSi+ OSa,
        length= 5, draw.bands= T,
        key= foo_key,
        data= zz[order(zz$OS), ], center= OS, type= "o",
        col= as.character(zz$REGION[order(zz$OS)]),
        unit = "mm", axis = axis.grid, col.symbol= "black", cex= 1, 
        xlab= "Mesure de supériorité ordinale et intervalles à 10 %")
```

<./Figures/ComGam.pdf>

Nous traduisons les coefficients estimés en mesure de supériorité ordinale comme cela est présenté dans <sup id="ba4181a0e7dae7fbb217e69ee0b575b4"><a href="#AKat17" title="Agresti \&amp; Kateri, Ordinal probability effect measures for group comparisons in multinomial cumulative link models, {Biometrics}, v(1), 214--219 (2017).">AKat17</a></sup>. Les valeurs obtenus s'interprètent alors plus intuitivement : les valeurs reportées en abscisses correspondent aux probabilité qu'une parcelle de la commune reportée en ordonnées soit mieux classée qu'une parcelle aux caractéristiques biophysiques identiques mais localisée dans une commune au hasard. Le communes relativement favorisées par les AOC apparaissent en haut de la Figure et les communes relativement défavorisées en bas. Les intervalles de confiance qui encadrent les valeurs moyennes sont différents de ceux reportés dans l'article académique. Au lieu de représenter l'incertitude quand à la spécification des effets spatiaux, ils représentent ici l'incertitude associée à l'estimation des effets fixes.


<a id="org33b3078"></a>

## Prédiction continue

En complément de l'estimation d'effets communaux, un intérêt important de cette modélisation économétrique est la possibilité de prédire un score continue pour chaque parcelle selon ses caractéristiques biophysiques. Cette possibilité de classification continue est vraiment l'originalité du travail présentée dans cet article, peu développé dans l'article académique. Notons que cette classification continue des parcelles est directement issue des AOC qui existent aujourd'hui et ne se base donc pas sur des appréciations subjectives sur ce qui fait la qualité d'une vigne ou d'un vin. Les appréciations subjectives se limitent au choix du modèle économétrique (le lissage spatial en particulier, mais aussi la spécification des effets des autres variables explicatives). Le principe de reproductibilité devrait permettre l'utilisation de méthodes alternatives pour produire des classifications alternatives.

Nous proposons ici simplement deux sorties principales du modèle économétrique : la valeur latente de la qualité avec les effets fixes communaux (ce qui signifie que les prédictions ne sont pas corrigées) et la valeur latente de la qualité sans les effets fixes communaux (les moyenner permet de corriger les prédictions). Le code suivant présente la mise en oeuvre des prédictions et leur normalisation pour qu'ils soient distribués entre 0 et 100. Nous les appellerons alors des scores, bruts ou corrigés.

```R
Prd.Ras <- subset(Geo.Ras, !is.na(AOClb))
Prd.Ras$GEOL <- ifelse(Prd.Ras$NOTATION %in% levels(Reg.Ras$GEOL),
                       as.character(Prd.Ras$NOTATION), "0AREF")
Prd.Ras$PEDO <- ifelse(Prd.Ras$NOUC %in% levels(Reg.Ras$PEDO),
                       as.character(Prd.Ras$NOUC), "0AREF")
## prd <- predict(gamod$gam900, newdata= Prd.Ras@data, type= "terms")
Prd.Ras$LTraw <- rowSums(prd, na.rm= TRUE)
Prd.Ras$LTcor <- mean(prd[, 1], na.rm= T)+ rowSums(prd[, -1], na.rm= T)
unini <- function(x) (x- min(x))/ (max(x)- min(x))
Prd.Ras$UFraw <- round(unini(Prd.Ras$LTraw)* 100, 2)
Prd.Ras$UFcor <- round(unini(Prd.Ras$LTcor)* 100, 2)
```

Pour le graphique, on a besoin des codes en annexe qui sont également disponibles dans le fichiers `myFcts.R` disponible sur le dataverse de l'INRA. Annexe 4.

balbla clearpage

balbla clearpage

balbla clearpage

balbla clearpage

```R
library(ggplot2) ; library(plyr) ; source("./myFcts.R")
NVA <- c("Coteaux b.", "Bourgogne", "Village", "Premier cru", "Grand cru")
names(NVA) <- 1: 5
cc <- rbind(
    data.frame(AOC= revalue(factor(Prd.Ras$AOC), NVA),
               Score= Prd.Ras$UFraw,
               Pr= "Non corrigé : maintient des effets communaux"),
    data.frame(AOC= revalue(factor(Prd.Ras$AOC), NVA),
               Score= Prd.Ras$UFcor,
               Pr= "Corrigé : suppression des effets communaux"))
ggplot(cc, aes(factor(AOC), Score, fill= Pr))+
    geom_split_violin()+
    ylab("Score de qualité des vignes (échelle de 0 à 100)")+
    ylim(40, 100)+ theme_minimal()+ xlab("")+
    geom_split_violin(draw_quantiles = c(0.25, 0.5, 0.75))+
    theme(legend.justification=c(0, 1), legend.position=c(0, 1),
          legend.title = element_blank())
```

<./Figures/PrdLt.pdf>

Un premier élément du graphique précédent est que les caractéristiques biophysiques permettent de bien discriminer les différents niveaux d'AOC car les distributions se chevauchent peu. Un deuxième élément tient de la correction qui ne produit pas les même conséquences selon le niveau d'AOC. Pour les Coteaux bourguignons, les Villages et les Grands Crus, la correction maintien globalement les scores médians, et leur variance hormis pour le niveau Village où elle augmentent sensiblement. À l'inverse, pour les Bourgogne régionaux et les Premiers crus, les scores médians sont revus à la hausse, ce qui indique la présence de parcelles dans ces niveaux qui sont sous-estimées du fait de leur communes d'appartenance. Cet effet est particulièrement important pour les Premier cru comme on peut le voir dans le déplacement du mode de la distribution.


<a id="org9e77d62"></a>

## Agrégation par lieux dits

Pour faciliter la consultation des résultats de la modélisation, nous agrégeons les scores prédits, ce qui passe par un recodage des délimitations. Nous utilisons les lieux dits administratifs pour localiser plus précisément les parcelles en niveaux d'AOC Coteaux bourguignon, Bourgogne et Village pour lesquels la mention de la parcelle n'est pas reporté sur l'étiquette. Par contre les producteurs ont cette information, et les usagers pourraient la demander. Il s'agit également ici de renommer les premiers crus pour qu'ils soient plus lisibles. (On pourrait le mettre ce travail en préalable, à voir).

```R
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
```

    [1] 2391

Ainsi, des quelques \(60\,000\) parcelles cadastrales utilisées dans la modélisation, nous obtenons environ \(2\,400\) localités, qui correspondent peu ou prou aux lieux dits administratifs.

Nous allons désormais regrouper la géographie des parcelles selon la variable `Contat` tout juste créée. Les scores sont reportés au niveau des nouvelles localités par moyenne pondérée par la surface de chaque parcelle qui l'a compose. Nous calculons également la position de chaque localité dans la hiérarchie continue issue de la modélisation, ce qui permet de présenter les 10 localités les mieux notées. Nous utilisons pour cela les packages XX.

```R
library(data.table) ; Prd.Dtb <- data.table(Prd.Ras@data)
Dat.Ldt <- Prd.Dtb[, .(LIBCOM= LIBCOM[ 1], NOM= NAME[ 1],
                       NIVEAU= NIVEAU[ 1],
                       SURFACE_ha= round(sum(AREA)/ 1e5, 2),
                       SCORE_brut= round(weighted.mean(UFraw, AREA), 2),
                       SCORE_corrigé=round(weighted.mean(UFcor, AREA), 2)),
                   by= Concat]
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
```

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

Sans surprise, les Grands Crus arrivent en haut de la hiérarchie autant de la Côte de Nuits (Chambertin, Grands-Echezeaux) que de la Côte de Beaune (Montrachet, Bâtard-Montrachet). Notons tout de même qu'un Premier Cru arrive en 10ième position, ce qu'il veut dire qu'il dépasse les 2/3 des Grands crus. Le Premier Cru La Combe d'Orveau se trouve sur la commune de Chambolle Musigny qui n'apparaît pas pourtant si désavantagé selon la Figure XX. Cela indique que la haute classification de ce premier cru (en particulier au-dessus du Grand cru Musigny situé sur la même commune) provient des caractéristiques biophysiques et non de la correction communale. Plus étonnant, la Romanée-conti qui apparaît souvent parmi les vins les plus chers du monde (<https://www.wine-searcher.com/most-expensive-wines>) n'apparaît qu'en 26ième position (elle est tout de même dans les 2 % meilleurs). On peut penser que la situation de monopole peut expliquer la fort prix indépendamment des caractéristiques biophysiques.

Nous enregistrons ensuite les résultats dans une base de données géographique de type `sf` qui pourra directement être utilisée dans l'application *Shiny*. Ces résultats sont accessibles sur le serveur data de l'INRA à l'adresse XX. Attention la ligne sur les prédictions est longue (5 minutes) à tourner.

```R
library(sf)
Poly.Ras <- st_as_sf(Poly.Ras)
Poly.Ras <- st_transform(Poly.Ras,crs= 4326)
save(Poly.Ras, file= "Inter/PolyRas.Rda")
```

Sauvegarde disponible sur le serveur de l'INRA.


<a id="Sec:4"></a>

# Application *Shiny*


<a id="orga51e8d4"></a>

## Cartographie dynamique

Ceux qui sont intéressés par l'utilisation de l'application en local peuvent commencer ici.

```R
library(RColorBrewer) ; library(mapview) ; library(sf)
load("Inter/PolyRas.Rda")
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
## mapshot(addLogo(map, "http://www7.inra.fr/fournisseurs/images/logo.jpg",
##                 width = 200, height = 100),
##         url = paste0(getwd(), "/Application/CotePrd.html"),
##         file = paste0(getwd(), "/Application/CotePrd.png"),
##         remove_controls = c("homeButton", "layersControl"))
```


<a id="org5db11eb"></a>

## Lancer l'application localement

Le détails des calculs est reporté en Annexe XX, fichier sur Github. `runApp()`, sinon sur le serveur <https://geoind.shinyapps.io/application/>

```R
library(shiny) ; library(shinydashboard) ; library(shinyjs)
library(leaflet) ; library(maptools) ; library(ggplot2)
Pts.Crd <- st_centroid(Poly.Ras)

source("ui.R")
source("server.R")

shinyApp(ui,server)
```


<a id="org316bfc4"></a>

## Utilisation

Que l'application soit lancée localement ou à distance, le fonctionnement est identique.

Détails des codes reportés en Annexe XX, fichier sur Github

Utilisation.


<a id="org349f98d"></a>

## Développements à venir

<https://www.shinyapps.io/admin/#/dashboard> <http://shiny.rstudio.com/articles/shinyapps.html>

```R
library(rsconnect)
rsconnect::setAccountInfo(name='geoind',
			  token='82F46B13B55046680E20FD09364E805A',
			  secret='XXQkLNx5bGEOAIiAsuBcv9Sz5dYjoj1o/KIiag1G')
rsconnect::deployApp('./Application')
```


<a id="Sec:5"></a>

# Conclusion

Le chiffres d’affaire des signes de qualité c’est 32 milliards d’euros et le budget de l’INAO 32 millions d’euros, c’est un millième du chiffre d’affaires.

```R
sessionInfo()
```


<a id="Sec:6"></a>

# Bibliographie

# Bibliography <a id="Garc11"></a>[Garc11] Garcia, Les \emphclimats du vignoble de Bourgogne comme patrimoine mondial de l'humanit\'e, Ed. Universitaires de Dijon (2011). [↩](#121170804c03a6ffd9b6598b03e5ae59) <a id="WJac11"></a>[WJac11] Wolikow & Jacquet, Territoires et terroirs du vin du XVIIIe au XXIe siècles, Éditions Universitaires de Dijon (2011). [↩](#7e3cc4e952baf2ace29bc97117ad514c) <a id="Capu47"></a>[Capu47] Capus, L'\'Evolution de la l\'egislation sur les appellations d'origine. Gen\`ese des appellations contr\^ol\'ees, L. Larmat (1947). [↩](#95abb746101aa32ae2b154f5bdee7ad0) <a id="Humb11"></a>[Humb11] @phdthesisHumb11, title=L'INAO, de ses origines \`a la fin des ann\'ees 1960: gen\`ese et \'evolutions du syst\`eme des vins d'AOC, author=Humbert, Florian, year=2011, school=Universit\'e de Bourgogne [↩](#36d1387edd76d672ddb30e2817a44c44) <a id="CMar04"></a>[CMar04] Coestier & Marette, Economie de la qualit\'e, La d\'ecouverte (2004). [↩](#90e8d3da1815242f3136e232bea3b79b) <a id="Jacq09"></a>[Jacq09] Jacquet, Un si\`ecle de construction du vignoble bourguignon. Les organisations vitivinicoles de 1884 aux AOC, Editions Universitaires de Dijon (2009). [↩](#aabd8d871d4bfd7dce750e0ec786fb3d) <a id="Ay11"></a>[Ay11] @phdthesisAy11, TITLE = Hétérogénéité de la terre et rareté économique, AUTHOR = Ay, Jean-Sauveur, URL = https://tel.archives-ouvertes.fr/tel-00629142, SCHOOL = Universit\'e de Bourgogne, YEAR = 2011, MONTH = Jul, TYPE = Theses, PDF = https://tel.archives-ouvertes.fr/tel-00629142/file/THESE.pdf, HAL_ID = tel-00629142, HAL_VERSION = v1, [↩](#208d1d7a07cf6fffe3fa96d1717b7a1f) <a id="WPSa16"></a>[WPSa16] Wood, Pya & S\"afken, Smoothing parameter and model selection for general smooth models, <i>Journal of the American Statistical Association</i>, <b>111(516)</b>, 1548-1563 (2016). [↩](#288ff4c397fcb33b93de861cedf4c4e5) <a id="Wood17"></a>[Wood17] Wood, Generalized additive models: An introduction with R, Chapman and Hall/CRC, second edition (2017). [↩](#7428cca95c8f1a0339bd46afd86d6e00) <a id="AKat17"></a>[AKat17] Agresti & Kateri, Ordinal probability effect measures for group comparisons in multinomial cumulative link models, <i>Biometrics</i>, <b>73(1)</b>, 214-219 (2017). [↩](#ba4181a0e7dae7fbb217e69ee0b575b4)


<a id="Sec:A"></a>

# Annexes

**Annexe 1 : Incohérence des AOC**

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

**Annexe 2 : Intitulés géologiques**

```R
trans_geol <- data.frame(
    GEOL= Reg.Ras$GEOL[!duplicated(Reg.Ras$GEOL)],
    GEOf= c(
        "Calcaires massifs de \"Comblanchien\" (Bathonien sup.)",
        "Marnes et calcaires divers (Callovien inférieur)",
        "Marnes et calcaires argileux (Oxfordien moyen)",
        "Eboulis ordonnés cryoclastiques et colluvions diverses",
        "Oolithe ferrugineuse (Oxfordien moyen-sup)",
        "Calcaires hydrauliques de Molesmes et Noiron (Oxfordien sup.)",
        "Colluvions diverses",
        "Dépôts argilo-limoneux, sables et graviers du Villafranchien",
        "Calcaires de Tonnerre, Oisellemont et calcaires à Astartes",
        "Eboulis et glissements de terrains",
        "Calcaires grenus bicolores (Bathonien terminal)",
        "Terrasse argilo-limoneuse de Saint-Usage",
        "Formation de Saint-Cosme (marnes fluvio-lacustres varvées)",
        "Alluvions anciennes indifférenciées, argilo-limoneuses",
        "Calcaires bioclastiques, graveleux, à oolithes (Bathonien inf.)"
    ),
    GEOe= c(
        "Massive limestones from \"Comblanchien\" (upper Bathonian)",
        "Various marls and limestones (lower Callovian)",
        "Marls and argillaceous limestones (middle Oxfordian)",
        "Ordered cryoclastic scree and various colluviums",
        "Ferruginous Oolite (middle-upper Oxfordian)",
        "Hydraulic limestones of Molesmes and Noiron (upper Oxfordian)",
        "Various colluviums",
        "Clay-silt deposits, sand and gravel from Villafranchien",
        "Limestones of Thunder, Oisellemont and limestones in Astartes",
        "Screes and landslides",
        "Two-tone gray limestones (terminal Bathonian)",
        "Clay-silty terrace of Saint-Usage",
        "Formation of Saint-Cosme (varnished fluvio-lacustrine marls)",
        "Undifferentiated ancient alluvium, clay-silty",
        "Bioclastic limestones, gravelly, with oolites (lower Bathonian)")
)
```

**Annexe 3 : Intitulés pédologiques**

```R
trans_pedo <- data.frame(
    PEDO= Reg.Ras$PEDO[!duplicated(Reg.Ras$PEDO)],
    PEDf= c(
        "Vignoble de la Côte de de Beaune",
        "Cônes de déjection du pied de Côte",
        "Côteaux viticoles des Hautes Côtes de Nuits",
        "Courtes pentes marneuses des plateaux plio-pléistocène",
        "Piedmont de la côte viticole",
        "Versants pentus des Hautes Côtes de Beaune",
        "Sommets des collines des Hautes Côtes de Beaune",
        "Alluvions récentes calcaires des vallées (Ouche, Tille, Meuzin)",
        "Pentes liasiques du Haut-Auxois",
        "Basses terrasses gravelo-caillouteuses des plaines alluviales",
        "Basses terrasses argileuses des plaines alluviales",
        "Terrasse argilo-limoneuse de Saint-Usage",
        "Vignoble de la Côte de Nuits",
        "Rebord oriental des plateaux calcaires dominant la Côte viticole"
    ),
    PEDe= c(
        "Vineyard of the Côte de Beaune",
        "Coot footing cones",
        "Wine hills of Hautes Côtes de Nuits",
        "Oxfordian limestone-marly trays of the Hautes Côtes",
        "Short marly slopes of Plio-Pleistocene plateaus",
        "Piedmont of the vineyard of the Côte",
        "Sloping slopes of the Hautes Côtes de Beaune",
        "Summits of the hills of the Hautes Côtes de Beaune",
        "Recent alluvial limestone valleys (Ouche, Tille, Meuzin)",
        "Liastic slopes of Haut-Auxois",
        "Gravelo-stony low terraces of alluvial plains",
        "Low clay terraces of alluvial plains",
        "Vineyard of the Côte de Nuits",
        "Eastern edge of the limestone plateaus overlooking the Côte"
    )
)
```

**Annexe 4 : Code pour le graphique en violon**

```R
GeomSplitViolin <- ggproto("GeomSplitViolin", GeomViolin,
  draw_group = function(self, data, ..., draw_quantiles = NULL) {
    # Original function by Jan Gleixner (@jan-glx)
    # Adjustments by Wouter van der Bijl (@Axeman)
    data <- transform(data, xminv = x - violinwidth * (x - xmin), xmaxv = x + violinwidth * (xmax - x))
    grp <- data[1, "group"]
    newdata <- plyr::arrange(transform(data, x = if (grp %% 2 == 1) xminv else xmaxv), if (grp %% 2 == 1) y else -y)
    newdata <- rbind(newdata[1, ], newdata, newdata[nrow(newdata), ], newdata[1, ])
    newdata[c(1, nrow(newdata) - 1, nrow(newdata)), "x"] <- round(newdata[1, "x"])
    if (length(draw_quantiles) > 0 & !scales::zero_range(range(data$y))) {
      stopifnot(all(draw_quantiles >= 0), all(draw_quantiles <= 1))
      quantiles <- create_quantile_segment_frame(data, draw_quantiles, split = TRUE, grp = grp)
      aesthetics <- data[rep(1, nrow(quantiles)), setdiff(names(data), c("x", "y")), drop = FALSE]
      aesthetics$alpha <- rep(1, nrow(quantiles))
      both <- cbind(quantiles, aesthetics)
      quantile_grob <- GeomPath$draw_panel(both, ...)
      ggplot2:::ggname("geom_split_violin", grid::grobTree(GeomPolygon$draw_panel(newdata, ...), quantile_grob))
    }
    else {
      ggplot2:::ggname("geom_split_violin", GeomPolygon$draw_panel(newdata, ...))
    }
  }
)

create_quantile_segment_frame <- function(data, draw_quantiles, split = FALSE, grp = NULL) {
  dens <- cumsum(data$density) / sum(data$density)
  ecdf <- stats::approxfun(dens, data$y)
  ys <- ecdf(draw_quantiles)
  violin.xminvs <- (stats::approxfun(data$y, data$xminv))(ys)
  violin.xmaxvs <- (stats::approxfun(data$y, data$xmaxv))(ys)
  violin.xs <- (stats::approxfun(data$y, data$x))(ys)
  if (grp %% 2 == 0) {
    data.frame(
      x = ggplot2:::interleave(violin.xs, violin.xmaxvs),
      y = rep(ys, each = 2), group = rep(ys, each = 2)
    )
  } else {
    data.frame(
      x = ggplot2:::interleave(violin.xminvs, violin.xs),
      y = rep(ys, each = 2), group = rep(ys, each = 2)
    )
  }
}

geom_split_violin <- function(mapping = NULL, data = NULL, stat = "ydensity", position = "identity", ..., 
                              draw_quantiles = NULL, trim = TRUE, scale = "area", na.rm = FALSE, 
                              show.legend = NA, inherit.aes = TRUE) {
  layer(data = data, mapping = mapping, stat = stat, geom = GeomSplitViolin, position = position, 
        show.legend = show.legend, inherit.aes = inherit.aes, 
        params = list(trim = trim, scale = scale, draw_quantiles = draw_quantiles, na.rm = na.rm, ...))
}
```

**Annexe 5 : Interface utilisateur de l'application**

```R
ui <- dashboardPage(
  dashboardHeader(
    titleWidth= 550, 
    title= "Classification statistique des vignobles de la Côte d'Or"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    fluidRow(
      box(width= 5, height= 670,
          column(width= 4,
                 selectInput(
                   "niveau", label= "Niveau de l'appellation",
                   choices=
                     c(as.character(unique(Poly.Ras$NIVEAU))),
                   selected= 1)),
          column(width= 4,
                 selectInput(
                   "commune", 
                   label= "Commune de la parcelle",
                   choices= c(
                     as.character(unique(Poly.Ras$LIBCOM)),
                     "TOUTES"), selected= 1)),
          column(width= 4,
                 selectInput(
                     "nom",
                     label= "Lieu dit de la parcelle",
                     choices= c(
                         as.character(unique(Poly.Ras$NOM)),
                         "TOUS"), selected = 1)),
          plotOutput("miplot", width='100%')
          ),
      box(width= 7, 
          column(width = 12, 
                 leafletOutput("mymap", height= 645),
                 fluidRow(verbatimTextOutput("mymap_shape_click"))
          )
      )
    )
  )
)
```

**Annexe 6 : Partie serveur de l'application**

```R
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
        yop <- getPts()$SCORE_corrigé
        if (length(yop)==0) return(NULL)
        top <- round(100-
                     aggregate(I(Poly.Ras$SCORE_corrigé< yop)* 100,
                               by= list(Poly.Ras$NIVEAU), mean)[, 2])
        ggplot(Poly.Ras, aes(x= factor(NIVEAU),
                             y= SCORE_corrigé, fill= factor(NIVEAU)))+
            geom_violin(trim= FALSE)+ theme_minimal()+ ylim(40, 100)+
            geom_boxplot(width=0.1, fill= "white")+
            annotate("text", x= 1: 5, y= 100,
                     label= paste("Top", top, "%"), col= "red", size= 7)+
            labs(title= "Comparaison avec les autres parcelles",
                 x= "\n source: jean-sauveur ay @ inra cesaer, voir https://github.com/jsay/geoInd/",
                 y = "Niveau sur une échelle de 1 à 100")+ 
            scale_fill_manual(values= AocPal)+ 
            theme(legend.position= "none",
                  plot.title = element_text(hjust = 0, size = 16),
                  axis.text.x = element_text(size= 14),
                  axis.title.x = element_text(hjust= 0, size= 14),
                  axis.title.y = element_text(size= 14))+
            scale_x_discrete(expand= expand_scale(mult= 0, add= 1),
                             drop= T)+
            geom_hline(yintercept= yop, lty= 2, col= "red")+
            annotate("text", x= 0.35, y= yop+ 2,
                     label= round(yop, 2), col= "red", size= 8)
    }, height = 575, width = 700)
    ## Pour debugguer, ca permet de voir la valeur des input en direct
    output$table <- renderTable({
        data.frame(inp= names(unlist(reactiveValuesToList(values))),
                   val= unlist(reactiveValuesToList(values)))
  })
}
```
