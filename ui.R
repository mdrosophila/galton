library(shiny)
shinyUI(pageWithSidebar(
        headerPanel("Prediction of Son's Height Based on Father's Height"),
        sidebarPanel(
                h4("Enter father's height:"),
                sliderInput('father_height_foot',"Feet",6,min = 4,max = 7,step = 1),
                sliderInput('father_height_inch',"Inches",0,min = 0,max = 12,step = .1),
                submitButton("Submit"),
                h4("References:"),
                p("1. National Health Statistical Report, 2008,"),
                p("2. Galton father.son data set, 1885.")
                
        ),
        mainPanel(
                
                h4("Father's input height (inches):"),
                verbatimTextOutput("father_height"),
                h4("Son's most likely height (inches):"),
                verbatimTextOutput("son_height"),
                h5("95% chance of son's  height (inches) is distributed between:"),
                verbatimTextOutput("son_lr"),
                verbatimTextOutput("son_hr"),
                h4("Height Percentile Among US men:"),
                plotOutput('newPlot')
        )
))