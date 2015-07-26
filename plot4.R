# plot4.R

library(ggplot2)

# Across the United States,
# how have emissions from coal combustion-related sources changed from 1999–2008?
#
# plot4
#   argument:   [path] - data set path (ex: /work/Exploratory-Data-Analysis/data)
#   return:     - aggregate data

plot4 <- function(path) {
    # backup and replace working dir
    backup_wd <- getwd()
    setwd(path)

    ## This first line will likely take a few seconds. Be patient!
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")

    # merge and retrive emissions from coal
    NEISCC <- merge(NEI, SCC, by="SCC")
    retrivecoal  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
    NEISCC <- NEISCC[retrivecoal, ]

    ret <- aggregate(Emissions ~ year, NEISCC, sum)

    png("plot4.png", width=640, height=480)
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
