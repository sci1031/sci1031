# this is to create data I used for mod 9- not meant to be reproducible (but for me).
library(raster)
library(inSilecoDataRetrie)
ra <- raster("/media/kevcaz/hijo92/Data/climateDataNam/60arcsec/2009/bio60_01.tif")
# get raster to easy access the projections 
geom <- raster("~/Projects/books/sci1031/Module8/data/DEM.tif")
geom2 <- projectRaster(geom, crs = projection(ra))  


lf <- list.files("/media/kevcaz/hijo92/Data/climateDataNam/60arcsec", pattern = "pcp60_[0-9]{2}.tif$", full.names = TRUE, recursive = TRUE)
lf <- list.files("/media/kevcaz/hijo92/Data/climateDataNam/60arcsec", pattern = "maxt60_[0-9]{2}.tif$", full.names = TRUE, recursive = TRUE)
lf <- list.files("/media/kevcaz/hijo92/Data/climateDataNam/60arcsec", pattern = "mint60_[0-9]{2}.tif$", full.names = TRUE, recursive = TRUE)

p1 <- gsub(".*([0-9]{4}).*", "\\1", lf)
p2 <- unlist(lapply(strsplit(last_part(lf), "_"), `[`, 2))

ras <- lapply(lf, raster)
 names(ras) <- paste0("mint_", p1, "_", p2)
# names(ras) <- paste0("maxt_", p1, "_", p2)
# names(ras) <- paste0("pcp_", p1, "_", p2)

rasc <- crop(raster::stack(ras), geom2)
names(rasc)
rasf <- projectRaster(rasc, crs = projection(geom))
saveRDS(rasf, "~/Projects/books/sci1031/Module9/data/mint_2009_2019.rds")
saveRDS(rasf, "~/Projects/books/sci1031/Module9/data/maxt_2009_2019.rds")
saveRDS(rasf, "~/Projects/books/sci1031/Module9/data/pcp_2009_2019.rds")

