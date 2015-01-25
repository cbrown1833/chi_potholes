library(shiny)

ph311<-read.csv("311_Potholes_clean.csv",stringsAsFactors=FALSE)
cityAreas<-read.csv("ChicagoNeighborhoodAreas.csv",stringsAsFactors=FALSE)

cityMean <<- round(mean(ph311$cDays),digits=2)
cityMedian <<- median(ph311$cDays)

caMean <- function(cArea) mean(ph311[ph311$Community.Area==cArea,]$cDays)
caMedian <- function(cArea) median(ph311[ph311$Community.Area==cArea,]$cDays)
caCount <- function(cArea) length(ph311[ph311$Community.Area==cArea,]$cDays)
hoodName <- function(cArea) cityAreas[cArea,2]

verdictMean <- function(cArea) {
    diffMean <- round(mean(ph311[ph311$Community.Area==cArea,]$cDays),digits=2) - cityMean
    if(diffMean>-.5 && diffMean<.5) {
        diffMeanMess <- "- Your average response is about the same as for the city as a whole."
    } else if(diffMean<0) {
        diffMeanMess <- paste("- Your average response is better than the city as a whole by",abs(diffMean)," days.")
    } else {
        diffMeanMess <- paste("- Your average response is worse than the city as a whole by",abs(diffMean)," days.")
    }
    message <- diffMeanMess
    return(diffMeanMess)
}

verdictMedian <- function(cArea) {
    diffMedian <- round(median(ph311[ph311$Community.Area==cArea,]$cDays),digits=2) - cityMedian
    if(diffMedian==0) {
        diffMedianMess <- "- Your median response is the same as for the city as a whole."
    } else if(diffMedian<0) {
        diffMedianMess <- paste("- Your median response is better than the city as a whole by",abs(diffMedian)," days.")
    } else {
        diffMedianMess <- paste("- Your median response is worse than the city as a whole by",abs(diffMedian)," days.")
    }
    return(diffMedianMess)
}

histPercent <- function(cArea, ...) {
    H <- hist(ph311[ph311$Community.Area==cArea,]$cDays, plot = FALSE)
    H$density <- with(H, 100 * density* diff(breaks)[1])
    labs <- paste(round(H$density), "%", sep="")
    plot(H, freq = FALSE, xlab="Days to Completion", ylab="Percentage of Potholes Filled", main="60-Day Pothole Repair Completion Chart", labels = labs, xlim=c(0,60), ylim=c(0, 1.08*max(H$density)),...)
}

shinyServer(
  function(input, output) {
    output$myMean <- renderPrint({caMean(input$cArea)})
    output$inputValue <- renderPrint({input$cArea})
    output$cityMeanText <- renderText(paste("The Chicago citywide average to fix a pothole is ",cityMean," days."))
    output$cityMedianText <- renderText(paste("The Chicago citywide median (50% complete) to fix a pothole is ",cityMedian," days."))
    output$panelHeader <- renderText(paste("So, how does it look for ",hoodName(input$cArea),"?"))
    
    output$caCountText <- renderText(paste(caCount(input$cArea)," potholes reported from 2011 through 2014 have been fixed."))
    
    output$myMeanText <- renderText(paste("The average time to fix a pothole was ",round(caMean(input$cArea),digits=2)," days."))
    output$myMedianText <- renderText(paste("The median (50% complete) to fix a pothole was ",round(caMedian(input$cArea),digits=2)," days."))
    output$verdictMedian <- renderText(verdictMedian(input$cArea))
    output$verdictMean <- renderText(verdictMean(input$cArea))
    
    output$cityMean <- renderText(cityMean)
    output$cityMedian <- renderPrint({cityMedian})
    output$myMedian <- renderPrint({caMedian(input$cArea)})
    output$plot <- renderPlot({histPercent(input$cArea, col="lightblue")})
  }
)
