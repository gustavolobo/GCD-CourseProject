# Human Activity Recognition Using Smartphones - A Tidy Dataset

In a tidy dataset, each variable you measure should be in one column, and each different observation in a different row.

Some decisions were taken to produce this tidy dataset:

* The first column contains the **subject** number
* The second column contains the **activity** description
* All the other columns are **measurements**
* Only the measurements with `mean()` or `std()` in their title were kept
* lowerCamelCase was used to name the variables, once this makes it easier to read and it is a considerable standard.

To get from the previous dataset to the tidy dataset, the following steps were taken:

1. All the files needed were read to memory in the beginning, in order to not make the code confusing.
2. The train and test sets were merged in three different tables: subjects, activities and measurements.
3. The column names for subject and activity were set.
4. The content of the activities column was filled with descriptive data instead of numbers.
5. The column names for measurements were set.
6. The column names for measurements with `mean()` or `std()` were kept, the others deleted.
7. Some work was done in order to have column names for measurements a bit more descriptive.
8. The subjects, activities and measurements were binded.
9. The output file was produced.
