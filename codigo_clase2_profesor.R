

#https://www.datanovia.com/en/lessons/heatmap-in-r-static-and-interactive-visualization/

InsPack = function (pack) {
  if(pack %in% rownames(installed.packages()) == FALSE) {
    print (paste("Instalando ",pack))
    install.packages(pack)}
} 
InsPack("xlsx")
library(xlsx)
InsPack("readxl")
library(readxl)
InsPack("openxlsx")
library(openxlsx)
InsPack("matrixStats")
library(matrixStats)
InsPack("zoom")
library(zoom)
InsPack("RColorBrewer")
library("RColorBrewer")
InsPack("gplots")
library("gplots")
InsPack("pheatmap")
library("pheatmap")
InsPack("gridExtra")
library("gridExtra")
InsPack("ComplexHeatmap")
library("ComplexHeatmap")
InsPack("dendextend")
library(dendextend)


setwd("D:\\Dropbox\\SIG\\Dictamen\\")

datos<- read.xlsx("iexheatmap.xlsx")
dim(datos)
attach(datos)

#Elaboración de heatmaps para c/grupo
datos2=26-datos[,3:6]

windows()
heatmap(as.matrix(datos2), scale = "row", ylab = "Entidad",
        xlab = "Años",labCol=c("2000","2005","2010","2015"),labRow = datos$Entidad, 
        main = "",cexRow=1,cexCol=1,Colv = NA)

library("gplots")
my_palette <- colorRampPalette(c("black", "red"))(n = 1000)
windows()
heatmap.2(as.matrix(datos2), scale = "none", col = my_palette, ratio=0.7, 
          xlab = "Años",labCol=c("2000","2005","2010","2015"),labRow = datos$Entidad, 
          trace = "none", symbreaks=T,density.info = "none",cexRow=1,cexCol=1,Colv = NA)



rownames(datos2) = datos$Entidad

library(RColorBrewer)
library(ComplexHeatmap)
library(circlize)
mycols <- colorRamp2(breaks = c(1.75,1.375, 1,0.625, 0.25),
                     colors = rev(c("#fee5d9","#fcae91","#fb6a4a","#de2d26","#a50f15")))

#mycols <- colorRamp2(breaks = c(1.75,1.375, 1,0.625, 0.25),
#                    colors = rev(hsv(1, seq(0,1,length.out = 12),1)))
#library(dendextend)
#row_dend = as.dendrogram(hclust(dist(as.matrix(datos2))))
#row_dend = color_branches(row_dend, k = 2)
windows()
Heatmap(as.matrix(datos2),column_title = "Años", km=2,
        column_title_side = c("bottom"), 
        column_title_gp = gpar(fontsize = 14), 
        row_title_gp = gpar(fontsize = 14), 
        row_title_side = c("right"),row_title = "Entidades",
        cluster_columns = FALSE,
        col = mycols,show_row_names = TRUE,
        row_dend_reorder = FALSE,
        row_dend_width = unit(5, "cm"), row_km = 4, 
        #cluster_rows = row_dend, row_dend_gp = gpar(col = "red"),
        heatmap_legend_param = list(title = expression(i - iex)), 
        border = TRUE, rect_gp = gpar(col = "white", lwd = 2))

# ordenados
datos2 <- datos2[order(-datos2[,3]),]

library(RColorBrewer)
library(ComplexHeatmap)
library(circlize)
mycols <- colorRamp2(breaks = c(1.75,1.375, 1,0.625, 0.25),
                     colors = rev(c("#fee5d9","#fcae91","#fb6a4a","#de2d26","#a50f15")))
windows()
Heatmap(as.matrix(datos2),column_title = "Años", 
        column_title_side = c("bottom"), 
        column_title_gp = gpar(fontsize = 12), 
        row_title_gp = gpar(fontsize = 12), 
        row_title_side = c("right"),row_title = "Entidades",
        cluster_columns = FALSE,
        col = mycols,show_row_names = TRUE,
        row_dend_reorder = FALSE,
        row_dend_width = unit(5, "cm"), 
        cluster_rows = FALSE,
        heatmap_legend_param = list(title = expression(i - iex)), 
        border = TRUE, rect_gp = gpar(col = "white", lwd = 2))

#https://jokergoo.github.io/ComplexHeatmap-reference/book/a-single-heatmap.html
#https://colorbrewer2.org/#type=sequential&scheme=Reds&n=5
#https://bootstrappers.umassmed.edu/bootstrappers-courses/pastCourses/rCourse_2016-04/Additional_Resources/Rcolorstyle.html#heat.colors
#https://rpubs.com/htejero/212365

