library(readr)
library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
library(gridExtra)
library(grid)


Prefecture <- c('北海道','青森県','岩手県','宮城県','秋田県','山形県','福島県','茨城県','栃木県','群馬県','埼玉県','千葉県','東京','神奈川県','新潟県','富山県','石川県','福井県','山梨県','長野県','岐阜県','静岡県','愛知県','三重県','滋賀県','京都府','大阪府','兵庫県','奈良県','和歌山県','鳥取県','島根県','岡山県','広島県','山口県','徳島県','香川県','愛媛県','高知県','福岡県','佐賀県','長崎県','熊本県','大分県','宮崎県','鹿児島県','沖縄県')
file_name<-c('01Hokkaido','02Aomori','03Iwate','04Miyagi','05Akita','06Yamagata','07Fukushima','08Ibaraki','09Tochigi','10Gunma','11Saitama','12Chiba','13Tokyo','14Kanagawa','15Niigata','16Toyama','17Ishikawa','18Fukui','19Yamanashi','20Nagano','21Gifu','22Shizuoka','23Aichi','24Mie','25Shiga','26Kyoto','27Osaka','28Hyogo','29Nara','30Wakayama','31Tottori','32Shimane','33Okayama','34Hiroshima','35Yamaguchi','36Tokushima','37Kagawa','38Ehime','39Kochi','40Fukuoka','41Saga','42Nagasaki','43Kumamoto','44Oita','45Miyazaki','46Kagoshima','47Okinawa')
data_all <- read_csv("prefectures_all.csv", locale = locale(encoding = "SHIFT-JIS"))
head(data_all)
data <- as_tibble(data_all)
data<-na.omit(data)
max_data<-max(data$PCR検査陽性者数)
p<- list()

for (i in 1:47){
  data <- data_all%>%filter(都道府県==Prefecture[i])
  data <- data %>% mutate(date = paste(年,formatC(月, width = 2, flag = "0"),formatC(日, width = 2, flag = "0"), sep="-") %>% ymd())
  data <- data %>% select(date, confirmed = PCR検査陽性者数, recovered = 退院者, deaths = 死亡者)
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




  p[[i]] <- data.long %>% filter(type != 'Total Confirmed') %>%
    ggplot(aes(x=date, y=count)) +
    ylim(0,max_data)+
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

  ggsave(file = paste("image/",file_name[i],".png"), plot = p[[i]])

}
#arrange(p,ncol = 3)
##p_all<-marrangeGrob(p,
  ##                  nrow=47%/%3+1,
    #                ncol=3,
     #               top="")

##ggsave(file = paste("image/ALL.png"), plot = p_all)

