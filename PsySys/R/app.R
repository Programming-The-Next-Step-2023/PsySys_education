#' @import shiny shinydashboard qgraph plotly dplyr

# play local video
# make vignette (rmd file)

# THURSDAY & FRIDAY > commit
# Step between Block 3 and 4, to add nodes (free-text) & edges to the map & present map
# Simulating interventions - propagate intervention effect through new map (colors)
# Question: which factor would you target? (optional free-text field of how they would target it)
# Summary statistics under mental-health map (node centrality, edge centrality measure?)(if time)

# create a list with all factors that the user can select
all_factors <- c("Loss of interest","Feeling down ","Stress","Worrying","Overthinking",
               "Sleep problems","Changes in appetite","Self-blame","Trouble concentrating",
               "Breakup","Interpersonal problems","Problems at work")

# create a list with all treatment strategies which the user can choose from
strategies <- c("Practice daily affirmations", "Try marriage counselling", "Take more daytime naps",
                "Join sports club", "Find new hobby", "Avoid discussions with partner",
                "Confide in a trusted person", "Meet friends at a bar", "Volunteer",
                "Practice mindfulness")

# define UI for the multipage shiny app
ui <- dashboardPage(

  # app name
  dashboardHeader(title = "PsySys App"),

  # sidebar layout with a input & output definitions
  dashboardSidebar(

    # sidebar menu
    sidebarMenu(
      menuItem("What is PsySys?", tabName = "instruct"),
      menuItem("1. My factors", tabName = "page1"),
      menuItem("2. My causal chains", tabName = "page2"),
      menuItem("3. My vicious cycles", tabName = "page3"),
      menuItem("4. My treatment targets", tabName = "page4"),
      menuItem("My mental-health map", tabName = "output")
    )
  ),

  # main panel
  dashboardBody(

    # #0ca0c9
    tags$head(
      tags$style(
        HTML("
        .skin-blue .main-header .navbar {
          background-color: #1E2E6B;
        }
        .skin-blue .main-header .logo {
          background-color: #1E2E6B;
        }
        .content-wrapper {
          background-color: white;
        }
      ")
      )
    ),
    #fafbff
    # define different pages
    tabItems(
      # instruction page: Small text + PsySys instructional video (embedded from YouTube)
      tabItem("instruct",
              tags$h3("What is PsySys?", style = "font-weight: bold;"),
              br(),
              h4("Please watch the video below. This 60 second introduction video shortly explains what
                 PsySys is about and what you can expect from the following PsySys session.", style = "line-height: 1.5;"),
              br(), # line break
              tags$iframe(src = "https://www.youtube.com/embed/d8ZZyuESXcU",
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"),
              br(), # line break
              br(), # line break
              tags$hr(style = "border-color: grey; border-width: 2px;"),
              br(), # line break
              tags$div(
                style = "border: 2px solid grey; padding: 10px; border-radius: 5px; background-color: #e8eaeb; line-height: 1.5; font-family: 'Arial', sans-serif;",
                tags$div(
                  style = "margin-top: 10px; margin-bottom: 10px;",
                  fluidRow(
                    column(10, tags$h4("Instructions", style = "font-weight: bold;"), style = "margin-left: 15px;"),
                    column(11, h4("Within this PsySys session you will learn what a mental-health map is and build your own
                                  by working through the exercises. Before you get started, please read through the following
                                  points:", style = "line-height: 1.5;"), style = "margin-left: 15px;")
                  ),
                  tags$ul(
                    tags$li(h4("Please work through the sections in order.")),
                    tags$li(h4("You can switch back and forth through the pages.")),
                    tags$li(h4("After each section you can have a look at your current map.")),
                    tags$li(h4("If you change your initial factor selection, you'll need to go through the subsequent exercises again.", style = "line-height: 1.5;"))
                  )
                )
              )
      ),
      # exercise color alternative: #c5d5de
      # block 1: Small intro text + PsySys video 1 (embedded from YouTube) + exercise (select factors)
      tabItem("page1",
              tags$h3("1. My factors", style = "font-weight: bold;"),
              br(),
              h4("Please watch the video below. This video shows the importance to focus on the personal factors
                 each individual is dealing with to understand their complaints.", style = "line-height: 1.5;"),
              br(), # line break
              tags$iframe(src = "https://www.youtube.com/embed/ttLzT4U2F2I",
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"),
              br(), # line break
              br(), # line break
              tags$hr(style = "border-color: grey; border-width: 2px;"),
              br(),
              tags$div(
                style = "border: 2px solid grey; padding: 10px; border-radius: 5px; background-color: #ccd6db; line-height: 1.5; font-family: 'Arial', sans-serif;",
                tags$div(
                  style = "margin-top: 10px; margin-bottom: 10px;",
                  fluidRow(
                    column(10, tags$h4("Exercise 1: Choose your factors", style = "font-weight: bold;"), style = "margin-left: 15px;"),
                    column(11, h4("Have you recently, or are you currently struggling with some factors that negatively
                   affect your everyday life? Please select the factors you’ve experiences. You can choose several.", style = "line-height: 1.5;"), style = "margin-left: 15px;")
                  )
                ),
              br(), # line break
              # multiple choice where the user can tick all the factors they are currently dealing with
              fluidRow(
                column(10, checkboxGroupInput(inputId = "items", label = NULL,
                                              choices = all_factors,
                                              selected = NULL), style = "margin-left: 15px;")
              ),
              br(),
              # action button - after selecting the factors the user needs to click on the Save button to save the selection
              fluidRow(
                column(2, actionButton("save_factors", "Select"), style = "margin-left: 18px;")
              ))
      ),
      # block 2: Small intro text + PsySys video 2 (embedded from YouTube) + exercise (select 2 factor chains)
      tabItem("page2",
              tags$h3("2. My causal chains", style = "font-weight: bold;"),
              br(),
              h4("Please watch the video below. This video introduces the idea of a mental-health map ─
                 A personal and flexible map that represents how one's personal factors are connected.", style = "line-height: 1.5;"),
              br(), # line break
              tags$iframe(src = "https://www.youtube.com/embed/stqJRtjIPrI",
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"),
              br(), # line break
              br(), # line break
              tags$hr(style = "border-color: grey; border-width: 2px;"),
              br(),
              tags$div(
                style = "border: 2px solid grey; padding: 10px; border-radius: 5px; background-color: #ccd6db; line-height: 1.5; font-family: 'Arial', sans-serif;",
                tags$div(
                  style = "margin-top: 10px; margin-bottom: 10px;",
                  fluidRow(
                    column(10, tags$h4("Exercise 2: Choose two causal chains", style = "font-weight: bold;"), style = "margin-left: 15px;"),
                    column(11, h4("Think about how your factors influence each other. For instance, if you think that
                     problems at work usually lead to overthinking which then results in stress, select these
                     factors in this order.", style = "line-height: 1.5;"), style = "margin-left: 15px;")
                  ),
                ),
                br(),
                fluidRow(
                  #column(2), # Add an offset column to create space
                  column(10, h5("Select the 1. causal chain you struggle with:"), style = "margin-left: 20px;"),
                  column(3.5, selectInput("chain1_01", label = NULL, choices = NULL, selected = NULL), style = "margin-left: 30px;"),
                  column(3.5, selectInput("chain1_02", label = NULL, choices = NULL, selected = NULL), style = "margin-left: 30px;"),
                  column(3.5, selectInput("chain1_03", label = NULL, choices = NULL, selected = NULL), style = "margin-left: 30px;")
                ),
                  # creates three drop down text fields for the user to select the factors corresponding to chain 2
                fluidRow(
                  #column(2), # Add an offset column to create space
                  column(10, h5("Select the 2. causal chain you struggle with:"), style = "margin-left: 20px;"),
                  column(3.5, selectInput("chain2_01", label = NULL, choices = NULL, selected = NULL), style = "margin-left: 30px;"),
                  column(3.5, selectInput("chain2_02", label = NULL, choices = NULL, selected = NULL), style = "margin-left: 30px;"),
                  column(3.5, selectInput("chain2_03", label = NULL, choices = NULL, selected = NULL), style = "margin-left: 30px;")
                ),
                br(),
               # action button - after indicating the chains, the user needs to click on the Update button to include the changes
               fluidRow(
                 column(2, actionButton("save_chains", "Update"), style = "margin-left: 18px;")))
      ),
      # block 3: Small intro text + PsySys video 3 (embedded from YouTube) + exercise (select 2 vicious cycles)
      tabItem("page3",
              tags$h3("3. My vicious cycles", style = "font-weight: bold;"),
              br(),
              h4("Please watch the video below. This video explains how factors in a vicious cycle can keep reinforcing
                 each other and you can thereby get stuck in a downward spiral.", style = "line-height: 1.5;"),
              br(), # line break
              tags$iframe(src = "https://www.youtube.com/embed/EdwiSp3BdKk",
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"),
              br(), # line break
              br(),
              tags$hr(style = "border-color: grey; border-width: 2px;"),
              br(),
              tags$div(
                style = "border: 2px solid grey; padding: 10px; border-radius: 5px; background-color: #ccd6db; line-height: 1.5; font-family: 'Arial', sans-serif;",
                tags$div(
                  style = "margin-top: 10px; margin-bottom: 10px;",
                  fluidRow(
                    column(10, tags$h4("Exercise 3: Choose two vicious cycles", style = "font-weight: bold;"), style = "margin-left: 15px;"),
                    column(11, h4("Now think about the vicious cylces in your life. Indicate one cycle in which two factors reinforce each other and another one in which three factors reinforce each other.", style = "line-height: 1.5;"), style = "margin-left: 15px;")
                  )
                ),
                br(),
                fluidRow(
                  column(7, h5("Select 2 factors that reinforce each other:"), style = "margin-left: 20px;"),
                  column(3.5, selectizeInput("cycle1", label = NULL, choices = NULL, selected = NULL, multiple = TRUE, options = list(maxItems = 2)), style = "margin-left: 30px;"),
                  column(7, h5("Select 3 factors that reinforce each other:"), style = "margin-left: 20px;"),
                  column(3.5, selectizeInput("cycle2", label = NULL, choices = NULL, selected = NULL, multiple = TRUE, options = list(maxItems = 3)), style = "margin-left: 30px;")
                ),
                br(),
                # action button - after indicating the cycles, the user needs to click on the Update button to include the changes
                fluidRow(
                  column(2, actionButton("save_cycles", "Update"), style = "margin-left: 18px;")))
      ),
      # block 4: Small intro text + PsySys video 4 (embedded from YouTube) + exercise (select promising treatment strategies)
      tabItem("page4",
              tags$h3("4. My treatment targets", style = "font-weight: bold;"),
              br(),
              h4("Please watch the video below. This video explains how mental-health maps can help to find promising treatment
              targets to tackle mental distress.", style = "line-height: 1.5;"),
              br(), # line break
              tags$iframe(src = "https://www.youtube.com/embed/hwisVnJ0y88",
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"),
              br(), # line break
              br(),
              tags$hr(style = "border-color: grey; border-width: 2px;"),
              br(),
              tags$div(
                style = "border: 2px solid grey; padding: 10px; border-radius: 5px; background-color: #ccd6db; line-height: 1.5; font-family: 'Arial', sans-serif;",
                tags$div(
                  style = "margin-top: 10px; margin-bottom: 10px;",
                  fluidRow(
                    column(10, tags$h4("Exercise 4: Choose a promising treatment target", style = "font-weight: bold;"), style = "margin-left: 15px;"),
                    column(11, h4("Have a look at your current mental-health map. Which factor do you think would make most sense to target first?", style = "line-height: 1.5;"), style = "margin-left: 15px;")
                  )
                ),
                br(),
                fluidRow(
                  column(7, h5("Select a promising treatment target:"), style = "margin-left: 20px;"),
                  column(3.5, selectizeInput("target", label = NULL, choices = NULL, selected = NULL, multiple = TRUE, options = list(maxItems = 1)), style = "margin-left: 30px;"),
                ),
                br(),
                fluidRow(
                  column(2, actionButton("save_target", "Update"), style = "margin-left: 18px;")))

      ),
      # Output page where the user is presented with their mental-health map which includes all user inputs from before + possibility to download
      tabItem("output",
              tags$h3("My mental-health map", style = "font-weight: bold;"),
              br(),
              plotOutput("qgraph_output"),
              br(),
              downloadButton("download_graph", "Download map")
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
                             'cycle1', 'cycle2', "target")
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
    qgraph(map_create_skeleton(input_items = input$items),
           labels = input$items, color = "#c5d5de", vsize = c(14))
  })

  # update qgraph object based on drop down selections after clicking "Update" on page 2
  graph_update_chains <- eventReactive(input$save_chains, {
    # include chains in map skeleton
    qgraph(map_include_chains(input_items = input$items,
                              input_chain01 = c(input$chain1_01, input$chain1_02, input$chain1_03),
                              input_chain02 = c(input$chain2_01, input$chain2_02, input$chain2_03)),
           labels = input$items, color = "#c5d5de", vsize = c(14))
  })

  # update qgraph based on cycle selections after clicking "Update" on page 3
  graph_update_cycles <- eventReactive(input$save_cycles, {
    # include cycles in updated chain map
    qgraph(map_include_cycles(input_items = input$items,
                       input_chain01 = c(input$chain1_01, input$chain1_02, input$chain1_03),
                       input_chain02 = c(input$chain2_01, input$chain2_02, input$chain2_03),
                       input_cycle01 = c(input$cycle1[1], input$cycle1[2]),
                       input_cycle02 = c(input$cycle2[1], input$cycle2[2], input$cycle2[3])),
           labels = input$items, color = "#c5d5de", vsize = c(14), edge.color = "#a82511")
  })

  # update qgraph based on target selection after clicking "Update" on page 3
  graph_update_target <- eventReactive(input$save_target, {
    # mark target in the map
    find_target <- which(input$items == input$target)
    # make edge color vector
    node_colors <- rep("#c5d5de", length(input$items))
    node_colors[find_target] <- "#619bba"
    qgraph(map_include_cycles(input_items = input$items,
                              input_chain01 = c(input$chain1_01, input$chain1_02, input$chain1_03),
                              input_chain02 = c(input$chain2_01, input$chain2_02, input$chain2_03),
                              input_cycle01 = c(input$cycle1[1], input$cycle1[2]),
                              input_cycle02 = c(input$cycle2[1], input$cycle2[2], input$cycle2[3])),
           labels = input$items, color = node_colors, vsize = c(14), edge.color = "#a82511")
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

  observeEvent(input$save_target, {
    output$qgraph_output <- renderPlot({
      qgraph_obj(graph_update_target())
    })
  })

  # download graph as a PDF file
  # Shinyfilesave
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
#' Title
#'
#' @return
#' @export
#'
#' @examples
startPsySys <- function() {
  shinyApp(ui = ui, server = server)
}
