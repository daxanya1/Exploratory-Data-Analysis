# plot6.R

library(ggplot2)

# Compare emissions from motor vehicle sources in Baltimore City
# with emissions from motor vehicle sources in Los Angeles County,
# California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?
#
# plot6
#   argument:   [path] - data set path (ex: /work/Exploratory-Data-Analysis/data)
#   return:     - aggregate data

plot6 <- function(path) {
    # backup and replace working dir
    backup_wd <- getwd()
    setwd(path)

    ## This first line will likely take a few seconds. Be patient!
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")

    NEI <- NEI[(NEI$fips=="24510" | NEI$fips=="06037") & NEI$type=="ON-ROAD", ]
    ret <- aggregate(Emissions ~ year + fips, NEI, sum)
    ret$fips[ret$fips=="24510"] <- "Baltimore"
    ret$fips[ret$fips=="06037"] <- "Los Angeles"

    png("plot6.png", width=640, height=480)
    g <- ggplot(ret, aes(factor(year), Emissions))
    g <- g +
        facet_grid(. ~ fips) +
        geom_bar(stat="identity") +
        xlab("year") +
        ylab("Total PM2.5 Emissions")
    print(g)
    dev.off()

    # restore working dir
    setwd(backup_wd)

    return(ret)
}
