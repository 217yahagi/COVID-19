library(shiny)


source("make_graph.R",encoding="UTF-8")


# アプリケーションの UI 定義。ヒストグラムを描く
shinyUI(fluidPage(
  titlePanel("都道府県別表示"),
  
  hr(),
  selectInput("Pref", 
              label = h3("select Prefectures"),
              choices = c('01Hokkaido','02Aomori','03Iwate','04Miyagi','05Akita','06Yamagata','07Fukushima','08Ibaraki','09Tochigi','10Gunma','11Saitama','12Chiba','13Tokyo','14Kanagawa','15Niigata','16Toyama','17Ishikawa','18Fukui','19Yamanashi','20Nagano','21Gifu','22Shizuoka','23Aichi','24Mie','25Shiga','26Kyoto','27Osaka','28Hyogo','29Nara','30Wakayama','31Tottori','32Shimane','33Okayama','34Hiroshima','35Yamaguchi','36Tokushima','37Kagawa','38Ehime','39Kochi','40Fukuoka','41Saga','42Nagasaki','43Kumamoto','44Oita','45Miyazaki','46Kagoshima','47Okinawa'),
              selected = "13Tokyo"),
  sliderInput("date",
              "display date",
              min = as.Date(min_date()),
              max = as.Date(max_date()),
              value = as.Date(max_date())),
  br(),
  h3("陽性者数と退院者数、死亡者数"),
  mainPanel(plotOutput("graph")),
  br(),
  h3("感染者数と検査陽性割合"),
  mainPanel(plotOutput("bar_graph")),
  br(),
  mainPanel(tableOutput("table"))
  ))