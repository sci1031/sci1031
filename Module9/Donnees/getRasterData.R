library(raster)
# mean maximum 
mmx <- stack(paste0("CC_3876086_1-116/CC_3876086_", 107:116, ".nc"))
ext <- extent(c(-72, -71, 45, 46)) 
# plot(crop(mmx, ext))

writeRaster(crop(mmx, ext), "mmxt.nc")

# tot precipitation mean maximum 


tmp <- stack(paste0("CC_3876087_1-116/CC_3876087_", 107:116, ".nc"))
writeRaster(crop(tmp, ext), "mmnt.nc")

tmp <- stack(paste0("CC_3876088_1-116/CC_3876088_", 107:116, ".nc"))
writeRaster(crop(tmp, ext), "tpcp.nc")

  
# exemple 
library(raster)
tmp <- stack("CC_3876087_1-116/CC_3876087_100.nc")
png("mmint_janv_2000.png", width = 8.4, height = 7, res  = 300, units = "in")
par(mar = c(3, 3, 1 ,1), las = 1)
plot(tmp[[1]])
dev.off()