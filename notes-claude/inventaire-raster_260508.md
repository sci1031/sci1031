# Inventaire des usages du package `raster`

Projet : sci1031  
Date : 2026-05-08

---

## Fichiers concernés

| Fichier | Ligne(s) `library(raster)` | Statut |
|---|---|---|
| `Module4/index.Rmd` | L.87 | **commenté** (`#library(raster)`) |
| `Module5/index.Rmd` | L.128 (leçon), L.962 (exercices) | actif |
| `Module6/index.Rmd` | L.893 (cartographie tmap), L.1569 (élévation) | actif |
| `Module8/index.Rmd` | L.124 | actif |
| `Module9/index.Rmd` | L.769 + L.778 (bloc `R` brut et commentaire), L.893 (bloc commenté), L.908 | partiellement actif |

---

## Fonctions utilisées par module

### Module 5 — Introduction aux données matricielles

| Fonction | Usage |
|---|---|
| `raster()` | Créer un raster depuis zéro ou lire un `.tif` |
| `brick()` | Lire un raster multibande (retourne `RasterBrick`) |
| `stack()` | Combiner des couches en `RasterStack` |
| `dim()`, `ncell()`, `nrow()`, `ncol()` | Dimensions du raster |
| `res()`, `extent()`, `crs()` | Résolution, étendue, SCR |
| `values()` | Assigner des valeurs aux pixels |
| `getValues()` | Extraire les valeurs sous forme de vecteur |
| `maxValue()`, `minValue()` | Min/max d'un raster |
| `cellStats()` | Statistiques par couche (mean, sd, sum, range, etc.) |
| `aggregate()` | Diminuer la résolution (agréger les cellules) |
| `projectRaster()` | Reprojeter dans un autre SCR |
| `crop()` | Rogner selon une sous-étendue |
| `writeRaster()` | Sauvegarder un raster en fichier |

### Module 6 — Cartographie avec tmap

| Fonction | Usage |
|---|---|
| `raster()` | Lire le raster d'élévation du Québec (`QC_Elevation.tif`) |
| `library(raster)` | Chargé pour permettre `tm_raster()` de tmap de fonctionner |

### Module 8 — Manipulation de données matricielles

| Fonction | Usage |
|---|---|
| `raster()` | Lire `DEM.tif` et `megantic_elevation.grd` |
| `getValues()` | Extraire valeurs pour filtrage avec `which()` |
| `reclassify()` | Reclassifier les valeurs en nouvelles catégories |
| `extent()` | Créer un objet `Extent` pour `crop()` |
| `crop()` | Rogner le DEM selon une étendue ou un polygone |
| `mask()` | Découper selon un polygone quelconque |
| `raster::extract()` | Extraire valeurs sous un polygone (appelé avec `::` pour éviter conflit) |
| `projectRaster()` | Reprojeter le DEM dans le SCR des données vectorielles |
| `merge()` | Combiner deux rasters (même SCR/résolution) |
| `mosaic()` | Combiner deux rasters avec choix de la valeur aux pixels chevauchants |
| `extract()` | Extraire les valeurs des cellules le long d'un sentier (`along=TRUE`) |
| `xyFromCell()` | Retrouver les coordonnées spatiales à partir d'indices de cellules |

### Module 9 — Données spatiotemporelles

| Fonction | Usage |
|---|---|
| `library(raster)` + `osm.raster()` | Usage avec `rosm` pour carte de fond (bloc R brut, partiellement commenté) |
| `stack()` | Importer des fichiers NetCDF (`.nc`) multitemporels |
| `extent()`, `projection()`, `ncell()`, `dim()`, `nlayers()` | Propriétés d'un `RasterStack` |
| `getValues()` | Extraire valeurs sous forme matricielle |
| `calc()` | Appliquer une fonction sur toutes les couches d'un stack |
| `projectRaster()` | Reprojeter un `RasterStack` |
| `crop()` | Rogner un `RasterStack` |
| `mask()` | Masquer un `RasterStack` avec un polygone |
| `extract()` | Extraire valeurs d'un `RasterStack` pour un polygone |
| `xyFromCell()` | Obtenir les coordonnées spatiales à partir d'indices |

---

## Remarques importantes

- **`raster::extract()` vs `extract()`** : dans `Module8/index.Rmd:414`, l'appel est qualifié `raster::extract()` pour éviter un conflit de noms (probablement avec `tidyr::extract` ou `terra::extract`).
- **Module 9, L.769** : le `library(raster)` est dans un bloc de code R brut (délimiteur ` ```R ` sans accolade) et est donc affiché comme texte mais non exécuté.
- **Classes raster utilisées** : `RasterLayer`, `RasterBrick`, `RasterStack` — les trois classes principales du package.
- Le package `raster` est au cœur des **Modules 5, 8 et 9**, et accessoire dans les **Modules 6** (pour tmap) et **9** (pour rosm).
