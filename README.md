#Data Transformation Steps

The following is a description of the steps taken by the R script (run_analysis.R) to transform the assignment data.

	
1. Read x_test.txt (the vector data for the test dataset).
2. Read subject_test.txt (the subject data for the test dataset).
3. Read y_test.txt (the activity data for the test dataset).
4. Column bind subject, y, and x df's for the test dataset (they all have same number of rows).

5. Read x_train.txt (the vector data for the training dataset).
6. Read subject_train.txt (the subject data for the training dataset).
7. Read y_train.txt (the activity data for the training dataset).
8. Column bind subject, y, and x df's for the training dataset (they all have same number of rows).

9. Read activity_labels.txt b/c you want to join in act names; name those df cols.
10. Read features.txt, which are the var names for the vector data.

11. Row bind the training/test df's from above (they have same # of vars). 
12. Use colname to name the df cols, but use make.unique on the vector names df b/c a number of the var names are dups (but their data is unique and should be included).
13. Join the result w/the act labels df on actCodeNum to pick up the descriptive activity name. 
14. Reduce (dplyr select()) the number of column variables to just activity name, subject #, and the vector columns that include "mean()" or "std()".
15. Group the result by activity name and subject.
16. Perform mean summaries on the grouped columns.

Note: Both the raw and combined datasets showed no missing values.


