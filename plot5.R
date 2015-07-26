# plot5.R

library(ggplot2)

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
#
# plot5
#   argument:   [path] - data set path (ex: /work/Exploratory-Data-Analysis/data)
#   return:     - aggregate data

plot5 <- function(path) {
    # backup and replace working dir
    backup_wd <- getwd()
    setwd(path)

    ## This first line will likely take a few seconds. Be patient!
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")

    NEI <- NEI[NEI$fips == "24510" & NEI$type=="ON-ROAD", ]
    ret <- aggregate(Emissions ~ year, NEI, sum)

    png("plot5.png", width=640, height=480)
    g <- ggplot(ret, aes(factor(year), Emissions))
    g <- g +
        geom_bar(stat="identity") +
        xlab("year") +
        ylab("Total PM2.5 Emissions")
    print(g)
    dev.off()

    # restore working dir
    setwd(backup_wd)

    return(ret)
}
