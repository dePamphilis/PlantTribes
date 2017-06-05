#!/usr/bin/env Rscript

suppressPackageStartupMessages(library("optparse"))

option_list <- list(
    make_option(c("-c", "--components_input"), action="store", dest="components_input", help="Ks significant components input dataset"),
    make_option(c("-k", "--kaks_input"), action="store", dest="kaks_input", help="KaKs analysis input dataset"),
    make_option(c("-o", "--output"), action="store", dest="output", help="Output dataset")
)

parser <- OptionParser(usage="%prog [options] file", option_list=option_list)
args <- parse_args(parser, positional_arguments=TRUE)
opt <- args$options


get_num_components = function(components_data)
{
    # Get the max of the number_comp column.
    number_comp = components_data[, 3]
    num_components <- max(number_comp, na.rm=TRUE)
    return(num_components)
}

get_pi_mu_var = function(components_data, num_components)
{
    # FixMe: enhance this to generically handle any integer value for num_components.
    if (num_components == 1)
    {
        pi <- c(components_data[1, 9])
        mu <- c(components_data[1, 7])
        var <- c(components_data[1, 8])
    }
    else if (num_components == 2)
    {
        pi <- c(components_data[2, 9], components_data[3, 9])
        mu <- c(components_data[2, 7], components_data[3, 7])
        var <- c(components_data[2, 8], components_data[3, 8])
    }
    else if (num_components == 3)
    {
      pi <- c(components_data[4, 9], components_data[5, 9], components_data[6, 9])
      mu <- c(components_data[4, 7], components_data[5, 7], components_data[6, 7])
      var <- c(components_data[4, 8], components_data[5, 8], components_data[6, 8])
    }
    else if (num_components == 4)
    {
        pi <- c(components_data[7, 9], components_data[8, 9], components_data[9, 9], components_data[10, 9])
        mu <- c(components_data[7, 7], components_data[8, 7], components_data[9, 7], components_data[10, 7])
        var <- c(components_data[7, 8], components_data[8, 8], components_data[9, 8], components_data[10, 8])
    }
    else if (num_components == 5)
    {
        pi <- c(components_data[11, 9], components_data[12, 9], components_data[13, 9], components_data[14, 9], components_data[15, 9])
        mu <- c(components_data[11, 7], components_data[12, 7], components_data[13, 7], components_data[14, 7], components_data[15, 7])
        var <- c(components_data[11, 8], components_data[12, 8], components_data[13, 8], components_data[14, 8], components_data[15, 8])
    }
    else if (num_components == 6)
    {
        pi <- c(components_data[16, 9], components_data[17, 9], components_data[18, 9], components_data[19, 9], components_data[20, 9], components_data[21, 9])
        mu <- c(components_data[16, 7], components_data[17, 7], components_data[18, 7], components_data[19, 7], components_data[20, 7], components_data[21, 7])
        var <- c(components_data[16, 8], components_data[17, 8], components_data[18, 8], components_data[19, 8], components_data[20, 8], components_data[21, 8])
    }            
    results = c(pi, mu, var)
    return(results)
}

plot_ks<-function(kaks_input, output, pi, mu, var)
{
    # Start PDF device driver to save charts to output.
    pdf(file=output, bg="white")
    kaks <- read.table(file=kaks_input, header=T)
    max_ks <- max(kaks$Ks, na.rm=TRUE)
    # Change bin width
    max_bin_range <- as.integer(max_ks / 0.05)
    bin <- 0.05 * seq(0, (max_bin_range + 1 ))
    kaks <- kaks[kaks$Ks<max_ks,]
    h.kst <- hist(kaks$Ks, breaks=bin, plot=F)
    nc <- h.kst$counts
    vx <- h.kst$mids
    ntot <- sum(nc)
    # Set margin for plot bottom, left top, right.
    par(mai=c(0.5, 0.5, 0, 0))
    # Plot dimension in inches.
    par(pin=c(3.0, 3.0))
    g <- calculate_fitted_density(pi, mu, var, max_ks)
    h <- ntot * 1.5 / sum(g)
    vx <- seq(1, 100) * (max_ks / 100)
    ymax <- max(nc) 
    barplot(nc, space=0.25, offset=0, width=0.04, xlim=c(0, max_ks), ylim=c(0, ymax), col="lightpink1", border="lightpink3")
    # Add x-axis.
    axis(1) 
    color <- c('red', 'yellow','green','black','blue', 'darkorange' )
    for (i in 1:length(mu))
    {
       lines(vx, g[,i] * h, lwd=2, col=color[i])
    }
}

calculate_fitted_density <- function(pi, mu, var, max_ks)
{
    comp <- length(pi)
    var <- var/mu^2
    mu <- log(mu)
    # Calculate lognormal density.
    vx <- seq(1, 100) * (max_ks / 100)
    fx <- matrix(0, 100, comp)
    for (i in 1:100)
    {
        for (j in 1:comp)
        {
           fx[i, j] <- pi[j] * dlnorm(vx[i], meanlog=mu[j], sdlog=(sqrt(var[j])))
           if (is.nan(fx[i,j])) fx[i,j]<-0
        }
     }
    return(fx)
}

# Read in the components data.
components_data <- read.delim(opt$components_input, header=TRUE)
# Get the number of components.
num_components <- get_num_components(components_data)

# Set pi, mu, var.
items <- get_pi_mu_var(components_data, num_components)
if (num_components == 1)
{
	pi <- items[1]
	mu <- items[2]
	var <- items[3]	
}
if (num_components == 2)
{
	pi <- items[1:2]
	mu <- items[3:4]
	var <- items[5:6]
}
if (num_components == 3)
{
	pi <- items[1:3]
	mu <- items[4:6]
	var <- items[7:9]
}
if (num_components == 4)
{
	pi <- items[1:4]
	mu <- items[5:8]
	var <- items[9:12]
}
if (num_components == 5)
{
	pi <- items[1:5]
	mu <- items[6:10]
	var <- items[11:15]
}
if (num_components == 6)
{
	pi <- items[1:6]
	mu <- items[7:12]
	var <- items[13:18]
}

# Plot the output.
plot_ks(opt$kaks_input, opt$output, pi, mu, var)