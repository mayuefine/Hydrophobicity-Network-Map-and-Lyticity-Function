#!/usr/bin/R
# import data
data <- read.csv("hnm.csv", header = T, row.names = 1)
###seg <- read.csv("pAMP_388_1.csv",  header = F)
###let <- read.csv("pAMP_388_1.fa.csv",  header = F, stringsAsFactors = F)
###lw <- read.csv("pAMP_388_1.li.csv",  header = F)
argv <- commandArgs(TRUE)
csv_file <- argv[1]
fa <- argv[2]
li <- argv[3]
seg <- read.csv(csv_file, header = F)
let <- read.csv(fa,  header = F, stringsAsFactors = F)
lw <- read.csv(li,  header = F)
#Letter Z position
zi <- which(let == "Z")
xi <- which(seg[,1] == zi)
yi <- which(seg[,2] == zi)

# frmt points and letter data
let_da <- c(seg[,1],seg[,2])
let_dat <- sort(unique(let_da))
j = 1
point_data <- data[1,]
for (i in let_dat) {
  point_data[j,] <- data[i,]
  j = j + 1
}

j = 1
p_i <- 0
let_data <-  as.data.frame(let[1,1], stringsAsFactors = F)
for (i in let_dat) {
  if(let[i,1] == "Z"){
    let[i,1] <- "K"
    p_i <- j
  }
  let_data[j,1] <- let[i,1]
  let_data[j,1] <- paste(let_data[j,1], i, sep = "")
  j = j + 1
}
let_data <- as.character(let_data[,1])

# frmt segments data part
j = 1
xy <- xy1 <- data[1,]
for (i in seg[,1]){
  xy[j,] <- data[i,]
  j = j + 1
}

j = 1
for (i in seg[,2]){
  xy1[j,] <- data[i,]
  j = j + 1
}
#plot part
colo = c("#8DD3C7", "#BEBADA")
points_color <- c("#8DD3C7")
points_color[1:nrow(point_data)] <- c("#8DD3C7")
if(p_i){
  points_color[p_i] <- "#FFFFCC"
}
slw <- colSums(lw)

c = paste(csv_file,".png", sep = "")
png(file=c, width = 600*3, height = 380*3, res = 72*3)
plot(point_data, type = "n", main = paste("Lyticity Index = ",round(slw[1],2),sep = ""), axes = T, xaxt="n", yaxt="n", xlab = "", ylab = "")
#segments(xy[,1], xy[,2], xy1[,1], xy1[,2], col = colo[2], lwd = 1.1)
rn <- nrow(xy)
for(i in 1:rn){
  if(i %in% xi | i %in% yi){
    segments(xy[i,1], xy[i,2], xy1[i,1], xy1[i,2], lty = "dotted", col = "#FF9999", lwd = 2)
  }else{
    segments(xy[i,1], xy[i,2], xy1[i,1], xy1[i,2], col = colo[2], lwd = (lw[i,1]+4)/5)
  }
}
points(point_data, col = points_color, cex = 4.75, pch = 20)
text(point_data, labels = let_data, cex = 0.75)
while (!is.null(dev.list()))  dev.off()
