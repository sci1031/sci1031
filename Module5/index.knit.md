# Données matricielles {#mat}


Cette leçon est une introduction aux données spatiales matricielles sous `R`. Son objectif principal est d'apprendre à lire, interpréter et visualiser des données matricielles^[ Un bon accompagnement à ce module est la section [2.3 Raster data](https://bookdown.org/robinlovelace/geocompr/spatial-class.html#raster-data) du livre *Geocomputation with R* des auteurs Robin Lovelace, Jakub Nowosad, et Jannes Muenchow [@lovelace_geocomputation_2019].].


À la fin de ce module vous saurez:

- Créer et lire un *raster*.
- Interpréter la géométrie d'un *raster*.
- Comprendre la structure d'un *raster*.
- Obtenir des statistiques simples sur les données contenues dans un *raster*.
- Visualiser un *raster*.
- Transformer le système de coordonnées de référence d'un *raster*.
- Transformer la résolution d'un *raster*
- Lire et visualiser un *raster* multi-bande.

Vous utiliserez les librairies suivantes:

- `raster`
- `mapview`
- `leafsync`

Vous apprendrez à utiliser les fonctions suivantes:

- `raster()`
- `getValues()`
- `maxValue()`
- `cellStats()`
- `ncell()`
- `res()`
- `extent()`
- `crs()`
- `aggregate()`
- `projectRaster()`
- `writeRaster()`
- `brick()`
- `stack()`
- `viewRGB()`
- `mapview()` et `latticeView()`, que vous connaissez déjà


Vous utiliserez aussi les fonctions suivantes, qui ne sont pas spécifiques aux données spatiales:

- `dim()`
- `class()` 
- `levels()`
- `factor()`
- `plot()`, `hist()`, `boxplot()`
- `as.data.frame()`
- `head()`
- `max()`, `min()`, `median()`, `median()`
- `summary()`
- `names()`

Dans la section [leçon](#lecon_mat), vous utiliserez deux ensembles de données matricielles. 

Le premier ensemble contient des données spatiales relatives aux ilôts de chaleur urbain dans la région de la ville de Québec.

Le second ensemble contient des données spatiales satellites captées par Landsat près de la ville de La Tuque en Mauricie.


Dans la section [exercice](#ex_mat), vous utiliserez XXXXX


## Leçon {#lecon_mat}

Les données matricielles représentent la surface terrestre par une grille régulière, communément appelé un *raster*. Dans cette leçon, nous utiliserons les expressions «*raster*» et «données matricielles» de façon interchangeable.

Commençons cette leçon en chargeant la librairie `raster` dans notre session de travail `R`.

```r
# Installez la librairie si ce n'est pas déjà fait
# install.packages("raster")
# Chargez la librairie
library(raster)
```

```
## Loading required package: sp
```


### Créer un *raster* et comprendre sa structure

Au [module 2](#base), nous avons expliqué qu'un *raster* est formé de rectangles de même forme et de même dimension appelés cellules ou pixels. À chaque cellule de cette matrice correspond une valeur numérique (ou une valeur manquante) associée à un attribut d’intérêt. On appelle couche (« layer » en anglais) l’information recueillie dans la matrice.

#### Créer un *raster* simple et le visualiser {-}

La fonction `raster()` de la librairie `raster` permet de créer un *raster*. Par exemple:

```r
M <- raster(nrows=8, ncols=8, xmn = 0, xmx = 4, ymn = 0, ymx = 4, vals = 1:64)
```

Où `nrows` et `ncols` correspondent respectivement au nombre de lignes et au nombre de colonnes du *raster* `M`, `xmn` et `xmx` correspondent respectivement aux coordonnées-x minimale et maximale du *raster*, `ymn` et `ymx` aux coordonnées-y minimale et maximale, et `vals` est un vecteur comprenant la valeur de chaque pixel du *raster*. Dans le cas présent, le *raster* `M` contient 64 pixels. Le premier pixel a la valeur 1, le deuxième pixel a la valeur 2 et ainsi de suite.

Voyons les informations données, lorsque nous appelons le *raster* `M` que nous venons de créer:

```r
M
```

```
## class      : RasterLayer 
## dimensions : 8, 8, 64  (nrow, ncol, ncell)
## resolution : 0.5, 0.5  (x, y)
## extent     : 0, 4, 0, 4  (xmin, xmax, ymin, ymax)
## crs        : +proj=longlat +datum=WGS84 +no_defs 
## source     : memory
## names      : layer 
## values     : 1, 64  (min, max)
```
Nous remarquons que des informations additionnelles apparaissent: `ncell` correspond au nombre de cellules (ou de pixels) dans le *raster*, `resolution` correspond à la résolution des pixels, `extent` correspond à l'étendue du *raster* définie par ses coordonnées maximimales et minimales, et `crs` correspond aux paramètres du système de coordonnées de référence utilisé.

Si le SCR d'un *raster* n'est pas défini au moment de sa création, comme dans le cas présent, alors le SCR WGS84 sera attribué par défaut.

Remarquez que la classe (`class`) de l'objet `M` est défini comme étant un `RasterLayer`. Nous verrons dans la dernière section de cette leçon qu'il existe d'autres classes de *raster*, soit les `RasterBrick` et les `RasterStack`.

Remarquez aussi que la résolution d'un pixel est de `0.5 x 0.5`, car les 64 pixels du raster occupent le carré d'aire 16 délimité par les quatres points (0,0), (0,4), (4,0) et (4,4).

Ainsi, une façon équivalente de créer le *raster* `M` est:

```r
M <- raster(res = 0.5, xmn = 0, xmx = 4, ymn = 0, ymx = 4, vals = 1:64)
M
```

```
## class      : RasterLayer 
## dimensions : 8, 8, 64  (nrow, ncol, ncell)
## resolution : 0.5, 0.5  (x, y)
## extent     : 0, 4, 0, 4  (xmin, xmax, ymin, ymax)
## crs        : +proj=longlat +datum=WGS84 +no_defs 
## source     : memory
## names      : layer 
## values     : 1, 64  (min, max)
```
Dans cette notation, nous avons spécifié la résolution et non la dimension du *raster*.

Nous pouvons également connaître les paramètres d'un *raster* en utilisant les fonctions correspondantes.

```r
dim(M)
## [1] 8 8 1

ncell(M)
## [1] 64

nrow(M)
## [1] 8

ncol(M)
## [1] 8

res(M)
## [1] 0.5 0.5

extent(M)
## class      : Extent 
## xmin       : 0 
## xmax       : 4 
## ymin       : 0 
## ymax       : 4

crs(M)
## CRS arguments: +proj=longlat +datum=WGS84 +no_defs
```
<br>

Il existe plusieurs fonctions permettant de visualiser les *rasters*.
Nous pouvons simplement utiliser la fonction `plot()`.

```r
plot(M)
```

<div class="figure">
<img src="index_files/figure-html/unnamed-chunk-6-1.png" alt="Visualisation du raster `M` avec la fonction `plot()`" width="480" />
<p class="caption">Visualisation du raster `M` avec la fonction `plot()`</p>
</div>
<br>

Nous pouvons aussi utiliser la fonction `mapview()` de la librarie `mapview`:

```r
library(mapview)
library(leaflet)
mapview(M)
```



```r
#library(tmap)
#tm_shape(M)+tm_raster(n=ncell(M),legend.show = FALSE)
```


<div class="figure">
<!--html_preserve--><div id="htmlwidget-5afd2297134a11fb803e" style="width:480px;height:480px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-5afd2297134a11fb803e">{"x":{"options":{"minZoom":1,"maxZoom":52,"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}},"preferCanvas":false,"bounceAtZoomLimits":false,"maxBounds":[[[-90,-370]],[[90,370]]]},"calls":[{"method":"addProviderTiles","args":["CartoDB.Positron","CartoDB.Positron","CartoDB.Positron",{"errorTileUrl":"","noWrap":false,"detectRetina":false,"pane":"tilePane"}]},{"method":"addProviderTiles","args":["CartoDB.DarkMatter","CartoDB.DarkMatter","CartoDB.DarkMatter",{"errorTileUrl":"","noWrap":false,"detectRetina":false,"pane":"tilePane"}]},{"method":"addProviderTiles","args":["OpenStreetMap","OpenStreetMap","OpenStreetMap",{"errorTileUrl":"","noWrap":false,"detectRetina":false,"pane":"tilePane"}]},{"method":"addProviderTiles","args":["Esri.WorldImagery","Esri.WorldImagery","Esri.WorldImagery",{"errorTileUrl":"","noWrap":false,"detectRetina":false,"pane":"tilePane"}]},{"method":"addProviderTiles","args":["OpenTopoMap","OpenTopoMap","OpenTopoMap",{"errorTileUrl":"","noWrap":false,"detectRetina":false,"pane":"tilePane"}]},{"method":"addRasterImage","args":["data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAYAAADED76LAAAApklEQVQYlS3JQUoDYRAF4erp97ozRnDlIghushARCbn/NTyApxCcmczvwqzqg4rnp8/hKBSiwoikwxTGJPrQGSN6CDNRiN4Tk/RIdLmdaKb7nHBMdAQ1BY5Al8MjnqASlFAalEA5KN/Q+8uCvSPt2Nu9K6qV1IrOb9+kflH9ELUQh4XoFWojekPH6xfRAwx0Ei2woI6EjfL6Ci6omaj53z0TaugH/gC1Vh3kWT4IpAAAAABJRU5ErkJggg==",[[4,0],[-3.26805196571339e-16,4]],0.8,null,"M","M"]},{"method":"removeLayersControl","args":[]},{"method":"addLayersControl","args":[["CartoDB.Positron","CartoDB.DarkMatter","OpenStreetMap","Esri.WorldImagery","OpenTopoMap"],"M",{"collapsed":true,"autoZIndex":true,"position":"topleft"}]},{"method":"addControl","args":["","topright","imageValues-M","info legend "]},{"method":"addImageQuery","args":["M",[0,-3.26805196571339e-16,4,4],"mousemove",7,"Layer"]},{"method":"addLegend","args":[{"colors":["#040404 , #341348 14.2944797887259%, #77106C 30.1668249063182%, #B72674 46.0391700239105%, #EA5A4F 61.9115151415027%, #F7A026 77.783860259095%, #FAE276 93.6562053766873%, #FFFE9E "],"labels":["10","20","30","40","50","60"],"na_color":null,"na_label":"NA","opacity":1,"position":"topright","type":"numeric","title":"M","extra":{"p_1":0.142944797887259,"p_n":0.936562053766873},"layerId":null,"className":"info legend","group":"M"}]},{"method":"addScaleBar","args":[{"maxWidth":100,"metric":true,"imperial":true,"updateWhenIdle":true,"position":"bottomleft"}]},{"method":"addHomeButton","args":[0,-3.26805196571339e-16,4,4,"M","Zoom to M","<strong> M <\/strong>","bottomright"]}],"limits":{"lat":[-3.26805196571339e-16,4],"lng":[0,4]}},"evals":[],"jsHooks":{"render":[{"code":"function(el, x, data) {\n  return (\n      function(el, x, data) {\n      // get the leaflet map\n      var map = this; //HTMLWidgets.find('#' + el.id);\n      // we need a new div element because we have to handle\n      // the mouseover output separately\n      // debugger;\n      function addElement () {\n      // generate new div Element\n      var newDiv = $(document.createElement('div'));\n      // append at end of leaflet htmlwidget container\n      $(el).append(newDiv);\n      //provide ID and style\n      newDiv.addClass('lnlt');\n      newDiv.css({\n      'position': 'relative',\n      'bottomleft':  '0px',\n      'background-color': 'rgba(255, 255, 255, 0.7)',\n      'box-shadow': '0 0 2px #bbb',\n      'background-clip': 'padding-box',\n      'margin': '0',\n      'padding-left': '5px',\n      'color': '#333',\n      'font': '9px/1.5 \"Helvetica Neue\", Arial, Helvetica, sans-serif',\n      'z-index': '700',\n      });\n      return newDiv;\n      }\n\n\n      // check for already existing lnlt class to not duplicate\n      var lnlt = $(el).find('.lnlt');\n\n      if(!lnlt.length) {\n      lnlt = addElement();\n\n      // grab the special div we generated in the beginning\n      // and put the mousmove output there\n\n      map.on('mousemove', function (e) {\n      if (e.originalEvent.ctrlKey) {\n      if (document.querySelector('.lnlt') === null) lnlt = addElement();\n      lnlt.text(\n                           ' lon: ' + (e.latlng.lng).toFixed(5) +\n                           ' | lat: ' + (e.latlng.lat).toFixed(5) +\n                           ' | zoom: ' + map.getZoom() +\n                           ' | x: ' + L.CRS.EPSG3857.project(e.latlng).x.toFixed(0) +\n                           ' | y: ' + L.CRS.EPSG3857.project(e.latlng).y.toFixed(0) +\n                           ' | epsg: 3857 ' +\n                           ' | proj4: +proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs ');\n      } else {\n      if (document.querySelector('.lnlt') === null) lnlt = addElement();\n      lnlt.text(\n                      ' lon: ' + (e.latlng.lng).toFixed(5) +\n                      ' | lat: ' + (e.latlng.lat).toFixed(5) +\n                      ' | zoom: ' + map.getZoom() + ' ');\n      }\n      });\n\n      // remove the lnlt div when mouse leaves map\n      map.on('mouseout', function (e) {\n      var strip = document.querySelector('.lnlt');\n      if( strip !==null) strip.remove();\n      });\n\n      };\n\n      //$(el).keypress(67, function(e) {\n      map.on('preclick', function(e) {\n      if (e.originalEvent.ctrlKey) {\n      if (document.querySelector('.lnlt') === null) lnlt = addElement();\n      lnlt.text(\n                      ' lon: ' + (e.latlng.lng).toFixed(5) +\n                      ' | lat: ' + (e.latlng.lat).toFixed(5) +\n                      ' | zoom: ' + map.getZoom() + ' ');\n      var txt = document.querySelector('.lnlt').textContent;\n      console.log(txt);\n      //txt.innerText.focus();\n      //txt.select();\n      setClipboardText('\"' + txt + '\"');\n      }\n      });\n\n      }\n      ).call(this.getMap(), el, x, data);\n}","data":null},{"code":"function(el, x, data) {\n  return (function(el,x,data){\n           var map = this;\n\n           map.on('keypress', function(e) {\n               console.log(e.originalEvent.code);\n               var key = e.originalEvent.code;\n               if (key === 'KeyE') {\n                   var bb = this.getBounds();\n                   var txt = JSON.stringify(bb);\n                   console.log(txt);\n\n                   setClipboardText('\\'' + txt + '\\'');\n               }\n           })\n        }).call(this.getMap(), el, x, data);\n}","data":null}]}}</script><!--/html_preserve-->
<p class="caption">Visualisation du raster `M` avec la fonction `mapview()`</p>
</div>
<br>

Nous avons une certaine preference pour l'esthétique qu'offre `mapview()`, n'est-ce pas?
Peu importe la fonction choisie, celle-ci transforme la valeur de chaque cellule en couleur. Différentes pallettes de couleur peuvent etre utilisées, mais pour l'instant, limitons-nous à la palette de couleur par défaut, qui est `inferno` de la librarie `viridis`, inclue automatiquement dans la librarie `mapview`.

Remarquez que le premier pixel, qui porte la valeur 1 dans le cas présent, se trouve en haut à gauche. Le dernier pixel, quant à lui, se trouve dans le coin inférieur droit. L'identité des pixels suit donc les lignes d'un *raster*.


#### *Raster* de différents types de données {-}

Les *rasters* peuvent prendre des valeurs de type discrètes (`integer`) et des nombres réelles (`numeric`).
Ils peuvent également prendre des valeurs logiques (`logical`). Par exemple, remplaçons les valeurs discrètes du *raster* `M` défini plus haut par des valeurs logiques.



```r
z <- 1:64
class(z) #la fonction class() renvoie le type de données de l'objet z
```

```
## [1] "integer"
```

```r
# Créons un nombre logique qui est vrai lorsque z est un multiple de trois, et faux autrement
z_mult3 <- z %% 3 == 0

# La fonction modulo, s'exprime par le symbole %%,
# L'expression x %% y vaut 0 si y est un multiple de x,
# L'expression x %% y vaut r si y n'est pas un multiple de x.
# r correspond alors au reste de la division x/y
z_mult3
```

```
##  [1] FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE
## [13] FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE
## [25] FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE
## [37] FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE
## [49] FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE
## [61] FALSE FALSE  TRUE FALSE
```

```r
class(z_mult3) #vérifions que les valeurs sont bien de type logique
```

```
## [1] "logical"
```

```r
# utilisons le vecteur logique z_mult3 pour créer un raster logique
M_logique <- raster(nrows = 8, ncols = 8, xmn = 0, xmx = 4, ymn = 0, ymx = 4,
    vals = z_mult3)

M_logique
```

```
## class      : RasterLayer 
## dimensions : 8, 8, 64  (nrow, ncol, ncell)
## resolution : 0.5, 0.5  (x, y)
## extent     : 0, 4, 0, 4  (xmin, xmax, ymin, ymax)
## crs        : +proj=longlat +datum=WGS84 +no_defs 
## source     : memory
## names      : layer 
## values     : 0, 1  (min, max)
```


Visualisons maintenant ce *raster* de type logique:

















































































































