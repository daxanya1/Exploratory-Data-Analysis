# plot1.R

# Have total emissions from PM2.5 decreased in the United States
# from 1999 to 2008? Using the base plotting system,
# make a plot showing the total PM2.5 emission from all sources
# for each of the years 1999, 2002, 2005, and 2008.
#
# plot1
#   argument:   [path] - data set path (ex: /work/Exploratory-Data-Analysis/data)
#   return:     - aggregate data

plot1 <- function(path) {
    # backup and replace working dir
    backup_wd <- getwd()
    setwd(path)

    ## This first line will likely take a few seconds. Be patient!
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")

    ret <- aggregate(Emissions ~ year, NEI, sum)

    png('plot1.png')
    barplot(    height=ret$Emissions,
                names.arg=ret$year,
                xlab="years",
                ylab=expression('total PM2.5 emission'))
    dev.off()

    # restore working dir
    setwd(backup_wd)

    return(ret)
}
