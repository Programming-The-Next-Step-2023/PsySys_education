#' @import shiny shinydashboard qgraph plotly dplyr

# Create a list with all initial factors the user can select from
# Note: The initial list can of course consist of an alternative factor set. Ultimately, the initial selection does not
# make a large difference, as the user gets the chance to later include their own factors in a free-text input box. The
# important thing here is that the initial factor selection is finite to constrain the initial map. Alternatively,
# the initial factor selection could also be restricted by an instruction e.g. select between 5-10 factors.
initial_factors <- c("Loss of interest","Feeling down ","Stress","Worrying","Overthinking",
                    "Sleep problems","Changes in appetite","Self-blame","Trouble concentrating",
                    "Breakup","Interpersonal problems","Problems at work")

# Define the UI for the multipage shiny app
ui <- dashboardPage(

  # App name
  dashboardHeader(title = "PsySys App"),

  # Sidebar layout
  dashboardSidebar(

    # Sidebar menu
    sidebarMenu(
      menuItem("What is PsySys?", tabName = "instruct"),
      menuItem("1. My factors", tabName = "page1"),
      menuItem("2. My causal chains", tabName = "page2"),
      menuItem("3. My vicious cycles", tabName = "page3"),
      menuItem("4. My treatment targets", tabName = "page4"),
      menuItem("My mental-health map", tabName = "output")
    )
  ),

  # Main panel
  dashboardBody(

    # Set color theme
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

    # Define the pages
    tabItems(

      # Instruction page: Small text + PsySys instructional video (embedded from YouTube)
      tabItem("instruct",
              tags$h3("What is PsySys?", style = "font-weight: bold;"),
              br(), # Line break
              h4("Please watch the video below. This 60 second introduction video shortly explains what
                 PsySys is about and what you can expect from the following PsySys session.",
                 style = "line-height: 1.5;"),
              br(),
              # Embed YouTube video
              tags$iframe(src = "https://www.youtube.com/embed/d8ZZyuESXcU",
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"),
              br(),
              br(),
              # Include horizontal line
              tags$hr(style = "border-color: grey; border-width: 2px;"),
              br(),
              # Define text box for instruction text
              tags$div(
                style = "border: 2px solid grey; padding: 10px; border-radius: 5px; background-color: #e8eaeb;
                line-height: 1.5; font-family: 'Arial', sans-serif;",
                tags$div(
                  style = "margin-top: 10px; margin-bottom: 10px;",
                  fluidRow(
                    column(10, tags$h4("Instructions", style = "font-weight: bold;"), style = "margin-left: 15px;"),
                    column(11, h4("Within this PsySys session you will learn what a mental-health map is and build your own
                                  by working through the exercises. Before you get started, please read through the following
                                  points:", style = "line-height: 1.5;"), style = "margin-left: 15px;")
                  ),
                  # Bullet points
                  tags$ul(
                    tags$li(h4("Please work through the sections in order.")),
                    tags$li(h4("You can switch back and forth through the pages.")),
                    tags$li(h4("After each section you can have a look at your current map.")),
                    tags$li(h4("If you change your initial factor selection, you'll need to go through the
                               subsequent exercises again.", style = "line-height: 1.5;"))
                  )
                )
              )
      ),

      # PsySys Block 1: Small intro text + PsySys video 1 (embedded from YouTube) + exercise (select initial factors)
      tabItem("page1",
              tags$h3("1. My factors", style = "font-weight: bold;"),
              br(),
              h4("Please watch the video below. This video shows the importance to focus on the personal factors
                 each individual is dealing with to understand their complaints.",
                 style = "line-height: 1.5;"),
              br(),
              # Embed YouTube video
              tags$iframe(src = "https://www.youtube.com/embed/ttLzT4U2F2I",
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"),
              br(),
              br(),
              # Include horizontal line
              tags$hr(style = "border-color: grey; border-width: 2px;"),
              br(),
              # Define text box for exercise 1
              tags$div(
                style = "border: 2px solid grey; padding: 10px; border-radius: 5px; background-color: #ccd6db;
                line-height: 1.5; font-family: 'Arial', sans-serif;",
                tags$div(
                  style = "margin-top: 10px; margin-bottom: 10px;",
                  fluidRow(
                    column(10, tags$h4("Exercise 1: Choose your factors", style = "font-weight: bold;"),
                           style = "margin-left: 15px;"),
                    column(11, h4("Have you recently, or are you currently struggling with some factors that negatively
                                  affect your everyday life? Please select the factors you’ve experiences. You can choose several.",
                                  style = "line-height: 1.5;"), style = "margin-left: 15px;")
                  )
                ),
                br(),
                # Multiple choice format where the user can tick all the factors they are currently dealing with
                fluidRow(
                  column(10, checkboxGroupInput(inputId = "items", label = NULL,
                                                choices = initial_factors,
                                                selected = NULL), style = "margin-left: 15px;")
                ),
                br(),
                # Action button - after selecting the factors the user needs to click on the "Save" button to save the selection
                # Note: For the general functionality of the app, the action buttons would not be necessary, they however add
                # to a more interactive user experience.
                fluidRow(
                  column(2, actionButton("save_factors", "Select"), style = "margin-left: 18px;")
                ))
      ),

      # PsySys Block 2: Small intro text + PsySys video 2 (embedded from YouTube) + exercise (select 2 factor chains)
      tabItem("page2",
              tags$h3("2. My causal chains", style = "font-weight: bold;"),
              br(),
              h4("Please watch the video below. This video introduces the idea of a mental-health map ─
                 A personal and flexible map that represents how one's personal factors are connected.",
                 style = "line-height: 1.5;"),
              br(),
              # Embed YouTube video
              tags$iframe(src = "https://www.youtube.com/embed/stqJRtjIPrI",
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"),
              br(),
              br(),
              # Include horizontal line
              tags$hr(style = "border-color: grey; border-width: 2px;"),
              br(),
              # Define text box for exercise 2
              tags$div(
                style = "border: 2px solid grey; padding: 10px; border-radius: 5px; background-color: #ccd6db;
                line-height: 1.5; font-family: 'Arial', sans-serif;",
                tags$div(
                  style = "margin-top: 10px; margin-bottom: 10px;",
                  fluidRow(
                    column(10, tags$h4("Exercise 2: Choose two causal chains", style = "font-weight: bold;"),
                           style = "margin-left: 15px;"),
                    column(11, h4("Think about how your factors influence each other. For instance, if you think that
                     problems at work usually lead to overthinking which then results in stress, select these
                     factors in this order.", style = "line-height: 1.5;"), style = "margin-left: 15px;")
                  ),
                ),
                br(),
                # Creates three drop down text fields for the user to select the factors corresponding to chain 1
                fluidRow(
                  column(10, h5("Select the 1. causal chain you struggle with:"), style = "margin-left: 20px;"),
                  column(3.5, selectInput("chain1_01", label = NULL, choices = NULL, selected = NULL),
                         style = "margin-left: 30px;"),
                  column(3.5, selectInput("chain1_02", label = NULL, choices = NULL, selected = NULL),
                         style = "margin-left: 30px;"),
                  column(3.5, selectInput("chain1_03", label = NULL, choices = NULL, selected = NULL),
                         style = "margin-left: 30px;")
                ),
                # Creates three drop down text fields for the user to select the factors corresponding to chain 2
                fluidRow(
                  column(10, h5("Select the 2. causal chain you struggle with:"), style = "margin-left: 20px;"),
                  column(3.5, selectInput("chain2_01", label = NULL, choices = NULL, selected = NULL),
                         style = "margin-left: 30px;"),
                  column(3.5, selectInput("chain2_02", label = NULL, choices = NULL, selected = NULL),
                         style = "margin-left: 30px;"),
                  column(3.5, selectInput("chain2_03", label = NULL, choices = NULL, selected = NULL),
                         style = "margin-left: 30px;")
                ),
                br(),
                # Action button - after exercise 2, the user needs to click on the "Update" button to include the changes
                fluidRow(
                  column(2, actionButton("save_chains", "Update"), style = "margin-left: 18px;")))
      ),
      # PsySys Block 3: Small intro text + PsySys video 3 (embedded from YouTube) + exercise (select 2 vicious cycles)
      tabItem("page3",
              tags$h3("3. My vicious cycles", style = "font-weight: bold;"),
              br(),
              h4("Please watch the video below. This video explains how factors in a vicious cycle can keep reinforcing
                 each other and you can thereby get stuck in a downward spiral.",
                 style = "line-height: 1.5;"),
              br(),
              # Embed the YouTube video
              tags$iframe(src = "https://www.youtube.com/embed/EdwiSp3BdKk",
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"),
              br(),
              br(),
              # Include horizontal line
              tags$hr(style = "border-color: grey; border-width: 2px;"),
              br(),
              # Define text box for exercise 3
              tags$div(
                style = "border: 2px solid grey; padding: 10px; border-radius: 5px; background-color: #ccd6db;
                line-height: 1.5; font-family: 'Arial', sans-serif;",
                tags$div(
                  style = "margin-top: 10px; margin-bottom: 10px;",
                  fluidRow(
                    column(10, tags$h4("Exercise 3: Choose two vicious cycles", style = "font-weight: bold;"),
                           style = "margin-left: 15px;"),
                    column(11, h4("Now think about the vicious cylces in your life. Indicate one cycle in which two factors
                                  reinforce each other and another one in which three factors reinforce each other.",
                                  style = "line-height: 1.5;"), style = "margin-left: 15px;")
                  )
                ),
                br(),
                # Creates two drop down text fields: In the first the user can select 2 factors that create a vicious cycle and
                # in the second text field the user can select 3 factors that create another vicious cycle.
                fluidRow(
                  column(7, h5("Select 2 factors that reinforce each other:"), style = "margin-left: 20px;"),
                  column(3.5, selectizeInput("cycle1", label = NULL, choices = NULL, selected = NULL, multiple = TRUE,
                                             options = list(maxItems = 2)), style = "margin-left: 30px;"),
                  column(7, h5("Select 3 factors that reinforce each other:"), style = "margin-left: 20px;"),
                  column(3.5, selectizeInput("cycle2", label = NULL, choices = NULL, selected = NULL, multiple = TRUE,
                                             options = list(maxItems = 3)), style = "margin-left: 30px;")
                ),
                br(),
                # Action button - after exercise 3, the user needs to click on the "Update" button to include the changes.
                fluidRow(
                  column(2, actionButton("save_cycles", "Update"), style = "margin-left: 18px;")))
      ),

      # PsySys Block 4: Small intro text + PsySys video 4 (embedded from YouTube) + exercise (select promising treatment target)
      tabItem("page4",
              tags$h3("4. My treatment targets", style = "font-weight: bold;"),
              br(),
              h4("Please watch the video below. This video explains how mental-health maps can help to find promising treatment
              targets to tackle mental distress.",
                 style = "line-height: 1.5;"),
              br(),
              # Embed YouTube video
              tags$iframe(src = "https://www.youtube.com/embed/hwisVnJ0y88",
                          width = "560", height = "315", frameborder = "0", allowfullscreen = "TRUE"),
              br(),
              br(),
              # Include horizontal line
              tags$hr(style = "border-color: grey; border-width: 2px;"),
              br(),
              # Define text box for exercise 4
              tags$div(
                style = "border: 2px solid grey; padding: 10px; border-radius: 5px; background-color: #ccd6db;
                line-height: 1.5; font-family: 'Arial', sans-serif;",
                tags$div(
                  style = "margin-top: 10px; margin-bottom: 10px;",
                  fluidRow(
                    column(10, tags$h4("Exercise 4: Choose a promising treatment target", style = "font-weight: bold;"),
                           style = "margin-left: 15px;"),
                    column(11, h4("Have a look at your current mental-health map. Which factor do you think would make
                                  most sense to target first?", style = "line-height: 1.5;"), style = "margin-left: 15px;")
                  )
                ),
                br(),
                fluidRow(
                  column(7, h5("Highlight a promising treatment target:"), style = "margin-left: 20px;"),
                  column(3.5, selectizeInput("target", label = NULL, choices = NULL, selected = NULL, multiple = FALSE),
                         style = "margin-left: 30px;"),
                ),
                br(),
                # Action button - after exercise 4, the user needs to click on the "Update" button to include the changes.
                fluidRow(
                  column(2, actionButton("save_target", "Update"), style = "margin-left: 18px;")))

      ),
      # Output page where the user is presented with their mental-health map + possibility to download
      tabItem("output",
              tags$h3("My mental-health map", style = "font-weight: bold;"),
              br(),
              plotOutput("qgraph_output"),
              br(),
              downloadButton("download_graph", "Download map"),
              br(),
              br(),
              # After exercise 3, two additional text fields are displayed, so the user can add missing factors & connections
              # or remove present factors & connections
              conditionalPanel(
                condition = "input.save_cycles > 0",
                # Edit nodes: The user is presented with a free-text input option and can then either click "Add" or "Delete".
                textInput("new_factor", "Enter factor:"),
                actionButton("add_node", "Add"),
                actionButton("delete_node", "Delete"),
                br(),
                br(),
                # Edit edges: The user is presented with a drop down input field & is allowed to selected two factors
                # the edge will then be drawn from the first factor to the second to either add or delete.
                fluidRow(
                  column(width = 8, selectizeInput("new_edge", "Enter connection (from 1st to 2nd factor):",
                                                   choices = NULL, multiple = TRUE, options = list(maxItems = 2)))
                ),
                actionButton("add_edge", "Add"),
                actionButton("delete_edge", "Delete")
              )
      )
    )
  )
)

server <- function(input, output, session) {

  # Initialize node as reactive value: Will determine the selection for the drop down input fields which
  # will change in response to the nodes the user chooses to add or delete after exercise 3.
  nodes <- reactiveValues(items = NULL)

  # Initialize drop down text fields based on users initial factor selection
  observeEvent(input$items, {
    # Vector with all drop down text fields
    dropdown_textfields <- c('chain1_01', 'chain1_02', 'chain1_03',
                             'chain2_01', 'chain2_02', 'chain2_03',
                             'cycle1', 'cycle2',
                             'target',
                             'new_edge')
    nodes$items <- input$items
    # Iterate over drop down text fields and initialize the choice with the selected factors
    for(textfield in dropdown_textfields){
      updateSelectInput(inputId = textfield,choices = nodes$items,selected = '')
    }
  })

  # Create reactive element chain01_select
  chain01_select <- reactive(list(input$chain1_01,
                                  input$chain1_02,
                                  input$chain1_03))

  # If user inputs a factor into one of the text fields of chain 1, this factor should be excluded in the others as
  # we want to build a causal chain with no feedback loops (will only be introduced in next exercise).
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

  # Create reactive element chain02_select
  chain02_select <- reactive(list(input$chain2_01,
                                  input$chain2_02,
                                  input$chain2_03))

  # If user inputs a factor into one of the text fields of chain 2, this factor should be excluded in the others as
  # we want to build a causal chain with no feedback loops (will only be introduced in next exercise).
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

  # Pop-up text field: After exercise 3, the user will be presented with a pop-up text field pointing out the possibility
  # to edit factors (nodes) and connections (edges) under the tab "My mental-health map".
  observeEvent(input$save_cycles, {
    showModal(
      modalDialog(
        title = "Tweak your mental-health map",
        tags$p("Now that you've completed exercises 1-3, have a look at your current map under the tab ",
               tags$em(tags$b("My mental-health map")), " and add missing factors and connections if necessary. You can also
               delete existing factors and connections in your map. Then, return to ", tags$em(tags$b("4. My treatment targets")), "."),
        easyClose = TRUE,
        footer = NULL
      )
    )
  })

  # Initialize graph_current: Will be updated throughout the exercises
  graph_current <- NULL

  # Create first graph with all initially selected factors
  qgraph_skeleton <- eventReactive(input$save_factors, {
    graph_current <<- map_create_skeleton(input_items = input$items)
    qgraph(graph_current, labels = colnames(graph_current), color = "#c5d5de", vsize = c(14))
  })

  # Update graph based on chain selections after clicking "Update" on page 2
  graph_update_chains <- eventReactive(input$save_chains, {
    graph_current <<- map_include_chains(graph_current,
                                         input_chain01 = c(input$chain1_01, input$chain1_02, input$chain1_03),
                                         input_chain02 = c(input$chain2_01, input$chain2_02, input$chain2_03))
    qgraph(graph_current, labels = colnames(graph_current), color = "#c5d5de", vsize = c(14))
  })

  # Update graph based on cycle selections after clicking "Update" on page 3
  graph_update_cycles <- eventReactive(input$save_cycles, {
    graph_current <<- map_include_cycles(graph_current,
                                         input_cycle01 = c(input$cycle1[1], input$cycle1[2]),
                                         input_cycle02 = c(input$cycle2[1], input$cycle2[2], input$cycle2[3]))
    qgraph(graph_current, labels = colnames(graph_current), color = "#c5d5de", vsize = c(14), edge.color = "#a82511")
  })

  # Update graph including newly selected factor
  graph_add_node <- eventReactive(input$add_node, {
    graph_current <<- map_add_node(graph_current, input$new_factor)
    qgraph(graph_current, labels = colnames(graph_current), color = "#c5d5de", vsize = c(14), edge.color = "#a82511")

    # Update drop down options to include the newly added factor
    nodes$items <- c(nodes$items, input$new_factor)
    dropdown_textfields <- c('chain1_01', 'chain1_02', 'chain1_03',
                             'chain2_01', 'chain2_02', 'chain2_03',
                             'cycle1', 'cycle2', 'target', 'new_edge')
    for(textfield in dropdown_textfields){
      updateSelectInput(inputId = textfield,choices = nodes$items,selected = '')
    }
  })

  # Update graph excluding newly selected factor
  graph_delete_node <- eventReactive(input$delete_node, {
    delete_index <- which(colnames(graph_current) == input$new_factor)

    graph_current <<- map_delete_node(graph_current, input$new_factor)
    qgraph(graph_current, labels = colnames(graph_current), color = "#c5d5de", vsize = c(14), edge.color = "#a82511")

    # Update drop down options to include the newly added factor
    nodes$items <- nodes$items[-delete_index]
    dropdown_textfields <- c('chain1_01', 'chain1_02', 'chain1_03',
                             'chain2_01', 'chain2_02', 'chain2_03',
                             'cycle1', 'cycle2', 'target', 'new_edge')
    for(textfield in dropdown_textfields){
      updateSelectInput(inputId = textfield,choices = nodes$items,selected = '')
    }
  })

  # Update graph including newly added connection
  graph_add_edge <- eventReactive(input$add_edge, {
    graph_current <<- map_add_edge(graph_current, input$new_edge)
    qgraph(graph_current, labels = colnames(graph_current), color = "#c5d5de", vsize = c(14), edge.color = "#a82511")
  })

  # Update graph excluding selected connection
  graph_delete_edge <- eventReactive(input$delete_edge, {
    graph_current <<- map_delete_edge(graph_current, input$new_edge)
    qgraph(graph_current, labels = colnames(graph_current), color = "#c5d5de", vsize = c(14), edge.color = "#a82511")
  })

  # Update graph based on target selection after clicking "Update" on page 4
  graph_update_target <- eventReactive(input$save_target, {
    graph_current <- graph_current
    node_colors <- map_highlight_target(graph_current, input$target)
    qgraph(graph_current, labels = colnames(graph_current), color = node_colors, vsize = c(14), edge.color = "#a82511")
  })

  # Pop-up text field after exercise 4 including information on the most influential factors in the current mental-health map
  # (regarding out-degree centrality)
  observeEvent(input$save_target, {
    png(filename = "temp.png")  # Redirect the qgraph output to a file
    graph <- qgraph(graph_current)
    dev.off()
    showModal(
      modalDialog(
        title = "Congratulations! You've completed the PsySys session.",
        tags$p(map_find_targets(graph_current, graph), ". Your chosen target is now highlighted in your map. You can
               have a look at your final mental-health map and download it if you want."),
        easyClose = TRUE,
        footer = NULL
      )
    )
  })

  # Define a reactive value to store the qgraph object
  qgraph_obj <- reactiveVal(NULL)

  # Output qgraph depending on update stage
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

  observeEvent(input$add_node, {
    output$qgraph_output <- renderPlot({
      qgraph_obj(graph_add_node())
    })
  })

  observeEvent(input$delete_node, {
    output$qgraph_output <- renderPlot({
      qgraph_obj(graph_delete_node())
    })
  })

  observeEvent(input$add_edge, {
    output$qgraph_output <- renderPlot({
      qgraph_obj(graph_add_edge())
    })
  })

  observeEvent(input$delete_edge, {
    output$qgraph_output <- renderPlot({
      qgraph_obj(graph_delete_edge())
    })
  })

  # Download graph as a PDF file
  output$download_graph <- downloadHandler(
    filename = function() {
      "my_mental-health_map.pdf"
    },
    content = function(file) {
      pdf(file)
      print(qgraph(qgraph_obj(), labels = colnames(graph_current)))
      dev.off()
    })
}


