library(shiny)
library(ggplot2)
library(plotly)

# liiklus <- read.csv("data/Liiklusonnetused_2011-2020.csv",sep = ",", na.strings=c("", "","NA"), header = T)
liiklus <- read.table("data/Liiklusonnetused_2011-2020.txt",sep="\t", header=T)

liiklusMod <- liiklus
# kov$kokku <- kov$paberhaali+kov$ehaali
# 
# kov$erakond <- c(1:length(kov$kokku))
# kov$erakond[kov$nimekiri=="Erakond Isamaa ja Res Publica Liit"] <- "IRL"
# kov$erakond[kov$nimekiri!="Erakond Isamaa ja Res Publica Liit"] <- "muu"
# kov$erakond[kov$nimekiri=="Eesti Reformierakond"] <- "REF"
# kov$erakond[kov$nimekiri=="Eesti Keskerakond"] <- "KESK"
# kov$erakond[kov$nimekiri=="Sotsiaaldemokraatlik Erakond"] <- "SDE"
# kov$erakond[kov$nimekiri=="Eesti Konservatiivne Rahvaerakond"] <- "EKRE"
# kov$erakond <- as.factor(kov$erakond )
# 
# 
# neworder <- c("EKRE","IRL","KESK","REF","SDE","muu")
# kov$erakond <- factor(kov$erakond, levels = neworder)

ui <- fluidPage(
     titlePanel("Inimkannatanutega liiklusõnnetuste statistika", windowTitle = "Liiklusõnnetuste statistika"),
     helpText("Allikas: ![](https://www.mnt.ee/et/ametist/statistika/inimkannatanutega-liiklusonnetuste-statistika)"),
     br(),
     tabsetPanel(
     tabPanel("Rakenduse kirjeldus",
              sidebarLayout(
                  sidebarPanel(img(src = "Transpordiamet.png", height = 70, width = 200)),
                  mainPanel(h1("Rakenduse kirjeldus"),
                            p("Rakendus visualiseerib ....
                               ... tulemuste andmeid ning koosneb kolmest vahelehest Tab1-Tab3:"),
                            br(),
                            p("Tab 1: Andmed – sisaldab andmetabeli"),
                            p("Tab 2: "),
                            p("Tab 3: "),
                  ) )),

tabPanel("Andmed",
  mainPanel(
    verbatimTextOutput("summary"),
    dataTableOutput("tabel"),width="100%"),
                      ),

tabPanel("Tab 2",
  mainPanel(
    h1("Tunnused:"),
    p("Tunnus1 - ....."),
          )
        ),
  
tabPanel("Tab 3",
  mainPanel(h1("Tab3")))
     
    ) )
    
    
server <- function(input, output, session) {
  
  output$summary <- renderPrint({
    dataset <- liiklus
    dfSummary(dataset)
  })
  
  output$tabel <- renderDataTable(
    liiklus,
    options =list(
      searching = FALSE,ordering=F, lengthMenu = c(5, 10, 20, 30),
      pageLength = 5,scrollX = TRUE
    )
  ) 
  
  


    
    # output$distPlot <- renderPlotly({
    #     p <- ggplot(kov, aes_string(x = "kokku", y =input$var,
    #                                 colour = "erakond",nimi="nimi")) +
    #         geom_point(data=kov[,-(11:12)],aes_string(x = "kokku", y =input$var,nimi="nimi"),
    #                    colour = "grey")+geom_point()+
    #         facet_wrap(~ erakond)+
    #         theme(legend.position = "none")+
    #         scale_y_log10()+scale_x_log10()+
    #         scale_color_manual(values=c("#8B4513","#009FE3","#00983A","#FFDE00","#E30613","#82368C"))+
    #         xlab("kokku hääli")
    #     ggplotly(p,tooltip = c("kokku",input$var,"nimi"))
    # })
    
    
}

shinyApp(ui = ui, server = server)
