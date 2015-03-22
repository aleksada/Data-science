#Set working directory
setwd('/home//ilshat/data-science//Data-science/practical-machine-learning/')
#Data variables
training.file   <- './data/pml-training.csv'
test.cases.file <- './data/pml-testing.csv'
training.url    <- 'http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv'
test.cases.url  <- 'http://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv'

#Directories
if (!file.exists("data")){
  dir.create("data")
}
if (!file.exists("data/submission")){
  dir.create("data/submission")
}

#R-Packages
  library("caret")
  library("randomForest")
  library("rpart")
  library("rpart.plot")

# Set seed for reproducability
set.seed(9999)

# Download data
if (!file.exists(training.file)){
  download.file(training.url, training.file)
}
if (!file.exists(test.cases.file)){
  download.file(test.cases.url,test.cases.file )
}

# Clean and subset data
training   <-read.csv(training.file, na.strings=c("NA","#DIV/0!", ""))
testing <-read.csv(test.cases.file , na.strings=c("NA", "#DIV/0!", ""))
training<-training[,colSums(is.na(training)) == 0]
testing <-testing[,colSums(is.na(testing)) == 0]

training   <-training[,-c(1:7)]
testing <-testing[,-c(1:7)]

subSamples <- createDataPartition(y=training$classe, p=0.75, list=FALSE)
subTraining <- training[subSamples, ] 
subTesting <- training[-subSamples, ]

plot(subTraining$classe, col="green", main="Levels of the variable classe", xlab="classe levels", ylab="Frequency")


# Fit model
modelFitDesTree <- rpart(classe ~ ., data=subTraining, method="class")

# Perform prediction
predictDesTree <- predict(modelFitDesTree, subTesting, type = "class")

# Plot result
rpart.plot(modelFitDesTree, main="Classification Tree", extra=102, under=TRUE, faclen=0)

confusionMatrix(predictDT, subTesting$classe)

# Fit model
modelFitRandForest <- randomForest(classe ~ ., data=subTraining, method="class")

# Perform prediction
predictRandForest <- predict(modelFitRandForest, subTesting, type = "class")

confusionMatrix(predictRF, subTesting$classe)

# Perform prediction
predictSubmission <- predict(modFitRF, testing, type="class")
predictSubmission

# Write files for submission
pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("./data/submission/problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}

pml_write_files(predictSubmission)