# Module 5 — Changements raster → terra

Date : 2026-05-08

---

## Remplacements directs dans le code

| `raster` | `terra` |
|---|---|
| `library(raster)` | `library(terra)` |
| `raster(...)` | `rast(...)` |
| `brick(...)` | `rast(...)` |
| `stack(r1, r2)` | `c(r1, r2)` |
| `extent(...)` | `ext(...)` |
| `getValues(r)` | `values(r)` |
| `projectRaster(r, crs=...)` | `project(r, ...)` |
| `maxValue(r)` | `global(r, "max")$max` |
| `minValue(r)` | `global(r, "min")$min` |
| `cellStats(r, fun)` | `global(r, "fun")` |
| `raster(file, band=1)` | `rast(file, lyrs=1)` |

## Changements dans le texte

- `RasterLayer`, `RasterBrick`, `RasterStack` → `SpatRaster` (terra n'a qu'une seule classe)
- La section sur `RasterBrick` vs `RasterStack` doit être réécrite pour refléter que terra utilise `SpatRaster` pour toutes les configurations (mono et multibande)

## Cas non triviaux

- **`summary(T_vdq, maxsamp=ncell(T_vdq))`** — terra ne fait pas d'échantillonnage dans `summary()`, tout le passage sur `maxsamp` devient obsolète et doit être supprimé ou réécrit.
- **`ratify(R2001f, count=TRUE)`** (Question 5 des exercices) — cette fonction n'existe pas dans terra; l'équivalent est `freq(R2001f)` qui retourne un data.frame avec les colonnes `layer`, `value`, `count`.
- **`cellStats(G, median)`** et **`cellStats(G, quantile)`** — `global()` ne supporte pas `median` ni `quantile`; remplacer par `median(values(G), na.rm=TRUE)` et `quantile(values(G), na.rm=TRUE)`.

## Autres packages dans le module

Aucun package expiré autre que `raster`. Les packages suivants sont conservés tels quels :
`mapview`, `leaflet`, `leafsync`, `sf`, `FedData`
