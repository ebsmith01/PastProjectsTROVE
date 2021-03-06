####################
####################
###PRE-PROCESSING/##
###LOAD PACAKGES####
####################
####################
#naming on groups in both and numeric, char tab.
library(shiny)
library(reshape2)
library(scales)
library(readr)
library(knitr)
library(kableExtra)
library(readxl)
library(dplyr)
library(dlookr)
library(d3heatmap)
library(ebsThemes)
library(DT)
library(ggplot2)
library(stringr)
rm(list=ls())
#label capitalized, format number uniformly
#commas and no scientific notation, scales package
###############DATA LOAD AND DISPLAY NAMES MAPPING #############

# t-test/ chisq results also, put in 1 file and designate response variable, ways to insulate against data drift
# produce an analsis with short name


####################Specify linking fields###########
LINK <- c('INDEX')



dataset1 <-  read.csv('insurance.csv')
if(nrow(dataset1) > 5000){
    first_dataset <- dataset1 %>% sample_n(5000)
} else {
    (first_dataset <- dataset1)
}

dataset2 <-  read.csv('insurance.csv')
# 
if(nrow(dataset2) > 5000){
    second_dataset <- dataset2 %>% sample_n(5000)
} else {
    (second_dataset <- dataset2)
}

cbPalette <- c('#8B0000',  "grey80")



num_both <- merge(dataset1 %>% select_if(is.numeric) ,dataset2 %>% select_if(is.numeric), by=LINK, suffixes = c('.#1', '.#2'))
num_both<- num_both[, !duplicated(colnames(num_both))]

cordata <-
    (reshape2::melt(cor(x= num_both[names(num_both)
                                    [grep('.#1', names(num_both),
                                          fixed = TRUE)]],
                        y= num_both[ names(num_both)
                                     [grep('.#2', names(num_both),
                                           fixed = TRUE)]],
                        use= 'pairwise.complete.obs')))
names(cordata) <- c('First', 'Second', 'Correlation')
x <- (cordata %>%
          filter((str_sub(cordata[,1],end=-3))==str_sub(cordata[,2],end=-3)))

##########################
##### UI SIDE OF APP######
##########################
ui <- navbarPage(' EBS ',
                 theme = "bootstrap.css",
                 tabPanel('Data Selection',

                          div(style="display: inline-block;vertical-align:top; width: 300px;"
                              ,selectInput('x1', 'Data', choices= c("Dataset #1", 'Dataset #2',
                                                                    'BOTH'),
                                           selected ='Dataset #1')),
                          div(style="display: inline-block;vertical-align:top; width: 300px;"
                              ,selectInput('y', 'Data Type', choices= c('Numeric', 'Character'),
                                           selected ='Numeric')),
                          div(style="display: inline-block;vertical-align:top; width: 300px;"
                              ,selectInput('lc', 'Linking Fields', choices= names(dataset1),
                                           multiple = TRUE,
                                           selected = names(dataset1)[1:2])),
                          fluidRow(
                              dataTableOutput('fulldata'))),


                 tabPanel('Descriptive Statistics',
                          fluidRow(
                              dataTableOutput('dto'))),

                 tabPanel('Variable Distribution',
                          div(style="display: inline-block;vertical-align:top; width: 200px;",
                              selectInput('aa1', 'Numeric Variable',colnames(dataset1),
                                          selected = "AGE", multiple = TRUE)),
                          div(style="display: inline-block;vertical-align:top; width: 200px;",
                              selectInput('ab1', 'Character Variable '
                                          , colnames(dataset1), selected = 'EDUCATION', multiple = TRUE)),
                          fluidRow(
                              plotOutput('density')),
                          fluidRow(
                              plotOutput('freq'))

                 ),

                 tabPanel('Correlation Table',
                          fluidRow(dataTableOutput("dto2"))),
                 tabPanel('Corr Graph',
                          fluidRow(
                              plotOutput('cor',height = 550))),
                 tabPanel('Corr Heatmap' ,
                          div(style="display: inline-block;vertical-align:top; width: 200px;",
                              selectInput('corrx', 'first_dataset Variable', names(num_both)
                                          [grep('.#1', names(num_both), fixed = TRUE)],
                                          multiple = TRUE, selected = names(num_both)
                                          [grep('.#1', names(num_both), fixed = TRUE)][1:3])),
                          div(style="display: inline-block;vertical-align:top; width: 200px;",
                              selectInput('corry', 'second_dataset Variable', names(num_both)
                                          [grep('.#2', names(num_both), fixed = TRUE)] ,
                                          multiple = TRUE, selected = names(num_both)
                                          [grep('.#2', names(num_both), fixed = TRUE)][1:3]))
                          ,
                          fluidRow(
                              d3heatmapOutput("corr_plot")
                          )))

##########################
##### SERVER SIDE OF APP##
##########################

server <- function(input, output)
{

    quarter <- reactive({
        if (input$x1 == "Dataset #1") {
            return(first_dataset)}
        if (input$x1 == "Dataset #2") {
            return(second_dataset)}
        else {
            return(merge(first_dataset,second_dataset,
                         by=input$lc,
                         suffixes = c('.#1', '.#2')))
        }
    })

    value <- reactive({
        if (input$y== "Numeric") {
            return(quarter()[unlist(num)])}
        if (input$y== "Character")  {
            return(quarter()[unlist(char)])
        }
    })

    val2 <- reactive({
        if (input$x1 == "BOTH") {
            denmelt <- data.frame(first_dataset[unlist(input$aa1)],
                                  second_dataset[unlist(input$aa1)])
            den <- melt(na.omit(denmelt))
            colnames(den) <- c('Variable', "Value")
            reactgraph <- (ggplot(den,aes(x=Value, fill=Variable)) +
                               geom_density(alpha=0.75) +ebs_black() +
                               ylab("Density") +
                               scale_x_continuous(labels = comma) +
                               scale_y_continuous(
                                   labels = number_format(accuracy = 0.000001)) +
                               scale_fill_manual(values=cbPalette,name="Dataset",
                                                 labels=c("First Dataset Variable",
                                                          "Second Dataset Variable"))
            )


        }

        if (input$x1 == "Dataset #1"){
            denmelt <- data.frame(first_dataset[unlist(input$aa1)])
            den <- melt(na.omit(denmelt))
            colnames(den) <- c('Variable', "Value")
            reactgraph <- (ggplot(den,aes(x=Value, fill=Variable)) +
                               geom_density(alpha=0.75) +ebs_black() +
                               scale_fill_manual(values=cbPalette)+ ylab("Density")+
                               scale_x_continuous(labels = comma) +
                               scale_y_continuous(labels =
                                                      number_format(accuracy = 0.000001)))
        }
        if (input$x1 == "Dataset #2"){
            denmelt <- data.frame(second_dataset[unlist(input$aa1)])
            den <-  melt(na.omit(denmelt))
            colnames(den) <- c('Variable', "Value")
            reactgraph <- (ggplot(den,aes(x=Value, fill=Variable)) +
                               geom_density(alpha=0.75) +ebs_black() +
                               ylab("Density") +
                               scale_fill_manual(values=cbPalette)+
                               scale_x_continuous(labels = comma)+
                               scale_y_continuous(labels =
                                                      number_format(accuracy = 0.000001)))
        }


        return(reactgraph)

    })



    val1 <- reactive({
        if (input$x1 == "BOTH") {
            first_datasetfreq <- table(first_dataset[,(input$ab1)])
            f3 <- as.data.frame(first_datasetfreq) %>%  filter(Freq > 50)
            second_datasetfreq <- table(second_dataset[,(input$ab1)])
            f4 <- as.data.frame(second_datasetfreq) %>% filter(Freq > 50)
            l <-  bind_rows("Group 1" = f3, "Group 2" = f4, .id = "Group")
            reactgraph <- (ggplot(l, aes(x=Var1, y=Freq, fill = Group))
                           +geom_col(stat = "identity", position = 'dodge') +
                               ebs_black() +scale_fill_manual(values=cbPalette) +
                               xlab('Character Variable, only variables with >50 occurances displayed')+
                               scale_y_continuous(labels = comma))
        }

        if (input$x1 == "Dataset #2"){
            second_datasetfreq <- table(second_dataset[,(input$ab1)])
            k <- as.data.frame(second_datasetfreq) %>%
                filter(Freq > 50)
            reactgraph <- (ggplot(k, aes(x=Var1, y=Freq)) +
                               geom_col(fill= '#8B0000') +
                               ebs_black()+
                               xlab('Character Variable, only variables with >50 occurances displayed') +
                               scale_y_continuous(labels = comma))
        }
        if (input$x1 == "Dataset #1"){
            second_datasetfreq <- table(first_dataset[,(input$ab1)])
            k <- as.data.frame(second_datasetfreq) %>%
                filter(Freq > 50)
            reactgraph <- (ggplot(k, aes(x=Var1, y=Freq)) +
                               geom_col(fill= '#8B0000') +
                               ebs_black()+ xlab('Character Variable, only variables with >50 occurances displayed')+
                               scale_y_continuous(labels = comma))
        }
        return(reactgraph)
    })





































    output$fulldata <- renderDataTable(datatable((quarter()), rownames = FALSE))

    output$dto <- renderDataTable({
        datatable(describe(quarter()), filter = "top") %>%
            formatRound(columns = 4:9, digits = 2, interval = 3, mark = ",") %>%
            formatRound(1:3, interval = 3,mark = ',', digits = 0)
    })

    output$dto2 <- renderDataTable({
        if (input$y== "Numeric" & input$x1 == "BOTH") {
            return(datatable(x) %>%
                       formatRound(columns = 3, digits = 2))
        }
    })

    q <- reactive({
        if (input$y== "Numeric" & input$x1 == "BOTH") {
            return(cor(num_both %>%
                           select(input$corrx), num_both %>%
                           select(input$corry), use = "pairwise.complete.obs"))
        }})

    output$corr_plot <- renderD3heatmap({
        d3heatmap(q(), xaxis_font_size = 9, yaxis_font_size = 9)
    })

    output$density <- renderPlot({
        val2()
    })
    output$freq <- renderPlot({
        val1()
    })

    output$cor <- renderPlot({
        if (input$y== "Numeric" & input$x1 == "BOTH") {
            x$First <- str_sub(x[,1],end=-4)
            g <- x %>%
                top_n(-20) %>%
                ggplot(aes(reorder(First, Correlation), Correlation))
            return(g + geom_col(fill= '#8B0000') +
                       ebs_black() +
                       theme(axis.text.x = element_text(angle = 60)) +
                       xlab("Variable"))}

    })
}
shinyApp(ui = ui, server = server)
