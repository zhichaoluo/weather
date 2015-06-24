downcity<-read.csv("data/wcode.txt",header=FALSE,colClasses=c("character"))
downcity<-downcity[,1]
#Curl weather data
downday<-seq(from=as.Date("2000-01-01"),to=as.Date("2014-12-31"),by=1)
#downday<-format(downday, '%Y/%m/%d')
downday<-gsub(pattern="-",replacement="/",downday)
CurlByCity<-function(days,citylist){
  #method1
  library(curl)
  for(city in citylist){
    for (day in days){
      d2<-gsub(pattern="/",replacement="-",day)   
      url<-paste("http://www.wunderground.com/history/wmo/",city,"/",day,"/","DailyHistory.html?format=1",sep="")
      destfile<-paste("weatherdata/",city,"-",d2,".csv",sep="")
      tryCatch(
        curl_download(url, destfile, quiet = TRUE),
        error=function(e) {
          print(paste("Error in Get",city,"-",day,e,setp=""))
          cat(city,day,"\n",file="data/error.csv",sep=",",append=TRUE)
        },finally={
          #cat(city,day,"\n",file="data/downloaded.csv",sep=",",append=TRUE)
          cat(city,day,file="data/lastrecord.csv",sep=",")
        }
      )
      Sys.sleep(round(runif(1, 1, 3)))
    }
  }
}

CurlByCity(downday,downcity)
