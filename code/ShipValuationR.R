# Author: saniya-khan ; Github : https://github.com/saniya-k
#The program uses multiple linear regression to find the value of a bulk carrier ship.
#It perform preliminary analysis using correlation. And then the model is refined using results from BIC metric
#setwd("Add custom path)
library(MASS)
#ti visualize the regression results
ggplotRegression <- function (fit) {
  
  require(ggplot2)
  
  ggplot(fit$model, aes_string(x = names(fit$model)[2], y = names(fit$model)[1])) + 
    geom_point() +
    stat_smooth(method = "lm", col = "red") +
    labs(title = paste("Adj R2 = ",signif(summary(fit)$adj.r.squared, 5),
                       "Intercept =",signif(fit$coef[[1]],5 ),
                       " Slope =",signif(fit$coef[[2]], 5),
                       " P =",signif(summary(fit)$coef[2,4], 5)))
}
#read data
shipData = read.csv("RegressionData.csv", header = TRUE)
#shipData
priceVector = shipData$Price
cnames=colnames(shipData)
#Initial correlation analysis
print("Correlation with respect to price")
for (i in 1:nrow(shipData)) {
  if (i != 3 &&  i != 2) {  # Sak :  Ignore Vessel name and price column
    correlationVector = shipData[,i]
    cat(cnames[i],": ",cor(priceVector, correlationVector),"\n")
  }
}

saleDateVector= shipData$SaleDate
yearBuiltVector = shipData$YearBuilt
ageVector = shipData$Age.at.Sale
dwtVector = shipData$DWT
capeSizeVector = shipData$Capesize

meanSaleDateNum = mean(saleDateVector)
sdSaleDate = sd(saleDateVector)

meanYearBuilt = mean(yearBuiltVector)
sdYearBuilt = sd(yearBuiltVector)

meanAge = mean(ageVector)
sdAge = sd(ageVector)

meanDwt = mean(dwtVector)
sdDwt = sd(dwtVector)

meanCapeSize = mean(capeSizeVector)
sdCapesize = sd(capeSizeVector)

meanPrice = mean(priceVector)
sdPrice = sd(priceVector)
saleDateBP=39239 #Betperformer (Target ship) parameters
yearBuiltBP=1997
ageBP=11
dwtBP=172
CapesizeBP=12479
priceBP=0
#regressing on all parameters
newData=data.frame(saleDateBP+yearBuiltBP+ageBP+dwtBP+CapesizeBP)
fit<-lm(formula = priceVector ~ saleDateVector + yearBuiltVector + 
     ageVector + dwtVector + capeSizeVector, data = shipData)
summary(fit)
plot(fit)

#regression on selected parameters (after treating multi colinearity)
newmodel <-rlm(formula = priceVector~ageVector+dwtVector+capeSizeVector)

summary(newmodel)

#Predict price using above model
priceBP=43.7612 +ageBP*-4.4745+dwtBP* 0.2472 +CapesizeBP*  0.0071#coefficents from above function
priceBP # predicted price of bet performer
confint(newmodel)#confidence interval
#predict(fit,newData)
plot(saleDateVector,capeSizeVector)
plot(capeSizeVector,priceVector)

ageVector1=norm(ageVector)
priceVector1=scale(priceVector)
dwtVector1=scale(dwtVector)
capeSizeVector1=scale(capeSizeVector)
#regression after normalizing
normalized_fit=lm(priceVector~ageVector1+dwtVector1+capeSizeVector1)
summary(normalized_fit)

model_output=cbind(ageVector,dwtVector,capeSizeVector,predict(newmodel))
write.csv(model_output,"model_out.csv")


fit3<-lm(formula = priceVector ~ ageVector, data = shipData)
summary(fit3)
ggplotRegression(fit3)
age_out=cbind(ageVector,predict(fit3))
write.csv(age_out,"age_out.csv")
AIC(fit3)

fit1<-lm(formula = priceVector ~ dwtVector, data = shipData)
summary(fit1)
ggplotRegression(fit1)
dwt_out=cbind(dwtVector,predict(fit1))
write.csv(dwt_out,"dwt_out.csv")

AIC(fit1)

fit2<-lm(formula = priceVector ~ capeSizeVector, data = shipData)
summary(fit2)
ggplotRegression(fit2)
cape_out=cbind(capeSizeVector,predict(fit2))
write.csv(cape_out,"cape_out.csv")

BIC(fit) #all vars
BIC(fit1) #dwt
BIC(fit2) #capesize
BIC(fit3) #age



