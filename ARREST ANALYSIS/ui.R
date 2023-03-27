

# we start building and adding the ui components gradually 

# the dashboard page will have 3 components 

dashboardPage(
  dashboardHeader(title = "Exploring the 1973 US arrest data with R and Shiny Dashbard",
                  titleWidth = 650,
                  #adding the social media icons 
                  tags$li(class = "dropdown", tags$a(href = "www.linkedin.com/in/NSING_VICTORY", icon("youtube"), "Youtube", target = "_blank"  )),
                  tags$li(class = "dropdown", tags$a(href = "www.linkedin.com/in/NSING_VICTORY", icon("youtube"), "Linkdin", target = "_blank"  )),
                  tags$li(class = "dropdown", tags$a(href = "www.linkedin.com/in/NSING_VICTORY", icon("youtube"), "Source Code", target = "_blank"  ))
                  ),
  dashboardSidebar(
    # working on the side bar menu we define the side bar items within the side bar menu function
  sidebarMenu(
        id = "sidebar",
        
        #first menu item
        menuItem("Dataset", tabName = "data", icon = icon("database")),
        menuItem(text = "Visualization", tabName = "viz", icon = icon("chart-line")),
        conditionalPanel("input.sidebar == 'viz' && input.t2== 'distro' ", selectInput(inputId = "var1", label = "select the variable", choices = c1)),
        conditionalPanel("input.sidebar == 'viz' && input.t2== 'trends' ", selectInput(inputId = "var2", label = "select the Arrest type", choices = c2)),
        conditionalPanel("input.sidebar == 'viz' && input.t2== 'relation' ", selectInput(inputId = "var3", label = "select the X variable", choices = c1, selected = "Rape")),
        conditionalPanel("input.sidebar == 'viz' && input.t2== 'relation' ", selectInput(inputId = "var4", label = "select the Y variable", choices = c1, selected = "Assualt")),
        menuItem(text = "choropleth Map", tabName = "map", icon = icon("map"))
        
  )
    ),
  dashboardBody(
    #creating the landing pages 
    tabItems(
      #first tab item 
      tabItem(tabName = "data", 
              #tab box
              tabBox(
                id = "t1", width = 12,
                tabPanel("About", icon = icon("address-card"), fluidRow(
                  column(width = 8, tags$img(src = "police.jpg", width = 600, height = 500),
                         tags$br(),
                         tags$a("Photo by Ven Victor "), align = "center"),
                  column(width = 4, tags$br(),
                         tags$p("This data set contains statistics, in arrests per 100,000 residents for assault, murder, and rape in each of the 50 US states in 1973. Also given is the percent of the population living in urban areas.  "))
                )),
                tabPanel(title = "Data", icon = icon("address-card"), dataTableOutput("dataT")),
                tabPanel(title = "Structure", icon = icon("address-card"), verbatimTextOutput("structure")),
                tabPanel(title = "Summary", icon = icon("address-card"), verbatimTextOutput("summary"))
              )
              ),
      # secon tab item or landing page here...
      
      tabItem(tabName = "viz",
              tabBox(
                id = "t2", width = 12,
                tabPanel(title = "Crime Trends by State", value = "trends", 
                         fluidRow(tags$div(align = "center", box(tableOutput("top5"), title = textOutput("head1"), collapsible = TRUE, status = "primary", collapsed = TRUE)),
                                  tags$div(align = "center", box(tableOutput("low5"), title = textOutput("head2"),  collapsible = TRUE, status = "primary", collapsed = TRUE))
                         
                         ),withSpinner(plotlyOutput("bar"))),
                tabPanel(title = "Distribution", value = "distro", plotlyOutput("histplot")),
                tabPanel(title = "Correlation Matrix",  plotlyOutput("cor")),
                tabPanel(title = "relationship among arrest types and urban population", value = "relation", 
                         radioButtons(inputId = "fit", label = "select smooth mthod", choices = c("loess", "lm"), selected = "lm", inline = TRUE),
                         withSpinner(plotlyOutput("scatter")))
              )
      ),
      
      # third tab item
      tabItem(tabName = "map",
              box(selectInput("crimetype", "select arrest type", choices = c2, selected = "Rape", width = 250),
                  withSpinner(plotOutput("map_plot")), width = 12
                  ))
      
              )
    )
  )

The net change in forest cover measures any gains in forest cover – either through natural forest expansion or afforestation through tree-planting – minus deforestation.

How much of the world’s land surface today is covered by forest?

In the visualization we see the breakdown of global land area.

10% of the world is covered by glaciers, and a further 19% is barren land – deserts, dry salt flats, beaches, sand dunes, and exposed rocks. This leaves what we call ‘habitable land’.

Forests account for a little over one-third (38%) of habitable land area. This is around one-quarter (26%) of total (both habitable and uninhabitable) land area.

This marks a significant change from the past: global forest area has reduced significantly due to the expansion of agriculture. Today half of global habitable land is used for farming. The area used for livestock farming in particular is equal in area to the world’s forests.

Every year the world loses around 5 million hectares of forest. 95% of this occurs in the tropics. At least three-quarters of this is driven by agriculture – clearing forests to grow crops, raise livestock and produce products such as paper.1

If we want to tackle deforestation we need to understand two key questions: where we’re losing forests, and what activities are driving it. This allows us to target our efforts towards specific industries, products, or countries where they will have the greatest impact.

More than three-quarters (77%) of global soy is fed to livestock for meat and dairy production. Most of the rest is used for biofuels, industry or vegetable oils. Just 7% of soy is used directly for human food products such as tofu, soy milk, edamame beans, and tempeh. The idea that foods often promoted as substitutes for meat and dairy – such as tofu and soy milk – are driving deforestation is a common misconception.

In this article I address some key questions about palm oil production: how has it changed; where is it grown; and how this has affected deforestation and biodiversity. The story of palm oil is not as simple as it is often portrayed. Global demand for vegetable oils has increased rapidly over the last 50 years. Being the most productive oilcrop, palm has taken up a lot of this production. This has had a negative impact on the environment, particularly in Indonesia and Malaysia. But it’s not clear that the alternatives would have fared any better. In fact, because we can produce up to 20 times as much oil per hectare from palm versus the alternatives, it has probably spared a lot of environmental impacts from elsewhere.  "))
                
