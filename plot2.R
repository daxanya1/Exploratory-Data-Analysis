# plot2.R

# Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system
# to make a plot answering this question.
#
# plot2
#   argument:   [path] - data set path (ex: /work/Exploratory-Data-Analysis/data)
#   return:     - aggregate data

plot2 <- function(path) {
    # backup and replace working dir
    backup_wd <- getwd()
    setwd(path)

    ## This first line will likely take a few seconds. Be patient!
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    NEI <- NEI[NEI$fips == "24510", ]

    ret <- aggregate(Emissions ~ year, NEI, sum)

    png('plot2.png')
    barplot(    height=ret$Emissions,
                names.arg=ret$year,
                xlab="years",
                ylab=expression('total PM2.5 emission in the Baltimore City'))
    dev.off()

    # restore working dir
    setwd(backup_wd)

    return(ret)
}
