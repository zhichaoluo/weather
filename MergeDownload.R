#merge data

MergeDownload<-function(days,citylist){
  
  for(city in citylist){
    data<-c()
    for (day in days){
      
      d2<-gsub(pattern="/",replacement="-",day) 
      destfile<-paste("data/53698/",city,"-",d2,".csv",sep="")
      #no<-length(readLines(destfile))

      if (file.exists(destfile)){
        if(length(readLines(destfile))>=3){
      
              down<-read.csv(destfile,header=F,skip=2,stringsAsFactors =FALSE)
              down$city<-city
              down$day<-day
              
        
        if (ncol(down)==16  ){
        
          if (length(data)==0){
            data<-down
          }else{
            data<-rbind(data,down) 
            print(nrow(data))
          }
        }
        }
        }
      }
    outfile<-paste0(city,".csv")
    write.table(data, file = outfile,sep = ",", col.names = NA)         
    }   
     

    
  }
  

downday<-seq(from=as.Date("2000-01-01"),to=as.Date("2014-12-31"),by=1)
downday<-gsub(pattern="-",replacement="/",downday)
downcity<-read.csv("data/wcode.txt",header=FALSE,colClasses=c("character"))
downcity<-downcity[,1]


MergeDownload(downday,downcity)
