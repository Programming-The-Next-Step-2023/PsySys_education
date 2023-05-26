# install.packages("shiny")
# install.packages("shinydashboard")
# install.packages("qgraph")
# install.packages("plotly")
# install.packages("dplyr")
library(shiny)
library(shinydashboard)
library(qgraph)
library(plotly)
library(dplyr)

# ver 2 updates
# Option to download mental-health map in the end - DONE
# Give blocks more descriptive names - DONE

# ver 3 to-do
# incorporate functions
# Step between Block 3 and 4, to add nodes (free-text) & edges to the map & present map
# Simulating interventions - propagate intervention effect through new map (colors)
# Question: which factor would you target? (optional free-text field of how they would target it)
# Summary statistics under mental-health map (node centrality, edge centrality measure?)

# functions
# create_skeleton: creates a qgraph with all the chosen items (no edges)
create_skeleton <- function(number_items, names_items){
  adjacency_matrix <- data.frame(matrix(0, nrow = number_items, ncol = number_items))
  colnames(adjacency_matrix) <- rownames(adjacency_matrix) <- names_items
  qgraph(adjacency_matrix, names_items)
}


all_items <- c("Loss of interest","Feeling down ","Stress","Worrying","Overthinking",
               "Sleep problems","Changes in appetite","Self-blame","Trouble concentrating",
               "Breakup","Interpersonal problems","Problems at work")

strategies <- c("Practice daily affirmations", "Try marriage counselling", "Take more daytime naps",
                "Join sports club", "Find new hobby", "Avoid discussions with partner", 
                "Confide in a trusted person", "Meet friends at a bar", "Volunteer", 
                "Practice mindfulness")

# Define UI for the multi-page shiny app
ui <- dashboardPage(
  
  # App name
  dashboardHeader(title = "PsySys App"),
  
  # Sidebar layout with a input & output definitions
  dashboardSidebar(
    
    # Sidebar menu
    sidebarMenu(
      menuItem("Instructions", tabName = "instruct"),
      menuItem("1. My factors", tabName = "page1"),
      menuItem("2. My causal chains", tabName = "page2"),
      menuItem("3. My vicious cycles", tabName = "page3"),
      menuItem("4. My treatment targets", tabName = "page4"),
      menuItem("My mental-health map", tabName = "output")
    )
  ),
  
  # Main panel
  dashboardBody(
    
    # Define different pages 
    tabItems(
      # Instruction page: Small text + PsySys instructional video 
      tabItem("instruct", 
              h4("Please watch the video below. This 60 second introduction video shortly explains what 
                 PsySys is about and what you can expect from the following PsySys session."),
              br(), 
              tags$iframe(src = "https://www.youtube.com/embed/d8ZZyuESXcU", 
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE")
              
      ), 
      # Block 1: Small intro text + PsySys video 1 + exercise (select symptom set)
        
      tabItem("page1", 
              h4("Please watch the video below. This video explains that people might deal differently 
                 with mental distress. Therefore, it shows the importance to focus on the personal factors 
                 each individual is dealing with to understand their complaints."),
              br(),
              tags$iframe(src = "https://www.youtube.com/embed/ttLzT4U2F2I", 
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"),
              br(),
              br(),
              h4("Have you recently, or are you currently struggling with some factors that negatively 
                 affect your everyday life? Please choose which of the following factors you’ve experienced. 
                 You can choose several."),
              br(),
              checkboxGroupInput(inputId = "items", label = NULL, 
                                 choices = all_items, 
                                 selected = NULL),
              actionButton("save_01", "Add")
      ),
      
      tabItem("page2", 
              h4("Please watch the video below. This video introduces the idea of a mental-health map ─ 
                 A personal and flexible map that represents how one's personal factors are connected."),
              br(), 
              tags$iframe(src = "https://www.youtube.com/embed/stqJRtjIPrI", 
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"),
              br(),
              br(),
              h4("Indicate two causal chains that seem plausible to you. For instance, if you think that 
                 problems at work usually lead to overthinking which then results in stress, drag & drop 
                 these factors in one of the boxes below."),
              br(),
              fluidRow(
                column(5, h5("Select a causal chain you sometimes struggle with:")),
                column(3.5, selectInput("dropdown_input", label = NULL, choices = NULL, selected = NULL)),
                column(3.5, selectInput("dropdown_input2", label = NULL, choices = NULL, selected = NULL)),
                column(3.5, selectInput("dropdown_input3", label = NULL, choices = NULL, selected = NULL))
              ),
              fluidRow(
                column(5, h5("Select a second causal chain you sometimes struggle with:")),
                column(3.5, selectInput("dropdown_input4", label = NULL, choices = NULL, selected = NULL)),
                column(3.5, selectInput("dropdown_input5", label = NULL, choices = NULL, selected = NULL)),
                column(3.5, selectInput("dropdown_input6", label = NULL, choices = NULL, selected = NULL))
              ),
              actionButton("save_02", "Add")
      ), 
      
      tabItem("page3",
              h4("Please watch the video below. This video explains how factors in a vicious cycle can keep reinforcing 
                 each other and you can thereby get stuck in a downward spiral."),
              br(),
              tags$iframe(src = "https://www.youtube.com/embed/EdwiSp3BdKk", 
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"), 
              br(), 
              h4("Now think about the vicious cylces in your life. Indicate one cycle containing two factors and another one containing three factors."),
              br(),
              fluidRow(
                column(7, h5("Select two factors that reinforce each other:")),
                column(3.5, selectizeInput("cycle1", label = NULL, choices = NULL, selected = NULL, multiple = TRUE, options = list(maxItems = 2))),
                column(7, h5("Select three factors that reinforce each other:")),
                column(3.5, selectizeInput("cycle2", label = NULL, choices = NULL, selected = NULL, multiple = TRUE, options = list(maxItems = 3)))
                ),
              actionButton("save_03", "Add")
      ),
      
      tabItem("page4",
              h4("Please watch the video below. This video explains how to use a mental-health map to tackle mental 
                 distress."),
              br(),
              tags$iframe(src = "https://www.youtube.com/embed/hwisVnJ0y88", 
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"),
              br(), 
              h4("Have a look at your current mental-health map. What could be promising treatment strategies?"),
              br(),                                                              
              checkboxGroupInput(inputId = "strategies", label = NULL, 
                                 choices = strategies, 
                                 selected = NULL)
              #plotOutput("qgraph_output")
              
      ),
      
      tabItem("output", 
              #plotOutput("qgraph_output")
              plotOutput("qgraph_output"),
              downloadButton("download_graph", "Download Graph")
      )
    )
  )                       
)

server <- function(input, output, session) {
  
  observeEvent(input$items,{
    updateSelectInput(inputId = 'dropdown_input',choices = input$items,selected = '')
    updateSelectInput(inputId = 'dropdown_input2',choices = input$items,selected = '')
    updateSelectInput(inputId = 'dropdown_input3',choices = input$items,selected = '')
    updateSelectInput(inputId = 'dropdown_input4',choices = input$items,selected = '')
    updateSelectInput(inputId = 'dropdown_input5',choices = input$items,selected = '')
    updateSelectInput(inputId = 'dropdown_input6',choices = input$items,selected = '')
    
    updateSelectInput(inputId = "cycle1", choices = input$items, selected = '')
    updateSelectInput(inputId = "cycle2", choices = input$items, selected = '')
  })
  
  toListen <- reactive(list(input$dropdown_input,
                            input$dropdown_input2,
                            input$dropdown_input3))
  
  observeEvent(toListen(),{
    updateSelectInput(inputId = 'dropdown_input',
                      choices = input$items,
                      selected = ifelse(input$dropdown_input == '','',input$dropdown_input))
    updateSelectInput(inputId = 'dropdown_input2',
                      choices = setdiff(input$items, input$dropdown_input),
                      selected = ifelse(input$dropdown_input2 == '','',input$dropdown_input2))
    updateSelectInput(inputId = 'dropdown_input3',
                      choices = setdiff(input$items, c(input$dropdown_input,input$dropdown_input2)),
                      selected = ifelse(input$dropdown_input3 == '','',input$dropdown_input3))
  })
  
  toListen2 <- reactive(list(input$dropdown_input4,
                            input$dropdown_input5,
                            input$dropdown_input6))
  
  observeEvent(toListen2(),{
    updateSelectInput(inputId = 'dropdown_input4',
                      choices = input$items,
                      selected = ifelse(input$dropdown_input4 == '','',input$dropdown_input4))
    updateSelectInput(inputId = 'dropdown_input5',
                      choices = setdiff(input$items, input$dropdown_input4),
                      selected = ifelse(input$dropdown_input5 == '','',input$dropdown_input5))
    updateSelectInput(inputId = 'dropdown_input6',
                      choices = setdiff(input$items, c(input$dropdown_input4,input$dropdown_input5)),
                      selected = ifelse(input$dropdown_input6 == '','',input$dropdown_input6))
  })
  
    
  qgraph_data <- eventReactive(input$save_01, {
    create_skeleton(length(input$items), input$items)
  })
  
  # Update qgraph object based on drop down selections after clicking "Update Graph"
  graph_update_01 <- eventReactive(input$save_02, {
    num_items <- length(input$items)
    data <- data.frame(matrix(rnorm(num_items^2), nrow = num_items))
    colnames(data) <- rownames(data) <- input$items
    data[] <- lapply(data, function(x) 0)
    
    chain_input1 <- which(input$items == input$dropdown_input)
    chain_input2 <- which(input$items == input$dropdown_input2)
    chain_input3 <- which(input$items == input$dropdown_input3)
    chain_input4 <- which(input$items == input$dropdown_input4)
    chain_input5 <- which(input$items == input$dropdown_input5)
    chain_input6 <- which(input$items == input$dropdown_input6)
    data[chain_input1, chain_input2] <- 1
    data[chain_input2, chain_input3] <- 1
    data[chain_input4, chain_input5] <- 1
    data[chain_input5, chain_input6] <- 1
    colnames(data) <- rownames(data) <- input$items
    
    qgraph(data, labels = input$items)
  })

  graph_update_02 <- eventReactive(input$save_03, {
    num_items <- length(input$items)
    data <- data.frame(matrix(rnorm(num_items^2), nrow = num_items))
    colnames(data) <- rownames(data) <- input$items
    data[] <- lapply(data, function(x) 0)
    
    chain_input1 <- which(input$items == input$dropdown_input)
    chain_input2 <- which(input$items == input$dropdown_input2)
    chain_input3 <- which(input$items == input$dropdown_input3)
    chain_input4 <- which(input$items == input$dropdown_input4)
    chain_input5 <- which(input$items == input$dropdown_input5)
    chain_input6 <- which(input$items == input$dropdown_input6)
    data[chain_input1, chain_input2] <- 1
    data[chain_input2, chain_input3] <- 1
    data[chain_input4, chain_input5] <- 1
    data[chain_input5, chain_input6] <- 1
    colnames(data) <- rownames(data) <- input$items
    
    #graph_update_01()
    # Find indeces of first causal chain
    cycle1_item1 <- which(input$items == input$cycle1[1])
    cycle1_item2 <- which(input$items == input$cycle1[2])

    # include in graph
    data[cycle1_item1, cycle1_item2] <- 1
    data[cycle1_item2, cycle1_item1] <- 1

    # Find indeces of first causal chain
    cycle2_item1 <- which(input$items == input$cycle2[1])
    cycle2_item2 <- which(input$items == input$cycle2[2])
    cycle2_item3 <- which(input$items == input$cycle2[3])

    # include in graph
    data[cycle2_item1, cycle2_item2] <- 1
    data[cycle2_item2, cycle2_item3] <- 1
    data[cycle2_item3, cycle2_item1] <- 1
    
    qgraph(data, labels = input$items)
  })
  
  # Define a reactive value to store the qgraph object
  qgraph_obj <- reactiveVal(NULL)
  
  
  # Output qgraph in Page 2
  observeEvent(input$save_01, {
    output$qgraph_output <- renderPlot({
      #qgraph(qgraph_data(), labels = input$items)
      qgraph_obj(qgraph_data())
    })
  })
  
  observeEvent(input$save_02, {
    output$qgraph_output <- renderPlot({
      #qgraph(graph_update_01(), labels = input$items)
      qgraph_obj(graph_update_01())
    })
  })

  observeEvent(input$save_03, {
    output$qgraph_output <- renderPlot({
      #qgraph(graph_update_02(), labels = input$items)
      qgraph_obj(graph_update_02())
    })
  })
  
  # Download graph as a PDF file
  output$download_graph <- downloadHandler(
    filename = function() {
      "my_mental-health_map.pdf"
    },
    content = function(file) {
      pdf(file)
      print(qgraph(qgraph_obj(), labels = input$items))
      dev.off()
    })
  
}
# Run the application 
shinyApp(ui = ui, server = server)
