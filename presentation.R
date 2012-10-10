
## @knitr initialisation
library(rgrs)
library(sp)
library(maptools)


## @knitr shp
library(rgdal)
picardie <- readOGR("./donnees", "picardie")
picardie$STATUT<-as.factor(iconv(picardie$STATUT, from="latin1", to="utf8")) ## traitement de problèmes d'encodage
picardie$codeINSEE <- as.character(picardie$INSEE_COM)


## @knitr shp2
summary(picardie)


## @knitr shp3
require(sp)
plot(picardie)


## @knitr shp4
plot(picardie)


## @knitr data
names(picardie@data)
summary(picardie@data$NOM_DEPT)


## @knitr data2
somme <- picardie[picardie@data$CODE_DEPT == "80",]


## @knitr save
save(picardie, file="./donnees/picardie.Rdata")
load("picardie.Rdata")


## @knitr union
require(gpclib)
gpclibPermit()
require(maptools)
dpts <- unionSpatialPolygons(picardie, IDs=picardie@data$CODE_DEPT)
plot(dpts)


## @knitr load
load("./donnees/mini_picardie.Rdata")
head(mini_picardie$CODE_COMMU)
# Non, donc on recode :
mini_picardie$codeINSEE <- paste(as.character(mini_picardie$CODE_D_PAR), as.character(mini_picardie$CODE_COMMU), sep="")


## @knitr carteprop
somme <- picardie[picardie@data$CODE_DEPT == "80",]
carte.prop(somme, mini_picardie, varname="AbsIns", sp.key="codeINSEE", data.key="codeINSEE", at=quantile(mini_picardie$AbsIns, c(0,.25,.5,.75,1)))


## @knitr carteeff
carte.eff(somme, mini_picardie, varname="Population", sp.key="codeINSEE", data.key="codeINSEE")


## @knitr cartequal

pal <- c("orange", "yellow", "light green", "red")
carte.qual(somme, mini_picardie, varname="type_urbain", sp.key="codeINSEE", data.key="codeINSEE", palette=pal, posleg="bottomleft", main="Le découpage en ZAUER en Picardie", sub="source : INSEE.")


## @knitr fusion
arrdts <- unionSpatialPolygons(somme, IDs=somme@data$CODE_ARR)
carte.qual(somme, mini_picardie, varname="type_urbain", sp.key="codeINSEE", data.key="codeINSEE", palette=pal, posleg="bottomleft", main="Le découpage en ZAUER en Picardie", sub="source : INSEE.")
plot(arrdts, lwd=5, border = "red", add = TRUE)


## @knitr coloration1
library(RColorBrewer)
colors <- brewer.pal(6, "RdBu") 
pal <- colorRampPalette(colors) 
carte.prop(picardie, mini_picardie, "revenu.fiscal.moyen", sp.key="codeINSEE", data.key="codeINSEE", at=as.integer(levels(as.factor(mini_picardie$revenu.fiscal.moyen))), border="transparent", palette=pal(length(levels(as.factor(mini_picardie$revenu.fiscal.moyen)))), posleg="none", main="Le revenu fiscal moyen des ménages par communes")
plot(dpts, add=T)


## @knitr coloration
library(RColorBrewer)
colors <- brewer.pal(6, "RdBu") 
pal <- colorRampPalette(colors) 
carte.prop(picardie, mini_picardie, "revenu.fiscal.moyen", sp.key="codeINSEE", data.key="codeINSEE", at=as.integer(levels(as.factor(mini_picardie$revenu.fiscal.moyen))), border="transparent", palette=pal(length(levels(as.factor(mini_picardie$revenu.fiscal.moyen)))), posleg="none", main="Le revenu fiscal moyen des ménages par communes")
plot(dpts, add=T)


