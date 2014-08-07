library(shiny)
library(UsingR)
data(father.son)
pred<-function(father_height){
        modfit<-lm(sheight~fheight,data=father.son)
        newdata<-data.frame(fheight=father_height)
        son_height<-predict(modfit,newdata,interval="prediction")
        return (son_height)     
}
mean<-69.4
sigma<-3.0

shinyServer(
        function(input,output){
                
                father<-reactive({
                      input$father_height_foot*12+input$father_height_inch
                })
                son<-reactive({pred(father())})
                output$father_height<-renderPrint({father()})
                output$son_height<-renderPrint({round(son()[1],1)})
                output$son_lr<-renderPrint({round(son()[2],1)})
                output$son_hr<-renderPrint({round(son()[3],1)})
                output$newPlot<-renderPlot({
                        x<-seq(50,90,by=0.1)
                        y<-dnorm(x,69.4,3)
                        plot(x,y,type="l",lwd=2,col="black",xlab="Height (Inches)",
                             ylab="Probability",main="US Men's Height Distribution")
                        lines(c(father(),father()),c(-0.02,0.14),col="red",lwd=2)
                        lines(c(son()[1],son()[1]),c(-0.02,0.14),col="blue",lwd=2)
                        legend("topright",lty=c(1,1),lwd=2,col=c("red","blue"),
                               legend=c(paste("father",round(pnorm(father(),mean,sigma)*100,1),"percentile"),
                                        paste("son",round(pnorm(son()[1],mean,sigma)*100,1),"percentile")))
                })
        }
)