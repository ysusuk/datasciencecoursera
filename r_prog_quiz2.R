library(datasets)
data(iris)
data(mtcars)

s <- split(iris, iris$Species)
means <- lapply(s, function(x) colMeans(x[,c("Sepal.Length", "Sepal.Width")], na.rm = TRUE))
print(means$virginica[["Sepal.Length"]])

average.hp <- tapply(mtcars$hp, mtcars$cyl, mean)
print(abs(average.hp[["4"]] - average.hp[["8"]]))