#data preparation
library(sqldf)
library(dplyr)

city<-read.csv("data/city.csv",header=FALSE,colClasses=c("character"))
downcity<-read.csv("data/wcode.txt",header=FALSE,colClasses=c("character"))
data<-merge(city,downcity,by.x="V11",by.y="V1",all=FALSE)

c1<-read.csv("data/wcode.txt",header=FALSE,colClasses=c("character"))
c2<-read.csv("data/wcode2.txt",header=FALSE,colClasses=c("character"))
