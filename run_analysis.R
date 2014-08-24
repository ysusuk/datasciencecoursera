library(data.table)
dataset.uri <- "UCI HAR Dataset/"
# x
x.file <- paste0(dataset.uri, "X.txt")
x.train.file <- paste0(dataset.uri, "train/X_train.txt")
x.test.file <- paste0(dataset.uri, "test/X_test.txt")
# y
y.file <- paste0(dataset.uri, "y.txt")
y.train.file <- paste0(dataset.uri, "train/y_train.txt")
y.test.file <- paste0(dataset.uri, "test/y_test.txt")
#
features.file <- paste0(dataset.uri, "features.txt")

file.create(y.file)
file.append(y.file, y.train.file)
file.append(y.file, y.test.file)

file.create(x.file)
file.append(x.file, x.train.file)
file.append(x.file, x.test.file)

features.table <- read.table(features.file,
                       col.names = c("id", "Feature"))
features <- features.table$Feature
features.filtered <- sapply(features, function(x) {
  if (grepl("mean()", x) | grepl("std()", x)) {
    return(x)
  }
  return(NULL)
})

y <- read.table(y.file,
                col.names = c("Action"), nrows = 7000)

x <- read.fwf(x.file,
              widths = rep(16, 561),
              skip = 1, n = 7000)

names(x) <- features
dt <- cbind(x, y$Action)
dt