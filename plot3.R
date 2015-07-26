# plot3.R

library(ggplot2)

# Of the four types of sources indicated by the type
# (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions
# from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.
#
# plot3
#   argument:   [path] - data set path (ex: /work/Exploratory-Data-Analysis/data)
#   return:     - aggregate data

plot3 <- function(path) {
    # backup and replace working dir
    backup_wd <- getwd()
    setwd(path)

    ## This first line will likely take a few seconds. Be patient!
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    NEI <- NEI[NEI$fips == "24510", ]

    ret <- aggregate(Emissions ~ year + type, NEI, sum)

    png("plot3.png", width=640, height=480)
    g <- ggplot(ret, aes(year, Emissions, color = type))
    g <- g +
        geom_line() +
        xlab("year") +
        ylab("Total PM2.5 Emissions")
    print(g)
    dev.off()

    # restore working dir
    setwd(backup_wd)

    return(ret)
}
