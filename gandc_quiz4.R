if(!file.exists(".data")) {
  dir.create(".data")
}

if(!file.exists(".data/housing_hid.csv")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
  download.file(fileUrl, destfile=".data/housing_hid.csv", method="curl")
}

housing <- read.csv(".data/housing_hid.csv")
splited <- strsplit(colnames(h$value), "wgtp")[[123]]
print(splited)

#with.united <- grep("^United", colnames(h$value))
#print(with.united)

if(!file.exists(".data/gdp.csv")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
  download.file(fileUrl, destfile=".data/gdp.csv", method="curl")
}

gdp <- read.csv(".data/gdp.csv",
                col.names = c("id", "Ranking", "t", "Economy", "us.dollars", "t.1", "t.2", "t.3", "t.4", "t.5"),
                skip = 4, nrows = 190)
dollars <- gdp$us.dollars
dollars.without.commas <- gsub(",", "", dollars)
num.dollars <- as.numeric(dollars.without.commas)
print(num.dollars)
print(mean(num.dollars, na.rm = TRUE))

