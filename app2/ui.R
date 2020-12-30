library(shiny)


source("weekly_graph.R",encoding="UTF-8")


shinyUI(fluidPage(
  titlePanel("Weekly new infections and infection rate (per 1 million)"),
  br(),
  selectInput("Pref", 
              label = h3("Select prefecture"),
              choices = c('01Hokkaido','02Aomori','03Iwate','04Miyagi','05Akita','06Yamagata','07Fukushima','08Ibaraki','09Tochigi','10Gunma','11Saitama','12Chiba','13Tokyo','14Kanagawa','15Niigata','16Toyama','17Ishikawa','18Fukui','19Yamanashi','20Nagano','21Gifu','22Shizuoka','23Aichi','24Mie','25Shiga','26Kyoto','27Osaka','28Hyogo','29Nara','30Wakayama','31Tottori','32Shimane','33Okayama','34Hiroshima','35Yamaguchi','36Tokushima','37Kagawa','38Ehime','39Kochi','40Fukuoka','41Saga','42Nagasaki','43Kumamoto','44Oita','45Miyazaki','46Kagoshima','47Okinawa'),
              selected = "13Tokyo"),
  br(),
  mainPanel(plotOutput("graph")),
  br(),
  "データは第五週目(2020/2/2~2020/2/8)から",
  br(),
  "使用データ：国立感染症研究所"
  
))