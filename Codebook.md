# Codebook about variables, data and transformation

1. The code first loads the test and train data seperately. The test data is in xtest, ytest ans stest. The train data is in xtrain, ytrain and strain.

2.  Name the variables of the sets according to the feature file. To do this, I get the activity labels and features from relevant files. When I look for the mean and std related data, I use grepl() function to match the strings which include the "mean" or "std". Then use names() function add those labels. The target vector is a logical vector.

3.  Extract the mean and std related data from original data. Store the data in meanStd1 and meanStd2.

4.  Name the columns of the y and subject data in order to combine them lately. Same as before, I use names() to do it.

5.  Match the activity label in y according to the activity ID. Here, I use two for-loop to finish the job. After the loop, every row has been added a new column which indicates the activity label of that row.

6.  Combine the data and oder the data, which is the merged data set. I just use cbind(), rbind() function to do it because within test or train data, the rank of row is same, while the rank of column of the test and train data is the same. So use different functions.

7.  Using melt() and dcast() function to get the new tidy data with mean. Here I assign values to the id.vars and measure.vars so R knows what to calculate.
