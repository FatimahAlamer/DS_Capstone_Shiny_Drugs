#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.

library(shiny)
library(shinythemes)
library(plotly)
library(tidyverse)
library(leaflet)
top_price <- read_csv("top_price.csv")

HumanDrugs <- read_csv("HumanDrugs.csv")
# remove zero value
HumanDrugs <- subset(HumanDrugs, `Public price`> 0)



 # define UI
ui <- fluidPage(theme = shinytheme("flatly"),
 navbarPage(title = "Shiny Drugs: Registered Drugs in Saudi",
            tabPanel("All Registered Drugs in One Plot",
                     sidebarLayout(
                       sidebarPanel(
                         #textInput("title", "Title", "Register drug year vs Public price"),
                         #numericInput("size", "Point size", 1, 1),
                         #checkboxInput("fit", "Add line of best fit", FALSE),
                         # colourInput("color", "Point color", value = "blue"),
                         selectInput("manu", "You have to select a Country",
                                     
                                     c("All", 
                                       #selected = "Saudi Arabia",
                                       
                                       unique(as.character(HumanDrugs$`Manufacture Country...29`)))),
                         #choices = levels(HumanDrugs$`Manufacture Country...29`),
                         # multiple = TRUE,
                         # selected = "Saudi Arabia"),
                         sliderInput("price", "price",
                                     min(HumanDrugs$`Public price`), max(HumanDrugs$`Public price`),
                                     value = c(100, 500000))
                       ),
                       mainPanel(
                         # Replace the `plotOutput()` with the plotly version
                         plotlyOutput("plot")
                       )
                     ) ),
            tabPanel("All Registered Manufacturer Countries with the highest price", leafletOutput("mymap",width = "100%", height=300)),
             tabPanel(title = "Interactive Table for SFDA drugs",
  fluidRow(
    sliderInput(inputId = "RegYe", "Registered Year",
                min = 1980, max = 2021,
                value = c(2010, 2020),sep ="" ),
    
           column(3,
                  selectInput("man",
                              "manufacturer country:",
                              c("All",
                                unique(as.character(HumanDrugs$`Manufacture Country...29`))))
           ),
           column(4,
                  selectInput("Rout",
                              "Rout of adminstration:",
                              c("All",
                                unique(as.character(HumanDrugs$AdministrationRoute))))
           ),
    column(4,
           selectInput("Type",
                       "Drug Type:",
                       c("All",
                         unique(as.character(HumanDrugs$DrugType))))
    ),
    #column(2,
          # selectInput("Sub",
                    #   "Drug Sub-type:",
                    #   c("All",
                     #    unique(as.character(HumanDrugs$`Sub-Type`))))
   # )
    ),
    # Create a new row for the table.
    DT::dataTableOutput("table")
  ),

 
  tabPanel("Pediatric Paracetamol Calculator",
           # CODE BELOW: Add a sidebarLayout, sidebarPanel, and mainPanel
           sidebarLayout(
             sidebarPanel(numericInput('KG', 'Enter baby weight in kg:', NULL),
                          
                          
                          radioButtons("str", "paracetamol strength",
                                       c("120 mg/5ml"="1",
                                         "125 mg/5ml"="2")),
                          actionButton("submitbutton", 
                                       "Submit", 
                                       class = "btn btn-primary")
             ),
             mainPanel(tags$label(h3('Calculated Dose:')), 
                       # Status/Output Text Box
                      # verbatimTextOutput('contents'),
                       tableOutput('tabledata1') ),
           ),#table panle
           
  tabPanel("About",
           ),
 )))

  server <- function(input, output) {
    output$table <- DT::renderDataTable(DT::datatable({
      data <- HumanDrugs
      #data <- HumanDrugs %>% filter(DrugType!="NA")
      data <- subset(
        data,
        RegisterYear >= input$RegYe[1] & RegisterYear <= input$RegYe[2]
      )
      if (input$man != "All") {
        data <- data[data$`Manufacture Country...29` == input$man,]
      }
      if (input$Rout != "All") {
        data <- data[data$AdministrationRoute == input$Rout,]
      }
     # if (input$Sub != "All") {
       
     #   data <- `Sub-Type` %>% 
       #   filter(`Sub-Type`  == input$Sub)
        #select() %>%  filter(!is.na(`Sub-Type` ), 
   #   }
      if (input$Type != "All") {
        data <- data[data$DrugType  == input$Type,]
      }
      
      data
    }))
    # Replace the `renderPlot()` with the plotly version
    output$plot <- renderPlotly({
      # Convert the existing ggplot2 to a plotly plot
    #  ggplotly({
        data1 <- subset(HumanDrugs,
                       `Manufacture Country...29` %in% input$manu &
                         `Public price` >= input$price[1] &  `Public price` <= input$price[2])
       
         p <- plot_ly(data1, x = ~RegisterYear, y = ~`Public price`, type = 'scatter', mode = 'markers',
                       hoverinfo = 'text',
                       text = ~paste('</br> Trade Name : ', `Trade Name`,
                                     '</br> ATC Classification: ', `AtcCode1`,
                                     '</br> Public price: ', `Public price`))
         p
         
        #p<- data  %>% 
          #filter(`Public price`< 5000 ) %>% 
         # ggplot( aes(x = RegisterYear, y = `Public price`)) + 
         # geom_point(size = 1,shape=1 , col ="#001E6C")+
          # geom_label()
        
          #scale_x_continuous("Register Year", limits = c(1980,2022), expand = c(0,0))+
        #  theme_light()
        #scale_x_log10() +
        # ggtitle(input$title)
        
        #if (input$fit) {
        # p <- p + geom_smooth(method = "lm")
        # }
        # p
    #  })
    })
    
    pal <- colorFactor(palette = c("#A9333A", "#000D6B"), 
                       levels = c("Hospital", "Pharmacy"))
    
    output$mymap <- renderLeaflet({
      leaflet(top_price) %>% 
        addProviderTiles(provider = "CartoDB") %>% 
        addCircles(lng = ~longitude, lat = ~latitude) %>% 
        clearBounds() %>% 
        clearMarkers()%>%
        # addMarkers(data = top_price) %>%
        #my_Map %>%
        
        addCircleMarkers(data = top_price, radius = 3, 
                         color = ~pal(`Distribute area`), 
                         label = ~paste0(`Trade Name`,"(price=",`Public price`,"SR)" )) %>% 
        addLegend(position="bottomright", pal = pal,title = "Distribution area " ,
                  values = c("Hospital", "Pharmacy"))
    }
    )
    datasetInput <- reactive({  
      
      
      
      
      
      #  if (input$str[1]){
      cal <- ceiling(input$KG *5/12)
      cal <- data.frame(cal)
      names(cal) <- "You give your baby every 4-6 hours as needed (ml)"
      print(cal)
      
    })
   # output$contents <- renderPrint({
    #  if (input$submitbutton>0) { 
    #    isolate("Calculation complete.") 
    #  } else {
    #    return("Server is ready for calculation.")
   #   }
  #  })
    
    # Prediction results table
    output$tabledata1 <- renderTable({
      if (input$submitbutton>0) { 
        isolate(datasetInput()) 
      } 
    })
    
  }
  
  
  # Run the application 
  shinyApp(ui = ui, server = server)
  