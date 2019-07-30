---
title:  Déterminants biophysiques des AOC viticoles, Construction des données et modélisation
author: |
  | Jean-Sauveur Ay et Mohamed Hilal
  | UMR CESAER, AgroSup, INRA, Université Bourgogne Franche-Comté
---

# Résumé

<div class="abstract">
Cet article présente la construction d'une base de données au niveau des parcelles cadastrales pour étudier les relations entre les caractéristiques biophysiques (topographie, géologie, pédologie) et les appellations d'origine contrôlée (AOC) viticoles. Sur les 31 communes de la Côte-d'Or qui forment la côte de Beaune et la côte de Nuits, nous proposons une modélisation statistique qui permet de classifier l'ensemble des parcelles sur une échelle de qualité continue exclusivement à partir de leurs caractéristiques biophysiques. Nous montrons en particulier la persistance d'effets communaux significatifs issus d'éléments historiques non reliés aux caractéristiques biophysiques des parcelles. Les données, méthodes et prédictions du modèle sont disponibles sous licence GNU GPL V3 sur [https://data.inra.fr/](https://data.inra.fr/dataset.xhtml?persistentId=doi:10.15454/ZZWQMN) et sont consultables par le biais d'une application *Shiny* sur [http://github.com/jsay/geoInd/](http://github.com/jsay/geoInd/).

**Mots-clés**: Économie viti-vinicole ; signes de qualité ; recherche reproductible ; système d'information géographique ; modélisation économétrique.

</div>


# Table of Contents

1.  [Introduction](#org5b72743)
2.  [Construction des données](#Sec:1)
    1.  [Les AOC à la parcelle cadastrale](#org0c31220)
    2.  [Enrichissement de la topographie](#org8b2255c)
    3.  [Enrichissement de la géologie](#org6e8500f)
    4.  [Enrichissement de la pédologie](#org39e40e3)
    5.  [Enrichissement des AOC historiques](#orga88f2d2)
    6.  [Enrichissement des lieux dits](#org428a78b)
    7.  [Enregistrement de la base](#orgc158d6a)
3.  [Statistiques descriptives](#Sec:2)
    1.  [Sélection des données](#org6caac7b)
    2.  [Distribution des AOC](#orgb406337)
    3.  [La pyramide des AOC](#org0d3bcba)
    4.  [Tableau des variables utilisées](#org94164d5)
4.  [Modèle statistique](#Sec:3)
    1.  [Estimation du modèle](#org6f4b538)
    2.  [Variables biophysiques](#org857b7c4)
    3.  [Effets communaux](#org1a91595)
    4.  [Prédiction continue](#orgcf933f1)
    5.  [Agrégation par lieux dits](#org4fec255)
5.  [Application *Shiny*](#Sec:4)
    1.  [Cartographie dynamique](#org2d5e137)
    2.  [Lancer l'application localement](#org040e58c)
    3.  [Manuel d'utilisation](#orge8c52f8)
6.  [Conclusion](#Sec:5)
    1.  [Remerciements](#orge96c4e6)
7.  [Bibliographie](#Sec:6)
8.  [Annexes](#Sec:A)


<a id="org5b72743"></a>

# Introduction

Les appellations d'origine contrôlée (AOC) viticoles en Bourgogne résultent de processus historiques complexes au cours desquels les parcelles ont été classifiées selon leurs caractéristiques biophysiques au grès des rapports économiques, politiques et sociaux en vigueur <sup id="121170804c03a6ffd9b6598b03e5ae59"><a href="#Garc11" title="Garcia, Les \emph{climats} du vignoble de {B}ourgogne comme patrimoine mondial de l'humanit{\'e}, Ed. Universitaires de Dijon (2011).">Garc11</a></sup><sup>,</sup><sup id="7e3cc4e952baf2ace29bc97117ad514c"><a href="#WJac11" title="Wolikow \&amp; Jacquet, Territoires et terroirs du vin du XVIIIe au XXIe si&#232;cles, &#201;ditions Universitaires de Dijon (2011).">WJac11</a></sup>. La classification actuelle est issue de plusieurs siècles de culture de la vigne, de production de vin et de négociation sur les dénominations. Ces trois ensembles de pratiques forment les usages loyaux et constants selon la doctrine de l'institut national de l'origine et de la qualité (INAO) pour définir, reconnaître et gérer les AOC <sup id="95abb746101aa32ae2b154f5bdee7ad0"><a href="#Capu47" title="Capus, L'{\'E}volution de la l{\'e}gislation sur les appellations d'origine. Gen{\`e}se des appellations contr{\^o}l{\'e}es, L. Larmat (1947).">Capu47</a></sup><sup>,</sup><sup id="36d1387edd76d672ddb30e2817a44c44"><a href="#Humb11" title="@phdthesis{Humb11, title={L'INAO, de ses origines {\`a} la fin des ann{\'e}es 1960: gen{\`e}se et {\'e}volutions du syst{\`e}me des vins d'AOC}, author={Humbert, Florian}, year={2011}, school={Universit{\'e} de Bourgogne} }">Humb11</a></sup>. La complexité des informations contenues dans la référence au lieu de production et leurs évolutions dans le temps sont à la fois des forces et des faiblesses pour les AOC. Elles permettent de simplifier les nombreux déterminants biophysiques de la qualité des vins au risque d'une faible pertinence et d'une opacité croissante pour les acteurs du marché du vin.

La question de la transmission de l'information entre les producteurs et les consommateurs sur la qualité des biens échangés fait l'objet d'une littérature économique abondante <sup id="90e8d3da1815242f3136e232bea3b79b"><a href="#CMar04" title="Coestier \&amp; Marette, Economie de la qualit{\'e}, La d{\'e}couverte (2004).">CMar04</a></sup>. L'asymétrie d'information y est typiquement décrite comme une défaillance de marché qui porte préjudice aux parties prenantes de la relation commerciale. Par contre, le recours aux indications géographiques apparaît comme une solution partielle qui peut segmenter artificiellement la production et générer des rentes non justifiées pour les producteurs au détriment des consommateurs. Nous nous concentrons dans cet article sur la capacité des AOC à simplifier l'information sur les caractéristiques des lieux de production, en laissant de côté la question de la pertinence de cette information pour le marché. Il s'agit de quantifier dans quelle mesure la hiérarchie des AOC bourguignonnes en 5 catégories, Coteaux bourguignons < Bourgogne régional < Bourgogne village < Premier cru < Grand cru, permet de résumer les nombreux déterminants biophysiques de la qualité des vins (topographie, géologie, pédologie). Cette analyse statistique permet de mettre en évidence des déterminants historiques de la hiérarchie des AOC non reliés aux caractéristiques individuelles des parcelles mais reliés à la commune à laquelle elles appartiennent. Nous interprétons ce résultat comme la manifestation de pouvoir de négociation de certaines communes (selon l'influence de leurs résidents, leur notoriété, ou leur proximité aux lieux de décision) lors de la mise en place des AOC.

Le travail sur les données consiste à apparier les informations biophysiques des parcelles cadastrales aux AOC par l'utilisation d'un système d'information géographique. La Section [2](#Sec:1) présente en détail la construction des données, avec en particulier les références aux fichiers sources et le dictionnaire des variables produites. Ce premier travail aboutit à la construction d'une base de données spatialisée librement disponible sous licence GNU GPL V3 sur [https://data.inra.fr/](https://data.inra.fr/dataset.xhtml?persistentId=doi:10.15454/ZZWQMN). La parcelle cadastrale est l'unité géographique de base qui permet l'appariement de variables altimétriques du RGE ALTI\textsuperscript{\textregistered} 5m (IGN), , de variables géologiques de Charm-50 (BRGM), de variables pédologiques du Référentiel Pédologique de Bourgogne (Gis Sol), de variables historiques sur les AOC en 1936 (MSH Dijon) et de variables sur les lieux dits issus du Plan Cadastral Informatisé (DGFiP). Les données construites concernent actuellement les 31 communes qui constituent la côte de Beaune et la côte de Nuits, soient l'ensemble des vignobles du département de la Côte-d'Or à l'exception des hautes côtes et du Châtillonnais (voir \autoref{Fig:1}). Cette base de données permet de relier finement les AOC aux caractéristiques des parcelles dont les vins sont issus, et peut ainsi être utilisée pour d'autres questions de recherche. Par contre, les versions brutes des données compilées ne sont pas diffusables en l'état. C'est ainsi que la Section [2](#Sec:1) présente les traitements effectués, avec les codes R reportés en Annexe, sans que les données qui servent à les alimenter soient disponibles. La partie reproductible de l'article commence réellement dans la Section [3](#Sec:2) qui suit, avec la présentation des principales statistiques descriptives relatives aux données produites.

La Section [4](#Sec:3) contient ensuite le détails de l'estimation du modèle statistique dont la spécification est décrite plus extensivement dans un article associé <sup id="d5f551e637b0632950381ff3346c5e2e"><a href="#Ay19" title="Ay, The informational content of geographical indications, {AAWE Working Paper n XXX}, v(), (2019).">Ay19</a></sup>. Le principe de la modélisation est d'utiliser la structure hiérarchique qui existe entre les différents niveaux des AOC pour simplifier le rôle des caractéristiques biophysiques au travers d'une variable latente de qualité des vignes. Cette variable continue représente un niveau ordinal de qualité des vignes tel que révélé par la hiérarchie des AOC actuelles. Nous présentons l'estimation d'un modèle ordonné additivement semi-paramétrique (OGAM, <sup id="288ff4c397fcb33b93de861cedf4c4e5"><a href="#WPSa16" title="Wood, Pya \&amp; S\afken, Smoothing parameter and model selection for general smooth models, {Journal of the American Statistical Association}, v(516), 1548--1563 (2016).">WPSa16</a></sup>) qui permet de prédire correctement près de 90% des niveaux d'AOC par un lissage spatial fin. Ce modèle permet d'estimer non-paramétriquement l'effet de chaque variable biophysique sur la hiérarchie des AOC. Il permet également d'identifier des effets communaux indépendants des variables biophysiques, potentiellement issus de facteurs humains tels que la réputation de la commune, la proximité à la ville centre (Dijon) ou l'antériorité des syndicats de producteurs <sup id="aabd8d871d4bfd7dce750e0ec786fb3d"><a href="#Jacq09" title="Jacquet, Un si{\`e}cle de construction du vignoble bourguignon. Les organisations vitivinicoles de 1884 aux AOC, Editions Universitaires de Dijon (2009).">Jacq09</a></sup>. L'estimation d'effets communaux significatifs permet de hiérarchiser chaque commune de la zone en fonction de la probabilité qu'une de ses parcelles soit plus haute dans la hiérarchie qu'une parcelle similaire prise au hasard sur la zone <sup id="ba4181a0e7dae7fbb217e69ee0b575b4"><a href="#AKat17" title="Agresti \&amp; Kateri, Ordinal probability effect measures for group comparisons in multinomial cumulative link models, {Biometrics}, v(1), 214--219 (2017).">AKat17</a></sup>. Cela nous permet également de corriger ces effets communaux dans la variable latente de qualité des vignes déduite des AOC, ces effets étant *a priori* non reliés à la qualité des vins produits.

Les prédictions issues du modèle statistique sont reportées (corrigées et non corrigées des effets communaux) dans la base de donnée issue de cette recherche. Ces données alimentent également une application *Shiny* dont le code et le manuel d'utilisation sont présentés dans la Section [5](#Sec:4). Cette application peut être utilisée localement (moyennant la présence du [logiciel R](https://cran.r-project.org/) sur l'ordinateur de l'utilisateur) ou consultable sur internet à l'[adresse dédiée](https://geoind.shinyapps.io/application/). Par le biais de cette application, l'utilisateur peut saisir une référence de vin à partir d'informations typiquement disponibles sur l'étiquette de la bouteille afin d'identifier géographiquement le lieu de production du raisin et son niveau de qualité (avec ou sans correction) sur une échelle normalisée de 0 à 100. Cette information permet une évaluation plus précise que la hiérarchie actuelle des AOC en 5 niveaux, et permet en outre de situer ce vin par rapport aux autres vins du même niveau hiérarchique. Elle permet ainsi d'augmenter l'information disponible au niveau du consommateur pour effecteur ses choix de vin. Il est important de mentionner que la classification obtenue se base exclusivement sur les AOC actuelles et à ce titre ne contient aucune appréciation subjective sur l'importance des différents facteurs biophysiques ou olfactif censés influer sur la qualité d'un vin. La classification obtenue est déduite de la hiérarchie actuelle des AOC qui, au regard de la hiérarchie de prix qu'elle produit, semble crédible pour les acteurs du marché.

Une part de subjectivité persiste toutefois dans la classification proposée. Elle est relative à la spécification du modèle statistique, et le fait d'avoir favorisé des variables biophysiques pour décrire la relation entre les lieux de production et la qualité des vins. Le débat sur l'articulation des facteurs humains et des facteurs naturels de la qualité vin existe depuis plus d'un demi-siècle et produit des discussions toujours d'actualité <sup id="179cacf6073e0a5bd2c08b8f57141208"><a href="#Dion52" title="Dion, Querelle des anciens et des modernes sur les facteurs de la qualit{\'e} du vin, {Annales de g{\'e}ographie}, v(328), 417--431 (1952).">Dion52</a></sup><sup>,</sup><sup id="295ae69c19e4b3eca519fcac1e12d462"><a href="#DChe15" title="Delay \&amp; Chevallier, Roger Dion, toujours vivant!, {Cybergeo: European Journal of Geography}, v(), (2015).">DChe15</a></sup>. C'est pour alimenter ce débat que les analyses présentées dans cet article sont totalement reproductibles à partir de la base de donnée produite. Les codes pour l'estimation du modèle sont reportés dans l'article, afin de permettre l'estimation de modèles alternatifs. L'appariement de données supplémentaires pour relier les AOC aux caractéristiques des lieux est également possible par la géolocalisation des parcelles cadastrales. La transparence des analyses permet aux résultats d'être discutés et contestés afin de faire l'objet d'une appropriation par les chercheurs, les décideurs, les professionnels du secteur, ou les amateurs de vin.


<a id="Sec:1"></a>

# Construction des données


<a id="org0c31220"></a>

## Les AOC à la parcelle cadastrale

L'unité géographique de base est la parcelle cadastrale dont la géométrie est issue de la BD parcellaire de l'IGN version 2014 pour la Côte-d'Or téléchargée le XX/XX/2018. Ces données sont disponibles gratuitement pour la recherche, elle ne peuvent pas faire l'objet d'une diffusion à l'état brut. Trois traitements ont été effectués au préalable et ne sont pas reportés en détail ici. Nous avons calculé avec un système d'information géographique les caractéristiques géométriques (surface, périmètre, et distance maximale entre deux sommets). Nous avons ensuite créé un identifiant pour apparier les parcelles avec les données du modèle numérique de terrain présenté dans la sous-section suivante. Nous avons enfin apparié les délimitations parcellaire des AOC Viticoles de l'INAO disponible à l'adresse \url{https://www.data.gouv.fr/fr/datasets/delimitation-parcellaire-des-aoc-viticoles-de-linao} sous licence ouverte. Les codes R correspondants à ces opérations sont reportés en Annexe A.1.1.

| NOM       |  | TYPE          |  | DESCRIPTION                                                              |
|--------- |--- |------------- |--- |------------------------------------------------------------------------ |
| `IDU`     |  | *Caractère*   |  | Identifiant de la parcelle cadastrale (14 caractères)                    |
| `CODECOM` |  | *Caractère*   |  | Code INSEE de la commune d'appartenance (5 caractères)                   |
| `AREA`    |  | *Numérique*   |  | Surface calculée de la parcelle cadastrale (en mètres carrés)            |
| `PERIM`   |  | *Numérique*   |  | Périmètre calculé de la parcelle cadastrale (en mètres)                  |
| `MAXDIST` |  | *Numérique*   |  | Distance maximale calculée entre deux sommets (en mètres)                |
| `PAR2RAS` |  | *Numérique*   |  | Identifiant pour appariement avec le modèle numérique de terrain         |
| `PAOC`    |  | *Indicatrice* |  | 1 si la parcelle est dans au moins une AOC                               |
| `BGOR`    |  | *Indicatrice* |  | 1 si la parcelle est dans le niveau Coteaux Bourguignon                  |
| `BOUR`    |  | *Indicatrice* |  | 1 si la parcelle est dans le niveau Bourgogne Régional                   |
| `VILL`    |  | *Indicatrice* |  | 1 si la parcelle est dans le niveau Bourgogne Village                    |
| `COMM`    |  | *Indicatrice* |  | 1 si la parcelle est dans le niveau Bourgogne Communal                   |
| `PCRU`    |  | *Indicatrice* |  | 1 si la parcelle est dans le niveau Premier Cru                          |
| `GCRU`    |  | *Indicatrice* |  | 1 si la parcelle est dans le niveau Grand Cru                            |
| `AOC`     |  | *Numérique*   |  | Rang de la parcelle dans la hiérarchie des AOC (entre 0 et 5)            |
| `AOCtp`   |  | *Caractère*   |  | `Appel` si le libellé est une appellation, `Denom` pour dénomination     |
| `AOClb`   |  | *Caractère*   |  | Libellé de l'appellation ou de la dénomination selon la variable `AOCtp` |

L'objet `Geo.Cad`, de la classe `SpatialPolygonsDataFrame` associée au package `sp`, contient \(110\,350\) parcelles et 16 variables que la Table [1](#orgaecc07c) suivante présente plus en détails. L'information issue de la superposition avec la couche INAO sur les AOC est présente dans les variables `PAOC` à `GCRU`. Les \(49\,718\) valeurs manquantes qui apparaissent correspondent aux parcelles hors périmètres AOC. Nous avons retravaillé l'information brute des données INAO dans les trois variables `AOC`, `AOCtp` et `AOClb` qui sont plus opérationnelles pour l'analyse statistique. Selon le principe des replis de la doctrine de l'INAO, les parcelles d'un niveau hiérarchique supérieur peuvent toujours être revendiquées dans un niveau inférieur. La superposition des couches de l'INAO conduit à la présence de plusieurs AOC sur une même parcelle, ce qui entre en contradiction avec une autre partie de la doctrine de l'INAO, à savoir qu'il est interdit de revendiquer des AOC différentes pour un même produit. Dans les faits, les producteurs revendiquent très souvent l'AOC maximale à laquelle ils peuvent prétendre. La variable `AOC` représente cette valeur pour chacune des parcelles, elle est codée `0` pour les parcelles hors AOC, `1` pour les Coteaux bourguignons, `2` pour les Bourgognes régionaux, jusqu'à `5` pour les Grands crus. Par contre, les informations présentes sur l'étiquette des vins peuvent être des appellations ou des dénominations au sein du système des AOC (même si cette distinction n'est pas toujours claires pour les consommateurs, nous utilisons AOC comme le terme générique qui englobe les deux dimensions en précisant lorsque c'est nécessaire). Le libellé `AOClb` contient donc généralement le nom de l'appellation maximale de la parcelle, sauf pour les Bourgognes régionaux (ou la dénomination Bourgogne côte d'or est plus haute dans la hiérarchie mais peu utilisée du fait de sa faible antériorité, l'appellation a été crée en 2015) et les Premiers Crus (dont l'appellation ne fait référence qu'au village alors que les dénominations permettent d'identifier les parcelles).


<a id="org8b2255c"></a>

## Enrichissement de la topographie

Les données sur l'altimétrie sont issues du modèle numérique de terrain RGE ALTI\textsuperscript{\textregistered} 5m (IGN), sous licence XX. Un premier traitement non reporté a été l'attribution de l'identifiant `PAR2RAS` aux cellules du raster par superposition avec le fond vectoriel présenté précédemment. . Nous avons enfin calculé les variables que sont l'altitude, la pente, l'exposition et les radiations solaires . À partir des plus de 14 millions de cellules pour 13 variables, le code en Annexe permet l'agrégation des variables raster au niveau des parcelles. Pour le passage des variables altimétriques initialement disponibles au format raster vers les parcelles au format vectoriel, nous calculons des moyennes à l'échelle des parcelles, sachant que d'autres méthodes d'agrégation ont été utilisées sans différences notables sur les résultats.

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

Les codes qui permettent l'appariement sont reportés en Annexe A.1.2, le dictionnaire des variables topographiques est reporté dans la Table [2](#org4524e72). Nous obtenons \(2\,096\) valeurs manquantes pour lesquelles le code `PAR2RAS` des parcelles ne s'apparie à aucune cellule raster (résultat reporté en Annexe A.1.2). Ces parcelles qui présentent des valeurs manquantes sont conservées dans la base, bien que ce soient de très petites parcelles avec des géométrie particulières et font penser à des "erreurs" du cadastre. Nous les enlèverons au moment de l'analyse statistique sachant que cela revient à enlever 2.7 ha, moins de 0.01 % de la surface totale de la zone. Nous n'utilisons qu'un sous ensemble du MOS lié aux modes d'occupation non agricoles, principalement afin de pouvoir les exclure si nécessaire.


<a id="org6e8500f"></a>

## Enrichissement de la géologie

Les données géologiques sont issues de la Bd Charm-50 du BRGM à l'échelle \(1/50\,000\) disponible sur le site <http://infoterre.brgm.fr> sous licence Ouverte. Nous utilisons ici une extraction du fichier `GEO050K_HARM_021_S_FGEOL_CGH_2154` effectuée en avril 2019 pour le département de la Côte-d'Or. Le seul travail non reporté sur ces données est une sélection des variables qui contiennent moins de 5% de valeurs manquantes et qui présentent des variations (c'est-à-dire une variance non nulle) sur la zone considérée. L'appariement des polygones géologiques avec le parcellaire cadastral est effectué par les centroïdes des parcelles (voir code en Annexe A.1.3), la faible taille moyenne des parcelles sous AOC (moins de 0.2 ha de moyenne) permet de s'assurer de la validité de cette procédure.

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

Le détail des 16 variables géologiques issues de la procédure est disponible dans la Table [3](#orgc33a0b5). La description des variables manque de précision car les données géologiques ne possèdent pas encore, à notre connaissance, de dictionnaire exploitable. Ce manque de précision n'est pas décisif pour l'analyse statistique que nous effectuons (il peut l'être pour d'autres usages) car les variables géologiques sont utilisées par le biais d'effets fixes (c'est-à-dire de variables indicatrices) qui permettent de s'affranchir de la nécessité de spécifier les relations entre les variables géologiques et les AOC. Cette méthode est par ailleurs la plus générale pour contrôler l'hétérogénéité associée à la géologie, car elle permet de s'affranchir d'hypothèses sur la spécification des effets. Comme nous le voyons an Annexe A.1.3, les parcelles non appariées qui produisent des valeurs manquantes sont peut nombreuses (entre 31 et 862 selon les variables) et seront négligées au moment de l'analyse statistique sans conséquences.


<a id="org39e40e3"></a>

## Enrichissement de la pédologie

Les données pédologiques sont extraites du Référentiel Pédologique de Bourgogne : Régions naturelles, pédopaysage et sols de Côte-d'Or (étude 25021, Gis Sol) à l'échelle \(1/250\,000\), compatible avec la base de données nationale DoneSol, sous licence XX (Chrétien, 1998). La localisation des types de sol et l'appariement avec le cadastre s'opèrent par les 194 Unités Cartographiques de Sols de la zone, qui sont des polygones plutôt homogènes en termes de pédo-paysages, bien qu'ils contiennent différents types de sols. Ces derniers, regroupés en unités typologiques, ne peuvent pas être localisés plus précisément, ce qui est un limite importante pour leur usage à l'échelle parcellaire <sup id="208d1d7a07cf6fffe3fa96d1717b7a1f"><a href="#Ay11" title="@phdthesis{Ay11, TITLE = {H&#233;t&#233;rog&#233;n&#233;it&#233; de la terre et raret&#233; &#233;conomique}, AUTHOR = {Ay, Jean-Sauveur}, URL = {https://tel.archives-ouvertes.fr/tel-00629142}, SCHOOL = {{Universit{\'e} de Bourgogne}}, YEAR = {2011}, MONTH = Jul, TYPE = {Theses}, PDF = {https://tel.archives-ouvertes.fr/tel-00629142/file/THESE.pdf}, HAL_ID = {tel-00629142}, HAL_VERSION = {v1}, }">Ay11</a></sup>. En l'absence de données plus fines spatialement, les données parcellaires seront enrichies du code des unités cartographiques et des valeurs de l'unité typologique dominante, c'est-à-dire celle qui est la plus étendue au sein de chaque unité cartographique. Comme pour la géologie, les données pédologiques seront utilisées par des effets fixes au niveau des unités cartographiques, ce qui fait que cette procédure de traitement de l'information n'est pas limitante (elle peut cependant l'être pour d'autres usages). Les libellés des unités cartographiques reportés dans la variable `DESCRp` sont obtenus par un travail manuel à partir du site <https://bourgogne.websol.fr/carto>, les codes utilisés pour l'appariement des données pédologiques à partir des centroïdes des parcelles sont présentés en Annexe A.1.4.

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

Le détails des 13 variables pédologiques issues de la procédure sont disponibles dans la Table [4](#org545b92e). Les valeurs manquantes associées aux parcelles non couvertes par la pédologie sont assez importantes : \(14\,645\) parcelles cadastrales, soient environ 4.25% des surfaces de la zone. Ces parcelles non couvertes sont en revanche peu désignées en AOC (moins de 1% des AOC ont des variables pédologiques manquantes), il s'agit donc très peu de vignes. Une explication intuitive de ces valeur manquantes est l'absence de données pédologiques sur les sols artificialisés, cette interprétation étant corroborée par la cartographie de ces zones. Par contre, ce résultat ne se retrouve pas réellement à partir des usages urbains du MOS. La question de l'échelle des données est ainsi déterminante car les unités cartographiques pour lesquelles les variables pédologiques manques peuvent regrouper des modes d'occupation du sol très différents.


<a id="orga88f2d2"></a>

## Enrichissement des AOC historiques

Les AOC en vigueur à la création de l'INAO en 1936 nous ont été transmises par la Maison des Sciences de l'Homme de Dijon avec l'aide de Florian Humbert. Un travail préalable a été effectué pour obtenir les AOC que nous référons à 1936 alors qu'il s'agit d'une compilation des différentes années de 1936 à 1940. La localisation est toujours effectuée par le centroïde des parcelles cadastrales car la géométrie des polygones ne correspond pas parfaitement (à la fois par la numérisation des cartes historiques et parce que le cadastre a changé). Encore une fois, la faible taille des parcelle permet d'avoir confiance en cette procédure d'appariement qui a été confirmée visuellement dans le détails. Le code pour cette procédure d'appariement est reporté en Annexe A.1.5.

| NOM        |  | TYPE        |  | DESCRIPTION                                                |
|---------- |--- |----------- |--- |---------------------------------------------------------- |
| `AOC36lab` |  | *Caractère* |  | Libellé de l'appellation en 1936 (56 modalités)            |
| `AOC36lvl` |  | *Caractère* |  | Rang de la parcelle dans la hiérarchie des AOC (0, 3 ou 5) |

Nous obtenons des aires sous AOC sensiblement plus réduites que pour les AOC actuelles, elles représentent 27% au lieu de 55% des parcelles. Hormis un creux en 1938, entre 10 et 15% des parcelles sont classées chaque années, sachant toutefois qu'il y a du double compte avec des parcelles qui changent d'AOC. Les dénominations géographiques complémentaires, les Premiers crus en particulier, n'apparaissent pas dans ce données car ils n'existaient tout simplement pas. Le décret instaurant les Premiers crus fut adopté en 1943. Notons que ces AOC historiques sont issus de deux classements préalables (bien que non officiels): celui de Jules Lavalle de 1855 et le Classement du Comité d’Agriculture et de Viticulture de l'Arrondissement de Beaune de 1860. Ces données sur les AOC de 1936 ne sont pas spécifiquement utilisées dans la suite du présent article, mais le sont dans <sup id="d5f551e637b0632950381ff3346c5e2e"><a href="#Ay19" title="Ay, The informational content of geographical indications, {AAWE Working Paper n XXX}, v(), (2019).">Ay19</a></sup>, et pourraient l'être dans toute utilisation alternative des données issues de cette recherche.


<a id="org428a78b"></a>

## Enrichissement des lieux dits

Un dernier enrichissement de la base des parcelles cadastrales provient de l'information cadastrale d'une source alternative disponible sur `data.gouv.fr`. Nous utilisons en effet le Plan Cadastral Informatisé Vecteur <https://cadastre.data.gouv.fr/datasets/plan-cadastral-informatise> téléchargé pour la Côte-d'Or (21) en janvier 2019. C'est données sont en License ouverte Etalab, elles nous permettent d'obtenir les lieux dits pour les parcelles qui sont en niveau Village, Bourgogne, et Coteaux bourguignons. Une difficulté avec les lieux dit est que leur intitulés doivent être croisés avec ceux des communes car un même nom de lieu dit peut être présent sur plusieurs communes. Comme la géométrie des lieux dits et des parcelles colle parfaitement, nous pouvons enrichir les données parcellaires directement par le centroïde. Nous profitons de la procédure pour inclure des données communales, en particulier, les coordonnées des chefs-lieux pour calculer une distance à vol d'oiseaux, la population et la distinction côte de Beaune / côte de Nuits qui peut se révéler pertinente. Nous enregistrons également un shapefile `MapCom` qui permet de cartographier les contours communaux dans les figures de l'article. Le détails des codes est reporté en Annexe A.1.6.

| NOM        |  | TYPE        |  | DESCRIPTION                                                           |
|---------- |--- |----------- |--- |--------------------------------------------------------------------- |
| `LIEUDIT`  |  | *Caractère* |  | Libellé du lieu dit de la parcelle (2691 modalités)                   |
| `CLDVIN`   |  | *Caractère* |  | Identifiant du lieu dit de la parcelle (2691 modalités)               |
| `LIBCOM`   |  | *Caractère* |  | Libellé de la commune de la parcelle (31 modalités)                   |
| `XCHF`     |  | *Numérique* |  | Latitude du chef-lieu de la commune (système Lambert 93)              |
| `YCHF`     |  | *Numérique* |  | Longitude du chef-lieu de la commune (système Lambert 93)             |
| `ALTCOM`   |  | *Numérique* |  | Altitude du point culminant de la commune (mètre)                     |
| `SUPCOM`   |  | *Caractère* |  | Superficie de la commune de la parcelle (hectare)                     |
| `POPCOM`   |  | *Numérique* |  | Population de la commune de la parcelle en 2015 (millier d'hab)       |
| `CODECANT` |  | *Caractère* |  | Identifiant du canton d'appartenance (2 caractères)                   |
| `REGION`   |  | *Caractère* |  | Region viticole (`CDB` pour côte de Beaune, `CDN` pour côte de Nuits) |

Nous observons en Annexe qu'aucun lieu dit n'a été apparié 4% des parcelles. Ces parcelles se concentrent sur les communes de Chenôve, Marsannay-la-Côte et Beaune (Corgoloin dans une moindre mesure). Ces valeurs manquantes apparaissent déjà dans le fichier source et ne sont donc pas un résultat de l'appariement. Ils semblent être des espaces bâtis visuellement, mais ce n'est toujours pas confirmé par le MOS à cause de la question de l'échelle. . Dasn tous les cas, ces valeurs manquantes ne sont pas décisives pour l'analyse statistique présentée dans cet article.


<a id="orgc158d6a"></a>

## Enregistrement de la base

Ces différentes opérations aboutissent à la constitution d'une base de données géographiques disponibles sur le serveur de données de l'INRA [https://data.inra.fr/](https://data.inra.fr/dataset.xhtml?persistentId=doi:10.15454/ZZWQMN). Ces données sont illustrées dans les deux cartes de la \autoref{Fig:1}, qui présentent l'altimétrie à une échelle fine et les AOC, dans leur dimension verticale (niveau hiérarchique) et leur dimension horizontale (commune d'appartenance). Le téléchargement de ces données permet au lecteur d'exécuter les codes R reportés dans la suite de l'article, afin de reproduire nos résultats et de faire tourner l'application *Shiny* localement.


<a id="Sec:2"></a>

# Statistiques descriptives


<a id="org6caac7b"></a>

## Sélection des données

Nous commençons l'analyse par le chargement du fichier `GeoRas.Rda` issue du serveur data de l'INRA que l'utilisateur doit télécharger puis placer dans un répertoire `Inter/` à la racine utilisée par `R` (soit le répertoire renvoyé par la commande `getwd()`). Les données peuvent également être consultées à partir des fichiers shapefile sur le serveur qui sont utilisables dans un système d'information géographique. La première procédure à exécuter est présentée ci-dessous, elle consiste à :

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

    
    [1] 59113    72

Nous obtenons une base de données qui contient \(59\,113\) observations utilisables pour estimer le modèle statistique. Le principal critère de sélection des parcelles provient de la limitation aux parcelles ayant au moins une AOC. Sur la zone, nous avons \(60\,632\) (\(=110\,350-49\,718\)) parcelles dans ce cas, ce qui signifie que le retrait des valeurs manquantes cause la perte de seulement \(1\,519\) parcelles (\(=60\,632-59\,113\)).


<a id="orgb406337"></a>

## Distribution des AOC

Nous pouvons désormais présenter plus en détails la distribution des AOC sur les parcelles, en particulier à partir des 2 informations typiquement reportées sur les étiquettes des bouteilles de vins. Une première information est de type verticale, elle consiste à mentionner le niveau de l'AOC dans la hiérarchie. Cette information est contenue dans la variable `AOC`. La deuxième information est de type horizontale, avec la mention de la commune d'appartenance de la parcelle, sans qu'il n'y ai de hiérarchie entre les communes. Cette information est contenue dans la variable `LIBCOM`. Le code ci-dessous permet de reproduire la Figure A.1 de <sup id="d5f551e637b0632950381ff3346c5e2e"><a href="#Ay19" title="Ay, The informational content of geographical indications, {AAWE Working Paper n XXX}, v(), (2019).">Ay19</a></sup> avec les pourcentages de chaque niveau d'AOC au sein de chaque commune.

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


<a id="org0d3bcba"></a>

## La pyramide des AOC

Les AOC en Bourgogne sont souvent représentées sous forme pyramidale (voir par exemple <https://www.vins-bourgogne.fr/plan-de-site/classification-des-appellations,2314,12208.html>) selon le principe qu'en montant dans la hiérarchie les surfaces de vigne concernées deviennent moins importantes. Cette structure pyramidale souvent présentée à l'échelle régionale (à l'échelle de la Bourgogne administrative) ne s'observe pas à l'échelle départementale. Étant donné que nous travaillons sur un sous-échantillon des vignes de Bourgogne, limité au département de la Côte-d'Or, nous n'obtenons pas cette structure pyramidale comme en atteste la Figure ci-dessous. Il apparaît que les AOC inférieures (Bourgogne régional, Coteaux bourguignons) sont sous-représentées, à la fois dans la côte de Beaune et la côte de Nuits.

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

Nous observons des distributions presque symétriques au sein des deux sous-régions viticoles avec un niveau village plus représenté, qui est même majoritaire pour la côte de Nuits. Notons également que la côte de Nuits apparaît comme relativement privilégiée par rapport à la côte de Beaune en termes de grands crus, mais compte moins de surfaces totales sous AOC.


<a id="org94164d5"></a>

## Tableau des variables utilisées

La distribution des variables utilisées dans l'analyse statistique est détaillé dans le \autoref{Tab:1}. Nous observons des surfaces parcellaires faibles (moyenne de 0.2 ha), des altitudes comprises entre 200 et 500 m (moyenne à 286), des pentes entre 0 et 37 (moyenne à 5.75) et des radiations solaires entre \(581\,000\) et 1.2 millions de Joules. Les vignobles sous AOC sont globalement orientés à l'Est.

```R
Stat.Ras <- data.frame(Reg.Ras@data, model.matrix(~0+ factor(Reg.Ras$AOC)),
                       model.matrix(~ 0+ factor(Reg.Ras$EXPO)))
names(Stat.Ras)[73: 77] <- paste0("AOC", 1: 5)
names(Stat.Ras)[78: 85] <- paste0("EXPO", 1: 8)
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

# Modèle statistique


<a id="org6f4b538"></a>

## Estimation du modèle

Nous abordons désormais l'estimation du modèle statistique, dont le processus de spécification est présenté plus extensivement dans <sup id="d5f551e637b0632950381ff3346c5e2e"><a href="#Ay19" title="Ay, The informational content of geographical indications, {AAWE Working Paper n XXX}, v(), (2019).">Ay19</a></sup>. Il s'agit d'estimer un modèle ordonné additivement semi-paramétrique (OGAM) qui prend en compte la structure hiérarchique des AOC de la zone, notée \(y \in \{1, 2, 3, 4, 5\}\) par ordre croissant. Nous supposons que les désignations des AOC suivent une règle de décision basée sur une variable latente de qualité des vignes qui franchit des seuils différentiés selon la commune d'appartenance des parcelles. Ainsi, en notant \(X_i\) les variables biophysiques d'une vigne \(i\) donnée \(i= 1, \dots, N\), et \(C_i\) le vecteur ligne de dimension 31, avec pour élément générique \(c_{ih}\) égal à 1 si la vigne \(i\) se situe dans la *commune* \(h\) et 0 sinon. L'hypothèse d'une distribution logistique de la partie aléatoire des désignations AOC permet de déboucher sur un modèle de logit ordonné classique :

où \(\Lambda\) est la fonction cumulative de la loi logistique. Les déterminants humain qui impactent la classification AOC à partir des seuils de désignation sont pris en compte par des effets fixes communaux notés \(\mu\). En l'absence d'*a priori* théoriques sur les effets des variables biophysiques \(X_i\), nous les spécifions au travers d'une série de transformations *B-splines* que nous notons \(B(\cdot)\) avec \(\beta\) leurs coefficients associés. Le modèle est estimé avec la fonction `gam` du package `mgcv` comme décrit récemment par <sup id="288ff4c397fcb33b93de861cedf4c4e5"><a href="#WPSa16" title="Wood, Pya \&amp; S\afken, Smoothing parameter and model selection for general smooth models, {Journal of the American Statistical Association}, v(516), 1548--1563 (2016).">WPSa16</a></sup>. Le manuel d'utilisation de l'auteur du package <sup id="7428cca95c8f1a0339bd46afd86d6e00"><a href="#Wood17" title="Wood, Generalized additive models: An introduction with R, Chapman and Hall/CRC, second edition (2017).">Wood17</a></sup> contient de nombreux détails méthodologiques.

Notons qu'en préalable à l'estimation, nous opérons un regroupement des unités géologiques et pédologiques afin de pouvoir les inclure comme des variables binaires dans le modèle. En effet, un nombre trop faible d'observation au sein d'une unité géologique ou pédologique diminue sensiblement la précision de l'estimation et peut poser des problèmes de convergence de l'algorithme de régression pénalisée. Nous choisissons de ne retenir que les unités qui contiennent plus de \(1\,000\) parcelles, d'autres valeurs ont été testées sans que cela change les résultats. Notons également que le modèle que nous estimons opère un lissage spatial fin (avec un nombre maximal de degré de liberté effectifs de 900 sur les termes spatiaux) ce qui implique une procédure estimation assez longue (environ 9 heures avec un processeur Intel Core i7-7820HQ CPU 2.90 GHz x8 et 64 Go of RAM). D'autres modèles plus parcimonieux sont également présents dans l'objet `gamod.Rda` téléchargeable sur le [serveur data de l'INRA](https://data.inra.fr/dataset.xhtml?persistentId=doi:10.15454/ZZWQMN). Nous conseillons au lecteur de télécharger `gamod.Rda` plutôt que d'effectuer l'estimation en local du modèle, bien que les deux procédures peuvent être effectuées avec le code ci-dessous.

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

Nous observons en sortie la significativité statistique des différentes variables au regard des statistiques de \(\chi^2\). Les coordonnées géographiques sont les variables explicatives les plus importantes, suivies des indicatrices communales, de l'altitude, du rayonnement solaire, de la géologie, de la pédologie, de la pente et enfin de l'exposition. Ce modèle produit près de 90% de bonnes prédictions pour un pseudo R\(^2\) (au sens de Mc Fadden) égal à 0.76. Les mêmes statistiques peuvent être obtenues pour les autres modèles présents dans l'objet `gamod`, moins lissés spatialement, mais ne sont pas reportées ici.

```R
sum(diag(table(cut(gamod$gam900$line,
                   c(-Inf, gamod$gam900$family$getTheta(TRUE), Inf)),
                   gamod$gam900$model[, 1])))/ nrow(gamod$gam900$model)*100
1- (logLik(gamod$gam900)/ logLik(update(gamod$gam900, . ~ + 1)))
```

    [1] 89.48
    'log Lik.' 0.7565 (df=964)


<a id="org857b7c4"></a>

## Variables biophysiques

Nous pouvons alors représenter les effets marginaux des variables biophysiques sur la variable latente de qualité continue des parcelles de vigne. La fonction `plot` par défaut du package `mgcv` permet de représenter graphiquement ces effets en fixant toutes les autres variables explicatives du modèle à leurs moyennes. Notons également dans le graphique ci-dessous que les effets ont une moyenne normalisée à 0 car le niveau des effets n'est pas identifiable semi-paramétriquement.

```R
plot(gamod$gam700, page= 1, scale= 0)
```

<./Figures/GamPlot.pdf>

Des Figures plus détaillées, qui contiennent en particulier les effets associés aux autres modèles moins lissés, sont reportées dans l'article associé <sup id="d5f551e637b0632950381ff3346c5e2e"><a href="#Ay19" title="Ay, The informational content of geographical indications, {AAWE Working Paper n XXX}, v(), (2019).">Ay19</a></sup>. La structure des effets reste cependant robuste à la spécification, elle reste proche de ce qui est observé dans la Figure A.3 du papier. L'altitude et la pente ont des effets en U inversé, le rayonnement solaire a un effet linéaire à proximité de sa moyenne égale à 0 (la présence de valeurs extrêmes entraîne de forte non linéarité qui concernent que très peu d'observations). Enfin, les effets spatiaux en bas à droite semblent se structurer dans une relation de centre/ périphérie.


<a id="org1a91595"></a>

## Effets communaux

Les coefficients associés aux effets fixes communaux sont d'un intérêt particulier car ils correspondent à la partie historique des désignations AOC, ils représentent la partie de la variable latente de qualité qui n'est pas expliquée par les caractéristiques biophysiques des vignes. Comme présenté dans <sup id="d5f551e637b0632950381ff3346c5e2e"><a href="#Ay19" title="Ay, The informational content of geographical indications, {AAWE Working Paper n XXX}, v(), (2019).">Ay19</a></sup>, la finesse du lissage spatial permet de contrôler les effets de *terroir* potentiellement non captés par les variables topographiques, géologiques et pédologiques. Cette interprétation des effets fixes communaux fait écho à certains travaux historiques pour lesquels nos résultats offre une sorte de confirmation statistique. En effet, Christophe Lucand dans <sup id="7e3cc4e952baf2ace29bc97117ad514c"><a href="#WJac11" title="Wolikow \&amp; Jacquet, Territoires et terroirs du vin du XVIIIe au XXIe si&#232;cles, &#201;ditions Universitaires de Dijon (2011).">WJac11</a></sup> évoque l'existence d'une hiérarchie implicite des communes "qui ne détermine cependant en rien la réalité des zones d'approvisionnement concernées. Il s'agit plutôt d'identifications commerciales communes, investies d'un plus ou moins grand capital symbolique hérité. Ce capital symbolique hérité attribut un prestige plus ou moins grand à certaines communes ou propriétaires particulier." Les effets fixes que nous estimons peuvent alors être vus comme des mesures de ce capital symbolique. De manière complémentaire, <sup id="aabd8d871d4bfd7dce750e0ec786fb3d"><a href="#Jacq09" title="Jacquet, Un si{\`e}cle de construction du vignoble bourguignon. Les organisations vitivinicoles de 1884 aux AOC, Editions Universitaires de Dijon (2009).">Jacq09</a></sup> étudie la structuration des syndicats de viticulteurs qui s'opère quasi-exclusivement à l'échelle communale et mentionne le fait que (p.193) "plus l'appellation requise se calque sur le syndicat qui la défend, plus elle a de chance d'émerger et d'être délimitée strictement". Les effets fixes communaux peuvent donc également mesurer l'action des syndicats, qui apparaît ainsi avoir une forte inertie historique puisqu'ils se retrouvent dans les AOC actuelles.

```R
library(latticeExtra) ; yop <- summary(gamod$gam900)
plogi <- function(x) exp(x/ sqrt(2))/ (1+ exp(x/ sqrt(2)))
cf <- yop$p.coeff[ 4: 31]- mean(yop$p.coeff[ 4: 31]) ; se <- yop$se[ 4: 31]
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

Nous traduisons les coefficients estimés en mesures de supériorité ordinale comme cela est présenté dans <sup id="ba4181a0e7dae7fbb217e69ee0b575b4"><a href="#AKat17" title="Agresti \&amp; Kateri, Ordinal probability effect measures for group comparisons in multinomial cumulative link models, {Biometrics}, v(1), 214--219 (2017).">AKat17</a></sup>. Les valeurs obtenues pour les effets fixes communaux s'interprètent alors plus intuitivement. Les valeurs en abscisses correspondent aux probabilités qu'une parcelle de la commune reportée en ordonnées soit mieux classée qu'une parcelle aux caractéristiques biophysiques identiques mais localisée dans une commune au hasard. Le communes relativement favorisées par les AOC apparaissent en haut de la Figure et les communes relativement défavorisées en bas. Les intervalles de confiance qui encadrent les valeurs moyennes sont différents de ceux reportés dans <sup id="d5f551e637b0632950381ff3346c5e2e"><a href="#Ay19" title="Ay, The informational content of geographical indications, {AAWE Working Paper n XXX}, v(), (2019).">Ay19</a></sup>. Au lieu de représenter l'incertitude quand à la spécification des effets spatiaux, ils représentent ici l'incertitude associée à l'estimation des effets fixes par la procédure statistique. L'ordre de grandeur pour l'incertitude associée à ces estimations reste toutefois similaire.


<a id="orgcf933f1"></a>

## Prédiction continue

Nous pouvons désormais utiliser ce modèle de désignation pour prédire les valeurs de la variable latente de qualité des vignes pour chacune des parcelles de la base de données. Nous obtenons ainsi un score continue pour chaque parcelle selon ses caractéristiques biophysiques, avec les effets communaux potentiellement corrigés. Notons que cette classification continue des parcelles est directement issue des AOC qui existent aujourd'hui et ne se base donc pas sur des appréciations subjectives sur ce qui fait la qualité d'une vigne ou d'un vin. Nous discutons ici deux sorties principales du modèle statistique : la valeur latente de la qualité avec les effets fixes communaux (ce qui signifie que les prédictions ne sont pas corrigées) et la valeur latente de la qualité sans les effets fixes communaux (car prendre la moyenne permet de corriger les prédictions de ces effets). Le code suivant présente le calcul des prédictions et leur normalisation pour qu'ils soient distribués entre 0 et 100. Nous les appellerons alors des scores, respectivement bruts ou corrigés. Attention la ligne sur les prédictions est longue (5 minutes) à tourner.

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


<a id="org4fec255"></a>

## Agrégation par lieux dits

Pour faciliter la consultation des résultats de la modélisation dans l'application, nous agrégeons les scores prédits sur la base d'un recodage des dénominations et la référence aux lieux dits. Nous utilisons pour cela les lieux dits qui permettent en outre de localiser plus précisément les parcelles en niveaux Coteaux bourguignons, Bourgogne régional et Village pour lesquels la mention de la parcelle n'est pas reporté sur l'étiquette. Il s'agit également ici de renommer les premiers crus pour qu'ils soient plus lisibles dans l'application.

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

Ainsi, des quelques \(60\,000\) parcelles cadastrales utilisées dans la modélisation, nous obtenons environ \(2\,400\) localités, qui correspondent aux lieux dits pour les niveaux Coteaux Bourguignons, Bourgogne régional, et Village; ils correspondent aux dénominations retravaillées pour les Premiers crus; et aux appellations pour les Grands Crus.

Nous allons désormais regrouper la géographie des parcelles selon la variable `Contat` tout juste créée. Les scores sont reportés au niveau des nouvelles localités par moyenne pondérée par la surface de chaque parcelle qui la compose. Nous calculons également la position de chaque localité dans la hiérarchie continue issue de la modélisation, ce qui permet de présenter en sortie du code ci-dessous les 10 localités les mieux notées sur la base des scores corrigés.

```R
library(data.table) ; Prd.Dtb <- data.table(Prd.Ras@data)
Dat.Ldt <- Prd.Dtb[, .(LIBCOM= LIBCOM[ 1], NOM= NAME[ 1],
                       NIVEAU= NIVEAU[ 1],
                       SURFACE_ha= round(sum(AREA)/ 1e5, 2),
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

Sans trop de surprise, les Grands Crus arrivent en haut de la hiérarchie autant issus de la côte de Nuits (Chambertin, Grands-Echezeaux) que de la côte de Beaune (Montrachet, Bâtard-Montrachet). Notons tout de même qu'un Premier cru arrive en dixième position, ce qu'il veut dire qu'il dépasse les 2/3 des Grands crus. Ce Premier cru "La Combe d'Orveau" se trouve sur la commune de Chambolle Musigny qui n'apparaît pas pourtant si désavantagée selon la Figure 2. Cela indique que la haute classification de ce Premier cru (en particulier au-dessus du Grand cru "Musigny" situé sur la même commune) provient des caractéristiques biophysiques et non de la correction communale. Plus étonnant, la Romanée-conti qui apparaît souvent parmi les vins les plus chers du monde (<https://www.wine-searcher.com/most-expensive-wines>) n'apparaît qu'en 26ième position (elle est tout de même dans les 2 % meilleurs). On peut penser que la situation de monopole peut expliquer la fort prix indépendamment des caractéristiques biophysiques.

Nous enregistrons ensuite les résultats dans une base de données géographique de type `sf` qui pourra directement être utilisée dans l'application *Shiny*. Ces résultats sont accessibles sur le serveur data de l'INRA à l'adresse XX.

```R
library(sf)
Poly.Ras <- st_as_sf(Poly.Ras)
Poly.Ras <- st_transform(Poly.Ras,crs= 4326)
save(Poly.Ras, file= "Inter/PolyRas.Rda")
```

Sauvegarde disponible sur le serveur de l'INRA.


<a id="Sec:4"></a>

# Application *Shiny*

Les résultats issus de la modélisation statistiques des AOC de Côte-d'Or sont consultables par le biais d'une application *Shiny* dédiée. Il y a deux manière de faire tourner l'application, par le biais d'un explorateur internet à l'adresse <https://cesaer-datas.inra.fr/geoind/> ou en local sur la base d'une version récente de `R` et des packages spécifiés ci-dessous.


<a id="org2d5e137"></a>

## Cartographie dynamique

Pour faire tourner l'application en local, il est nécessaire de télécharger le fichier `PolyRas.Rda` sur le serveur data de l'INRA pour le placer dans le dossier `Inter/` à la racine de `R` (obtenue avec `getwd()`). Les codes ci-dessous permettent de créer la cartographie dynamique de type `Leaflet` qui sera intégrée ensuite à l'application. Elle permet de naviguer entre les différentes parcelles viticoles de la zone, pour faire apparaître le score ou le score corrigé suite à un simple clic. La position de la parcelle sélectionnée dans la hiérarchie générale de la région apparaît également par les variables `rang_brut` et `rang_cor` crées précédemment.

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


<a id="org040e58c"></a>

## Lancer l'application localement

Une fois la cartographie dynamique effectuée, l'application *Shiny* peut être déployée localement, suite au chargement des packages associés. L'intégralité du code de l'application est reporté en Annexe 4 et 5, qui produises les fichiers `ui.R` et `server.R` qui sont également disponibles sur [github](https://github.com/jsay/geoInd/tree/master/Application).

```R
library(shiny) ; library(shinydashboard) ; library(shinyjs)
library(leaflet) ; library(maptools) ; library(ggplot2)
Pts.Crd <- st_centroid(Poly.Ras)

source("ui.R") ; source("server.R")
shinyApp(ui,server)
```


<a id="orge8c52f8"></a>

## Manuel d'utilisation

L'application est structurée en 3 parties, avec en haut à gauche des zones de saisie pour renseigner directement une localité (à partir des informations disponibles sur les étiquettes d'un vin ou à partir de ses connaissances personnelles); en bas à gauche un graphique qui positionne la qualité de la localité sélectionnée dans la distribution générale des qualité (où les niveaux d'appellation sont différentiés); et à droite la cartographie dynamique qui permet de faire apparaître la localité sélectionnée, amis permet aussi de se déplacer librement sur la zone d'étude. Les fonctions de la cartographie dynamique sont maintenues, ainsi un clic sur une zone permet de faire apparaître ses caractéristiques, et les prévisions du modèle en particulier.

Prenons l'exemple d'un vin d'un niveau Premier cru, sur la commune de Flagey-Echezeaux, qui a pour lieu dit (dénomination en l'occurrence) Les Rouges. Suite à la saisie de ces caractéristiques dans les zones dédiées, le score corrigé prédit pour ce vin égal à 83.82 apparaît dans le graphique en bas à gauche de l'application, et nous observons que ce score est supérieur à l'ensemble des Coteaux bourguignons, des Bourgognes régionaux et des villages de la zone. Ce Premier cru est parmi les 10% de Premiers crus qui ont les plus hauts scores et il dépasse même 30% des Grands crus de la zone. La partie à droite de l'application a zoomé sur cette zone, un clic sur le lieu dit en question permet de faire apparaître la différence entre les prédictions brutes et corrigées. Ainsi, le score non corrigé de la localité est sensiblement plus bas (80.92), ce qui implique que suite à la correction des effets communaux, le vin passe du top 7% au top 3% sur l'ensemble de la zone étudiée. Ce résultat est consistant avec les effets communaux reportés dans la Figure 5, où la commune de Flagey-Echezeaux apparaît comme relativement défavorisée dans la hiérarchie. Nous pouvons également que ce Premier est mitoyen du Grand cru Echezeaux qui se trouve tout juste à l'Est.


<a id="Sec:5"></a>

# Conclusion

Le chiffres d’affaire des signes de qualité c’est 32 milliards d’euros et le budget de l’INAO 32 millions d’euros, c’est un millième du chiffre d’affaires.

Information pour les consommateurs.

Développements à venir.


<a id="orge96c4e6"></a>

## Remerciements

Nous tenons à remercier Pauline, Vincent, Guillaume.

```R
sessionInfo()
```

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


<a id="Sec:6"></a>

# Bibliographie

# Bibliography <a id="Garc11"></a>[Garc11] Garcia, Les \emphclimats du vignoble de Bourgogne comme patrimoine mondial de l'humanit\'e, Ed. Universitaires de Dijon (2011). [↩](#121170804c03a6ffd9b6598b03e5ae59) <a id="WJac11"></a>[WJac11] Wolikow & Jacquet, Territoires et terroirs du vin du XVIIIe au XXIe siècles, Éditions Universitaires de Dijon (2011). [↩](#7e3cc4e952baf2ace29bc97117ad514c) <a id="Capu47"></a>[Capu47] Capus, L'\'Evolution de la l\'egislation sur les appellations d'origine. Gen\`ese des appellations contr\^ol\'ees, L. Larmat (1947). [↩](#95abb746101aa32ae2b154f5bdee7ad0) <a id="Humb11"></a>[Humb11] @phdthesisHumb11, title=L'INAO, de ses origines \`a la fin des ann\'ees 1960: gen\`ese et \'evolutions du syst\`eme des vins d'AOC, author=Humbert, Florian, year=2011, school=Universit\'e de Bourgogne [↩](#36d1387edd76d672ddb30e2817a44c44) <a id="CMar04"></a>[CMar04] Coestier & Marette, Economie de la qualit\'e, La d\'ecouverte (2004). [↩](#90e8d3da1815242f3136e232bea3b79b) <a id="Ay19"></a>[Ay19] Ay, The informational content of geographical indications, <i>AAWE Working Paper n XXX</i>, (2019). [↩](#d5f551e637b0632950381ff3346c5e2e) <a id="WPSa16"></a>[WPSa16] Wood, Pya & S\"afken, Smoothing parameter and model selection for general smooth models, <i>Journal of the American Statistical Association</i>, <b>111(516)</b>, 1548-1563 (2016). [↩](#288ff4c397fcb33b93de861cedf4c4e5) <a id="Jacq09"></a>[Jacq09] Jacquet, Un si\`ecle de construction du vignoble bourguignon. Les organisations vitivinicoles de 1884 aux AOC, Editions Universitaires de Dijon (2009). [↩](#aabd8d871d4bfd7dce750e0ec786fb3d) <a id="AKat17"></a>[AKat17] Agresti & Kateri, Ordinal probability effect measures for group comparisons in multinomial cumulative link models, <i>Biometrics</i>, <b>73(1)</b>, 214-219 (2017). [↩](#ba4181a0e7dae7fbb217e69ee0b575b4) <a id="Dion52"></a>[Dion52] Dion, Querelle des anciens et des modernes sur les facteurs de la qualit\'e du vin, <i>Annales de g\'eographie</i>, <b>61(328)</b>, 417-431 (1952). [↩](#179cacf6073e0a5bd2c08b8f57141208) <a id="DChe15"></a>[DChe15] Delay & Chevallier, Roger Dion, toujours vivant!, <i>Cybergeo: European Journal of Geography</i>, (2015). [↩](#295ae69c19e4b3eca519fcac1e12d462) <a id="Ay11"></a>[Ay11] @phdthesisAy11, TITLE = Hétérogénéité de la terre et rareté économique, AUTHOR = Ay, Jean-Sauveur, URL = https://tel.archives-ouvertes.fr/tel-00629142, SCHOOL = Universit\'e de Bourgogne, YEAR = 2011, MONTH = Jul, TYPE = Theses, PDF = https://tel.archives-ouvertes.fr/tel-00629142/file/THESE.pdf, HAL_ID = tel-00629142, HAL_VERSION = v1, [↩](#208d1d7a07cf6fffe3fa96d1717b7a1f) <a id="Wood17"></a>[Wood17] Wood, Generalized additive models: An introduction with R, Chapman and Hall/CRC, second edition (2017). [↩](#7428cca95c8f1a0339bd46afd86d6e00)


<a id="Sec:A"></a>

# Annexes

**Annexe 1 : Construction des données**

Cette annexe reporte les codes `R` utilisés pour constituer la base de données principale associée à l'article. Les références des données sources sont mentionnées dans le corps de l'article.

1.  *Données parcellaires*

    Le résultat de ces traitements se trouve dans le fichier `/Carto/GeoCad.shp` (disponible auprès des auteurs sur demande) utilisé dans le code suivant :
    
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

2.  *Données raster*

    Le fichier `Data/DatRas` appariés aux données du cadastre peut être obtenu auprès des auteurs.
    
    ```R
    library(data.table)
    dim(Dat.Ras <- fread("./Data/DatRas.csv"))
    Cad.Ras <- Dat.Ras[, lapply(.SD, mean), 
                       by= list(PAR2RAS),.SDcols= names(Dat.Ras)[-c(1, 4, 13)]]
    Geo.Ras <- merge(Geo.Cad, Cad.Ras, by= "PAR2RAS")
    sapply(Geo.Ras@data[, 17: 26], function(x) sum(is.na(x))); rm(Dat.Ras)
    ```
    
        [1] 14253070       13
          XL93   YL93  NOMOS  URBAN FOREST  WATER    DEM  SLOPE ASPECT  SOLAR 
          2096   2096   2096   2096   2096   2096   2096   2096   2096   2096

3.  *Données géologiques (polygone)*

    Nous apparions les \(13\,960\) polygones géologiques présent dans `/Carto/GeolMap` (disponible sur demande) sur la base du centroïde des parcelles cadastrales, comme présenté dans le code suivant.
    
    ```R
    Geol.Map <- readOGR("./Carto/", "GeolMap")
    Pts.Cad <- SpatialPoints(Geo.Ras, proj4string= CRS(proj4string(Geol.Map)))
    Geo.Ras@data <- cbind(Geo.Ras@data, over(Pts.Cad, Geol.Map))
    sapply(Geo.Ras@data[, 27: 42], function(x) sum(is.na(x)))
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

4.  *Données pédologiques (polygone)*

    ```R
    Pedo.Map <- readOGR("./Carto", "PedoMap")
    Geo.Ras@data <- cbind(Geo.Ras@data, over(Pts.Cad, Pedo.Map))
    Geo.Ras@data[, c(44: 47, 49: 54)] <-
        apply(Geo.Ras@data[, c(44: 47, 49: 54)], 2, as.numeric)
    sapply(Geo.Ras@data[, 43: 55], function(x) sum(is.na(x)))
    ```
    
        OGR data source with driver: ESRI Shapefile 
        Source: "/home/jsay/geoInd/Carto", layer: "PedoMap"
        with 194 features
        It has 13 fields
        
          NOUC SURFUC   TARG   TSAB   TLIM TEXTAG  EPAIS    TEG    TMO    RUE 
         14645  14645  14645  14645  14645  14645  14645  14645  14645  14645 
           RUD  OCCUP DESCRp 
         14645  14645  14645

5.  *Données AOC historiques (polygones)*

    ```R
    Hist.Aoc <- readOGR("Carto/", "Aoc1936")
    Geo.Ras@data <- cbind(Geo.Ras@data, over(Pts.Cad, Hist.Aoc))
    sapply(Geo.Ras@data[, 56: 57], function(x) sum(is.na(x)))
    ```
    
        OGR data source with driver: ESRI Shapefile 
        Source: "/home/jsay/geoInd/Carto", layer: "Aoc1936"
        with 56 features
        It has 2 fields
        AOC36lab AOC36lvl 
              70       70

6.  *Données Lieux dits (polygones)*

    ```R
    Lieu.Dit <- readOGR("./Carto/", "LieuDit")
    Geo.Ras@data <- cbind(Geo.Ras@data, over(Pts.Cad, Lieu.Dit[, -1]))
    sapply(Geo.Ras@data[, 58: 67], function(x) sum(is.na(x)))
    ```
    
        OGR data source with driver: ESRI Shapefile 
        Source: "/home/jsay/geoInd/Carto", layer: "LieuDit"
        with 3285 features
        It has 11 fields
         LIEUDIT   CLDVIN   LIBCOM     XCHF     YCHF   ALTCOM   SUPCOM 
            4494     4494     4494     4494     4494     4494     4494 
          POPCOM CODECANT   REGION 
            4494     4494     4494

7.  *Enregistrement de la base*

    ```R
    dim(Geo.Ras)
    save(Geo.Ras, file= "Inter/GeoRas.Rda")
    writeOGR(Geo.Ras, "Carto/", "GeoRas", driver= "ESRI Shapefile")
    ```
    
        [1] 110350     67
    
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
