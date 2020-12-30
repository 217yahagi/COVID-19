library(readr)
library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
library(gridExtra)
library(grid)

Prefecture <- c('北海道','青森','岩手','宮城','秋田','山形','福島','茨城','栃木','群馬','埼玉','千葉','東京','神奈川','新潟','富山','石川','福井','山梨','長野','岐阜','静岡','愛知','三重','滋賀','京都','大阪','兵庫','奈良','和歌山','鳥取','島根','岡山','広島','山口','徳島','香川','愛媛','高知','福岡','佐賀','長崎','熊本','大分','宮崎','鹿児島','沖縄')
file_name<-c('01Hokkaido','02Aomori','03Iwate','04Miyagi','05Akita','06Yamagata','07Fukushima','08Ibaraki','09Tochigi','10Gunma','11Saitama','12Chiba','13Tokyo','14Kanagawa','15Niigata','16Toyama','17Ishikawa','18Fukui','19Yamanashi','20Nagano','21Gifu','22Shizuoka','23Aichi','24Mie','25Shiga','26Kyoto','27Osaka','28Hyogo','29Nara','30Wakayama','31Tottori','32Shimane','33Okayama','34Hiroshima','35Yamaguchi','36Tokushima','37Kagawa','38Ehime','39Kochi','40Fukuoka','41Saga','42Nagasaki','43Kumamoto','44Oita','45Miyazaki','46Kagoshima','47Okinawa')

data_all <- read_csv("JPN_popcov6to30.csv", locale = locale(encoding = "SHIFT-JIS"))

data_all <- data_all %>% mutate(prf_n=as.integer(substr(data_all$pref,1,2)))
data_all <- data_all %>% mutate(Per_million=data_all$count/(data_all$pop))
make_bar_graph<-function(i){
  data <- data_all%>%filter(prf_n==i)

  table(data$count)

  second_rate  <- max(data$count)/(max(data$Per_million)+1)

  p <- data%>%ggplot(aes(x=week,y=count))+
    geom_bar(stat = "identity", position = "identity")+
    layer( 
      mapping=aes(x=week, y=Per_million*second_rate,color = "red"), 
      geom="line", 
      stat="identity", 
      position="identity"
    )+
    layer( 
      mapping=aes(x=week, y=5*second_rate,color = "red"), 
      geom="line", 
      stat="identity", 
      position="identity"
    )+
    scale_y_continuous(
      limits = c(0,max(data$count)),
      sec.axis = sec_axis(~./second_rate,name = "New infections per million")
    ) 
  return(p)
}
qplot()
     


L=0:10
for(i in L){
  
  print(i)
}
str=""
for (i in 1:47){
  str=paste(str,paste("<option value='",file_name[i],"'>",Prefecture[i],"</option>",sep=""),sep="")
}



               