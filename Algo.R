library("tree")

library(ggplot2)

library(readr)
library(randomForest)

lane <- data.frame(
  Mon = c(1,1,1,1),
  Tue = c(0,0,0,0),
  Wed = c(0,0,0,0),
  Thurs = c(0,0,0,0),
  Fri = c(0,0,0,0),
  Sat = c(0,0,0,0),
  Sun = c(0,0,0,0),
  time = c(1200,1202,1203,1204),
  intersection_id = c(1,1,1,1),
  lane_id = c(1:4),
  volume = c(0,0,0,0),
  velocity = c(4,6,3,9),
  avg_time_passing = c(0,0,0,0),
  vis = c(0,0,0,0),
  on_off = c(0,0,0,0)
)

t <- data.frame(
  Mon = c(1,1,1,1),
  Tue = c(0,0,0,0),
  Wed = c(0,0,0,0),
  Thurs = c(0,0,0,0),
  Fri = c(0,0,0,0),
  Sat = c(0,0,0,0),
  Sun = c(0,0,0,0),
  time = c(1200,1202,1203,1204),
  intersection_id = c(1,1,1,1),
  lane_id = c(1:4),
  volume = c(0,0,0,0),
  velocity = c(4,6,3,9),
  avg_time_passing = c(0,0,0,0)
)

index = 0 

for(x in 1:4){
  for(i in 1:4){
    if(lane$on_off[i] == 0){
      lane$volume[i] = lane$volume[i] + (floor(runif(1,min=1,max=100))%%20)
    }
    else{
      lane$volume[i] = (floor(runif(1,min=1,max=100))%%50)
    }
  }
    
  index = 0
  ma = 0
  for(i in 1:4){
    if(ma < lane$volume[i] && lane$vis[i] == 0){
      ma = lane$volume[i]
      index = i
    }
  }
  
  lane$vis[index] = 1
  lane$on_off[index] = 1
  for(i in 1:4){
    if(i != index){
      lane$on_off[i]=0
    }
  }
  
  t$Mon[x]=lane$Mon[index]
  t$Tue[x]=lane$Tue[index]
  t$Wed[x]=lane$Wed[index]
  t$Fri[x]=lane$Thurs[index]
  t$Thurs[x]=lane$Fri[index]
  t$Sat[x]=lane$Sat[index]
  t$Sun[x]=lane$Sun[index]
  t$time[x]=lane$time[index]
  t$intersection_id[x]=lane$intersection_id[index]
  t$lane_id[x]=lane$lane_id[index]
  t$volume[x]=lane$volume[index]
  t$velocity[x]=lane$velocity[index]
  
  cat("1- ",lane$volume[1]," 2- ",lane$volume[2]," 3- ",lane$volume[3]," 4- ",lane$volume[4],"\n")
  lane$volume[index]=0
  cat(index,"\n")
}

print(t)

write.csv(t,"/Users/d_silent/Downloads/test.csv")

train<-read.csv("/Users/d_silent/Downloads/train.csv", stringsAsFactors = FALSE)

test<-read.csv("/Users/d_silent/Downloads/test.csv", stringsAsFactors = FALSE)
test <- test[,2:14]
test
str(train)
str(test)
head(test)
train
data.combined <- rbind(train,test)
train.data <- data.combined[1:10080,]
test.labels <- train$avg_time_passing
l <- colnames(data.combined[1:12])
relation <- avg_time_passing  ~ (Mon+Tue+Wed+Thurs+Fri+Sat+Sun+time+intersection_id+lane_id+volume+velocity)
set.seed(1400)
rf <- randomForest(relation, data=train.data,importance = TRUE,ntree=500)
rf


l <- predict(rf,test)
l
test
varImpPlot(rf)

