options(max.print = .Machine$integer.max)
rm(list = ls())

#jar <- paste(system.file(package="dismo"), "/java/maxent.jar", sep='')

#if(!require(dismo)){install.packages("dismo", dependencies=TRUE);library(dismo)}
if (!require(caret)) {
  install.packages("caret", dependencies = TRUE)
  library(caret)
}
#if(!require(rgeos)){install.packages("rgeos", dependencies=TRUE);library(rgeos)}
#if(!require(rgdal)){install.packages("rgdal", dependencies=TRUE);library(rgdal)}
#if(!require(ggmap)){install.packages("ggmap", dependencies=TRUE);library(ggmap)}
#if(!require(stringr)){install.packages("stringr", dependencies=TRUE);library(stringr)}
#if(!require(sp)){install.packages("sp", dependencies=TRUE);library(sp)}
#if(!require(geosphere)){install.packages("geosphere", dependencies=TRUE);library(geosphere)}
#if(!require(pscl)){install.packages("pscl", dependencies=TRUE);library(pscl)}
#if(!require(ROCR)){install.packages("ROCR", dependencies=TRUE);library(ROCR)}
#if(!require(lrgs)){install.packages("lrgs", dependencies=TRUE);library(lrgs)}
#if(!require(spatstat)){install.packages("spatstat", dependencies=TRUE);library(spatstat)}
if (!require(scales)) {
  install.packages("scales", dependencies = TRUE)
  library(scales)
}
#if(!require(QRM)){install.packages("QRM", dependencies=TRUE);library(QRM)}
#if(!require(Metrics)){install.packages("Metrics", dependencies=TRUE);library(Metrics)}
#if(!require(optparse)){install.packages("optparse", dependencies=TRUE);library(optparse)}

if (!require(ggplot2)) {
  install.packages("ggplot2", dependencies = TRUE)
  library(ggplot2)
}
if (!require(dplyr)) {
  install.packages("plyr", dependencies = TRUE)
  library(plyr)
}
if (!require(entropy)) {
  install.packages("entropy", dependencies = TRUE)
  library(entropy)
}
if (!require(raster)) {
  install.packages("raster", dependencies = TRUE)
  library(raster)
}

y.transf.betareg <- function(y) {
  n.obs <- sum(!is.na(y))
  (y * (n.obs - 1) + 0.5) / n.obs
}

logistic <- function(p)
  log(p / (1 - p) + 0.01)
