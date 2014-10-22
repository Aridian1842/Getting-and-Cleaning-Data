# Putting together all the test data
         feat<-read.table("C:/Users/inidicadores/Google Drive/RICARDO/COURSERA/Getting and Cleaning Data/Course Project/UCI HAR Dataset/features.txt",sep=" ")
       y_test<-read.table("C:/Users/inidicadores/Google Drive/RICARDO/COURSERA/Getting and Cleaning Data/Course Project/UCI HAR Dataset/test/y_test.txt",sep=" ")
       x_test<-read.table("C:/Users/inidicadores/Google Drive/RICARDO/COURSERA/Getting and Cleaning Data/Course Project/UCI HAR Dataset/test/X_test.txt",sep="",col.names=feat$V2)  #Only in this way it works =( , why, i don't know.   
 subject_test<-read.table("C:/Users/inidicadores/Google Drive/RICARDO/COURSERA/Getting and Cleaning Data/Course Project/UCI HAR Dataset/test/subject_test.txt")
subject_label<-cbind(subject_test,y_test)
      
         names(subject_label)<-c("Subject","Label")
    all_test<-cbind(subject_label,x_test) #Binding all "Test" data matrix 2947x562

# Putting together all the train data         
       x_train<-read.table("C:/Users/inidicadores/Google Drive/RICARDO/COURSERA/Getting and Cleaning Data/Course Project/UCI HAR Dataset/train/X_train.txt",sep="",col.names=feat$V2)
       y_train<-read.table("C:/Users/inidicadores/Google Drive/RICARDO/COURSERA/Getting and Cleaning Data/Course Project/UCI HAR Dataset/train/y_train.txt",sep=" ")
 subject_train<-read.table("C:/Users/inidicadores/Google Drive/RICARDO/COURSERA/Getting and Cleaning Data/Course Project/UCI HAR Dataset/train/subject_train.txt",sep=" ")
subject_label2<-cbind(subject_train,y_train)

         names(subject_label2)<-c("Subject","Label")
    all_train<-cbind(subject_label2,x_train)
# Merging the 2 data sets, train and test data
all<-rbind(all_train,all_test)
         
rm(list=setdiff(ls(), "all")) #Clear all memory except the main data "all"

#Scrip for reeplacing activity labels for activity names

activity<-read.table("C:/Users/inidicadores/Google Drive/RICARDO/COURSERA/Getting and Cleaning Data/Course Project/UCI HAR Dataset/activity_labels.txt",sep=" ",stringsAsFactors=FALSE)   
for(i in 1:6){
  act<-activity[i,2]
  all[,2]<-gsub(i,act,all[,2])
  } 

a<-grep("*std*",colnames(all))  # Listing all colums numbers who got the character "std" inside de feature variable
b<-grep("*mean*",colnames(all)) 
c<-sort(c(a,b))                 # "c" contain all the colums with variables "mean" and "std"
all2<-all[,c(1:2,c)]                   # Subsetting according "c"


all2$id<-paste(all2[,1],"-",all2[,2],sep="")         
split<-by(all2[,3:81],all2$id,colMeans)

final<-data.frame()           
for(i in 1:length(names(split))) {
  data_row<-cbind(id=names(split)[i],as.data.frame(t(split[[i]])))
  final<-rbind(final,data_row)
}   

final$id<-as.character(final$id) 
final<- cbind(read.table(text=final$id, sep = "-", colClasses = "character"),final)
final<-final[,-3]   
final[,1]<-as.numeric(final[,1])         
names(final)[1:2]<-c("Subject","Activity")         
final<-final[order(final$Subject),]
         
write.table(c,file =paste(getwd(),"/Data_Final_Project.txt",sep=""),sep=" ")
