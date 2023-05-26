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

# QUESTIONS
# function call within function (updating qgraph object)

# ver 3 to-do
# incorporate functions - DONE
# function documentation (***)
# function tests
# package structure
# make qgraph nice (***)

# Step between Block 3 and 4, to add nodes (free-text) & edges to the map & present map
# Simulating interventions - propagate intervention effect through new map (colors)
# Question: which factor would you target? (optional free-text field of how they would target it)
# Summary statistics under mental-health map (node centrality, edge centrality measure?)(if time)

# FUNCTIONS
# map_create_skeleton: creates a qgraph with all the chosen items (no edges)
map_create_skeleton <- function(input_items){
  # extract how many items were selected
  number_items <- length(input_items)
  # create matrix of 0s with as many rows & columns as selected items
  adjacency_matrix <- matrix(0, nrow = number_items, ncol = number_items)
  # set the column and row names of the matrix to the selected items
  colnames(adjacency_matrix) <- rownames(adjacency_matrix) <- input_items
  # create qgraph object (visualization)
  qgraph_object <- qgraph(adjacency_matrix, labels = colnames(adjacency_matrix))
  return(qgraph_object)
}

# map_include_chains: takes an adjacency matrix, the input items & input chains and updates the skeleton
map_include_chains <- function(input_items, input_chain){
  # create matrix of 0s with as many rows & columns as selected items
  adjacency_matrix <- matrix(0, nrow = length(input_items), ncol = length(input_items))
  # set the column and row names of the matrix to the selected items
  colnames(adjacency_matrix) <- rownames(adjacency_matrix) <- input_items
  # create chains
  for(i in 1:(length(input_chain) - 1)){
    index_01 <- which(input_items == input_chain[i])
    index_02 <- which(input_items == input_chain[i+1])
    adjacency_matrix[index_01,index_02] <- 1
  }
  # create updated qgraph object
  qgraph(adjacency_matrix, labels = input_items)
}

# map_include_cycles
map_include_cycles <- function(input_items, input_chain, input_cycle01, input_cycle02){
  # create matrix of 0s with as many rows & columns as selected items
  adjacency_matrix <- matrix(0, nrow = length(input_items), ncol = length(input_items))
  # set the column and row names of the matrix to the selected items
  colnames(adjacency_matrix) <- rownames(adjacency_matrix) <- input_items
  # create chains
  for(i in 1:(length(input_chain) - 1)){
    index_01 <- which(input_items == input_chain[i])
    index_02 <- which(input_items == input_chain[i+1])
    adjacency_matrix[index_01,index_02] <- 1
  }
  # create cycle 1 (input 1 > input 2 > input 1) - find location of elements in matrix
  cycle01_01 <- which(input_items == input_cycle01[1])
  cycle01_02 <- which(input_items == input_cycle01[2])
  # include corresponding edges in matrix
  adjacency_matrix[cycle01_01, cycle01_02] <- 1
  adjacency_matrix[cycle01_02, cycle01_01] <- 1
  # create cycle 2 (input 3 > input 4 > input 5 > input 3) - find location of elements in matrix
  cycle02_01 <- which(input_items == input_cycle02[1])
  cycle02_02 <- which(input_items == input_cycle02[2])
  cycle02_03 <- which(input_items == input_cycle02[3])
  # include corresponding edges in matrix
  adjacency_matrix[cycle02_01, cycle02_02] <- 1
  adjacency_matrix[cycle02_02, cycle02_03] <- 1
  adjacency_matrix[cycle02_03, cycle02_01] <- 1
  # create updated qgraph object
  qgraph(adjacency_matrix, labels = input_items)
}

# create a list with all factors that the user can select
all_factors <- c("Loss of interest","Feeling down ","Stress","Worrying","Overthinking",
               "Sleep problems","Changes in appetite","Self-blame","Trouble concentrating",
               "Breakup","Interpersonal problems","Problems at work")

# create a list with all treatment strategies which the user can choose from
strategies <- c("Practice daily affirmations", "Try marriage counselling", "Take more daytime naps",
                "Join sports club", "Find new hobby", "Avoid discussions with partner",
                "Confide in a trusted person", "Meet friends at a bar", "Volunteer",
                "Practice mindfulness")

# define UI for the multi-page shiny app
ui <- dashboardPage(

  # app name
  dashboardHeader(title = "PsySys App"),

  # sidebar layout with a input & output definitions
  dashboardSidebar(

    # sidebar menu
    sidebarMenu(
      menuItem("Instructions", tabName = "instruct"),
      menuItem("1. My factors", tabName = "page1"),
      menuItem("2. My causal chains", tabName = "page2"),
      menuItem("3. My vicious cycles", tabName = "page3"),
      menuItem("4. My treatment targets", tabName = "page4"),
      menuItem("My mental-health map", tabName = "output")
    )
  ),

  # main panel
  dashboardBody(

    # define different pages
    tabItems(
      # instruction page: Small text + PsySys instructional video (embedded from YouTube)
      tabItem("instruct",
              h4("Please watch the video below. This 60 second introduction video shortly explains what
                 PsySys is about and what you can expect from the following PsySys session."),
              br(), # line break
              tags$iframe(src = "https://www.youtube.com/embed/d8ZZyuESXcU",
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE")

      ),
      # block 1: Small intro text + PsySys video 1 (embedded from YouTube) + exercise (select factors)
      tabItem("page1",
              h4("Please watch the video below. This video explains that people might deal differently
                 with mental distress. Therefore, it shows the importance to focus on the personal factors
                 each individual is dealing with to understand their complaints."),
              br(), # line break
              tags$iframe(src = "https://www.youtube.com/embed/ttLzT4U2F2I",
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"),
              br(), # line break
              br(), # line break
              h4("Have you recently, or are you currently struggling with some factors that negatively
                 affect your everyday life? Please choose which of the following factors you’ve experienced.
                 You can choose several."),
              br(), # line break
              # multiple choice where the user can tick all the factors they are currently dealing with
              checkboxGroupInput(inputId = "items", label = NULL,
                                 choices = all_factors,
                                 selected = NULL),
              # action button - after selecting the factors the user needs to click on the Save button to save the selection
              actionButton("save_factors", "Select")
      ),
      # block 2: Small intro text + PsySys video 2 (embedded from YouTube) + exercise (select 2 factor chains)
      tabItem("page2",
              h4("Please watch the video below. This video introduces the idea of a mental-health map ─
                 A personal and flexible map that represents how one's personal factors are connected."),
              br(), # line break
              tags$iframe(src = "https://www.youtube.com/embed/stqJRtjIPrI",
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"),
              br(), # line break
              br(), # line break
              h4("Indicate two causal chains that seem plausible to you. For instance, if you think that
                 problems at work usually lead to overthinking which then results in stress, drag & drop
                 these factors in one of the boxes below."),
              br(), # line break
              # creates three drop down text fields for the user to select the factors corresponding to chain 1
              fluidRow(
                column(5, h5("Select a causal chain you sometimes struggle with:")),
                column(3.5, selectInput("chain1_01", label = NULL, choices = NULL, selected = NULL)),
                column(3.5, selectInput("chain1_02", label = NULL, choices = NULL, selected = NULL)),
                column(3.5, selectInput("chain1_03", label = NULL, choices = NULL, selected = NULL))
              ),
              # creates three drop down text fields for the user to select the factors corresponding to chain 2
              fluidRow(
                column(5, h5("Select a second causal chain you sometimes struggle with:")),
                column(3.5, selectInput("chain2_01", label = NULL, choices = NULL, selected = NULL)),
                column(3.5, selectInput("chain2_02", label = NULL, choices = NULL, selected = NULL)),
                column(3.5, selectInput("chain2_03", label = NULL, choices = NULL, selected = NULL))
              ),
              # action button - after indicating the chains, the user needs to click on the Update button to include the changes
              actionButton("save_chains", "Update")
      ),
      # block 3: Small intro text + PsySys video 3 (embedded from YouTube) + exercise (select 2 vicious cycles)
      tabItem("page3",
              h4("Please watch the video below. This video explains how factors in a vicious cycle can keep reinforcing
                 each other and you can thereby get stuck in a downward spiral."),
              br(), # line break
              tags$iframe(src = "https://www.youtube.com/embed/EdwiSp3BdKk",
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"),
              br(), # line break
              h4("Now think about the vicious cylces in your life. Indicate one cycle containing two factors and another one containing three factors."),
              br(), # line break
              # creates two drop down text fields for the user to select the factors corresponding to a vicious cycle with 2 and one with 3 factors
              fluidRow(
                column(7, h5("Select two factors that reinforce each other:")),
                column(3.5, selectizeInput("cycle1", label = NULL, choices = NULL, selected = NULL, multiple = TRUE, options = list(maxItems = 2))),
                column(7, h5("Select three factors that reinforce each other:")),
                column(3.5, selectizeInput("cycle2", label = NULL, choices = NULL, selected = NULL, multiple = TRUE, options = list(maxItems = 3)))
                ),
              # action button - after indicating the cycles, the user needs to click on the Update button to include the changes
              actionButton("save_cycles", "Update")
      ),
      # block 4: Small intro text + PsySys video 4 (embedded from YouTube) + exercise (select promising treatment strategies)
      tabItem("page4",
              h4("Please watch the video below. This video explains how to use a mental-health map to tackle mental
                 distress."),
              br(), # line break
              tags$iframe(src = "https://www.youtube.com/embed/hwisVnJ0y88",
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"),
              br(), # line break
              h4("Have a look at your current mental-health map. What could be promising treatment strategies?"),
              br(), # line break
              # creates a multiple choice menu with different strategies from which the user can choose the most promising ones
              checkboxGroupInput(inputId = "strategies", label = NULL,
                                 choices = strategies,
                                 selected = NULL)
              #plotOutput("qgraph_output")

      ),
      # Output page where the user is presented with their mental-health map which includes all user inputs from before + possibility to download
      tabItem("output",
              plotOutput("qgraph_output"),
              downloadButton("download_graph", "Download Graph")
      )
    )
  )
)

server <- function(input, output, session) {

  # initialize drop down text fields based on users factor selection
  observeEvent(input$items, {
    # create a vector with all dropdown textfields
    dropdown_textfields <- c('chain1_01', 'chain1_02', 'chain1_03',
                             'chain2_01', 'chain2_02', 'chain2_03',
                             'cycle1', 'cycle2')
    # iterate over drop down text fields and initialize the choice with the selected factors
    for(textfield in dropdown_textfields){
      updateSelectInput(inputId = textfield,choices = input$items,selected = '')
    }
  })

  chain01_select <- reactive(list(input$chain1_01,
                                  input$chain1_02,
                                  input$chain1_03))

  # if user inputs a factor into one of the text fields, this factor should be excluded in the others
  # reason: we want to build a causal chain with no feedback loops
  observeEvent(chain01_select(),{
    updateSelectInput(inputId = 'chain1_01',
                      choices = input$items,
                      selected = ifelse(input$chain1_01 == '','',input$chain1_01))
    updateSelectInput(inputId = 'chain1_02',
                      choices = setdiff(input$items, input$chain1_01),
                      selected = ifelse(input$chain1_02 == '','',input$chain1_02))
    updateSelectInput(inputId = 'chain1_03',
                      choices = setdiff(input$items, c(input$chain1_01,input$chain1_02)),
                      selected = ifelse(input$chain1_03 == '','',input$chain1_03))
  })

  # function
  chain02_select <- reactive(list(input$chain2_01,
                                  input$chain2_02,
                                  input$chain2_03))

  # if user inputs a factor into one of the text fields, this factor should be excluded in the others
  # reason: we want to build a causal chain with no feedback loops
  observeEvent(chain02_select(),{
    updateSelectInput(inputId = 'chain2_01',
                      choices = input$items,
                      selected = ifelse(input$chain2_01 == '','',input$chain2_01))
    updateSelectInput(inputId = 'chain2_02',
                      choices = setdiff(input$items, input$chain2_01),
                      selected = ifelse(input$chain2_02 == '','',input$chain2_02))
    updateSelectInput(inputId = 'chain2_03',
                      choices = setdiff(input$items, c(input$chain2_01,input$chain2_02)),
                      selected = ifelse(input$chain2_03 == '','',input$chain2_03))
  })


  qgraph_skeleton <- eventReactive(input$save_factors, {
    map_create_skeleton(input_items = input$items)
  })

  # update qgraph object based on drop down selections after clicking "Update" on page 2
  graph_update_chains <- eventReactive(input$save_chains, {
    # include chains in map skeleton
    map_include_chains(input_items = input$items,
                       input_chain = c(input$chain1_01, input$chain1_02, input$chain1_03,
                                         input$chain2_01, input$chain2_02, input$chain2_03))
  })

  # update qgraph based on cycle selections after clicking "Update" on page 3
  graph_update_cycles <- eventReactive(input$save_cycles, {
    # include cycles in updated chain map
    map_include_cycles(input_items = input$items,
                       input_chain = c(input$chain1_01, input$chain1_02, input$chain1_03,
                                       input$chain2_01, input$chain2_02, input$chain2_03),
                       input_cycle01 = c(input$cycle1[1], input$cycle1[2]),
                       input_cycle02 = c(input$cycle2[1], input$cycle2[2], input$cycle2[3]))
  })

  # define a reactive value to store the qgraph object
  qgraph_obj <- reactiveVal(NULL)

  # output qgraph
  observeEvent(input$save_factors, {
    output$qgraph_output <- renderPlot({
      qgraph_obj(qgraph_skeleton())
    })
  })

  observeEvent(input$save_chains, {
    output$qgraph_output <- renderPlot({
      qgraph_obj(graph_update_chains())
    })
  })

  observeEvent(input$save_cycles, {
    output$qgraph_output <- renderPlot({
      qgraph_obj(graph_update_cycles())
    })
  })

  # download graph as a PDF file
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
