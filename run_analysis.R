library(dplyr)

# Work on test data first
# Read test vector data
xTest <- read.table("./Project 1/UCI HAR Dataset/test/X_test.txt",header=FALSE)
# Read subject data
subTest <- read.table("./Project 1/UCI HAR Dataset/test/subject_test.txt",header=FALSE)
# Read activity data
yTest <- read.table("./Project 1/UCI HAR Dataset/test/y_test.txt",header=FALSE)
# Bind subject and activity numbers to each vector
testDf <- cbind (subTest, yTest, xTest)

# Now do the same steps for training data
# Read vector data
xTrain <- read.table("./Project 1/UCI HAR Dataset/train/X_train.txt",header=FALSE)
# Read subject data
subTrain <- read.table("./Project 1/UCI HAR Dataset/train/subject_train.txt",header=FALSE)
# Read activity data
yTrain <- read.table("./Project 1/UCI HAR Dataset/train/y_train.txt",header=FALSE)
# Bind subject and activity numbers to each vector
trainDf <- cbind (subTrain, yTrain, xTrain)

# Read activity labels
actLabels <- read.table("./Project 1/UCI HAR Dataset/activity_labels.txt",header=FALSE)
names(actLabels) = c("actCodeNum","actName")
# Also read vector var names
MeasureLbls <- read.table("./Project 1/UCI HAR Dataset/features.txt",header=FALSE, stringsAsFactors=FALSE)

# Combine the rows of test and train dfs
testTrainDf <- rbind(testDf, trainDf)
# Add column labels - for vector vars, there are a number of dup var
# names, each w/diff data. Make each name unique (e.g., append .1).
colnames(testTrainDf) <- c("subject", "actCodeNum", make.unique(MeasureLbls[,c(2)]))
# Join activity df w/vector df to add Act Name to rows
testTrainMergedDf <- merge(testTrainDf,actLabels,by="actCodeNum",all=FALSE)
# Only keep vector vars representing means/std's
testTrainMnStdDf <- select(testTrainMergedDf, subject, actName,contains("mean()"), contains("std()"))

# Group result by activity, subject
testTrainGrpdf <- group_by(testTrainMnStdDf, actName, subject)
# Get means of each vector col
testTrainSummary <- summarise_each(testTrainGrpdf, funs(mean))
write.table(testTrainSummary, "./tidy.txt",row.name=FALSE)