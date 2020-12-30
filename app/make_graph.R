library(readr)
library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
library(gridExtra)
library(grid)


Prefecture <- c('北海道','青森','岩手','宮城','秋田','山形','福島','茨城','栃木','群馬','埼玉','千葉','東京','神奈川','新潟','富山','石川','福井','山梨','長野','岐阜','静岡','愛知','三重','滋賀','京都','大阪','兵庫','奈良','和歌山','鳥取','島根','岡山','広島','山口','徳島','香川','愛媛','高知','福岡','佐賀','長崎','熊本','大分','宮崎','鹿児島','沖縄')
file_name<-c('01Hokkaido','02Aomori','03Iwate','04Miyagi','05Akita','06Yamagata','07Fukushima','08Ibaraki','09Tochigi','10Gunma','11Saitama','12Chiba','13Tokyo','14Kanagawa','15Niigata','16Toyama','17Ishikawa','18Fukui','19Yamanashi','20Nagano','21Gifu','22Shizuoka','23Aichi','24Mie','25Shiga','26Kyoto','27Osaka','28Hyogo','29Nara','30Wakayama','31Tottori','32Shimane','33Okayama','34Hiroshima','35Yamaguchi','36Tokushima','37Kagawa','38Ehime','39Kochi','40Fukuoka','41Saga','42Nagasaki','43Kumamoto','44Oita','45Miyazaki','46Kagoshima','47Okinawa')
data_all <- read_csv("prefectures_all_0803.csv", locale = locale(encoding = "SHIFT-JIS"))
head(data_all)
data_all <- data_all %>% mutate(date = paste(year,formatC(month, width = 2, flag = "0"),formatC(date, width = 2, flag = "0"), sep="-") %>% ymd())
data_all[is.na(data_all)] <- 0
data <- as_tibble(data_all)
data<-na.omit(data)
max_data<-max(data$testedPositive )
p<- list()

max_date <- function(){
  print(max(data_all$date))
  return(max(data_all$date))
}

min_date <- function(){
  
  return(min(data_all$date))
}


make_series<- function(i,maxdate){
  data <- data_all%>%filter(pref==Prefecture[i])%>%filter(date<maxdate)
  data <- data %>% select(date, confirmed = testedPositive , recovered = discharged, deaths = deaths)
  data <- data %>% mutate(current.confirmed = confirmed - deaths - recovered)
  data.long <- gather(data, key = "type", value = "count", -date)
  data.long <- data.long %>% 
    mutate(type=recode_factor(type,
                              confirmed='Total Confirmed',
                              current.confirmed='Current Confirmed',
                              recovered='Recovered',deaths='Deaths')) 
  
  
  
  dates <- data$date
  min.date <- min(dates)
  max.date <- max(dates)
  min.date.txt <- min.date %>% format('%d %b %Y')
  max.date.txt <- max.date %>% format('%d %b %Y')
  
  
  
  
  p <- data.long %>% filter(type != 'Total Confirmed') %>%
    ggplot(aes(x=date, y=count)) +
    #ylim(0,max_data)+
    geom_area(aes(fill=type), alpha=0.5) +
    labs(title=paste0(paste('Numbers of Cases ',Prefecture[i]), max.date.txt)) +
    scale_fill_manual(values=c('red', 'green', 'black')) +
    theme(legend.title=element_blank(), legend.position='bottom',
          plot.title = element_text(size=8),
          axis.title.x=element_blank(),
          axis.title.y=element_blank(),
          legend.key.size=unit(0.2, 'cm'),
          legend.text=element_text(size=6),
          axis.text=element_text(size=7),
          axis.text.x=element_text(angle=45, hjust=1))
  
  
  return(p)
  ##ggsave(file = paste("image/",file_name[i],".png"), plot = p[[i]])
  
}

##
make_bar_graph <- function(i,maxdate){
  data <- data_all%>%filter(pref ==Prefecture[i])%>%filter(date<maxdate)
  #data%>%select()
  
  print(data$testedPositive ,data$peopleTested )
  
  data <- data %>% mutate(陽性割合=data$testedPositive /data$peopleTested *100)
  
  second_rate  <- max(data$testedPositive )/(max(data$陽性割合)+1)
  print(tail(data$陽性割合))
  
  g <- data%>%ggplot(aes(x = date, y = testedPositive ))+
    geom_bar(stat = "identity", position = "identity")+
    layer( 
      mapping=aes(x=date, y=陽性割合*second_rate,color = "red"), 
      geom="line", 
      stat="identity", 
      position="identity"
    )+
    scale_y_continuous(
      limits = c(0, max(data$testedPositive )),
      sec.axis = sec_axis(~./second_rate,name = "陰性割合(%)")
    ) 
    
  return(g)
}



make_table <- function(i,maxdate) {
  data <- data_all%>%filter(pref ==Prefecture[i])%>%filter(date<maxdate)
  data <- data %>% select(date, confirmed = testedPositive , recovered = 退院者, deaths = 死亡者)
  print(data)
  return(data)
  
}







