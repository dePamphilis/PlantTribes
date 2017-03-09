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
    num_components <- max(number_comp, na.rm=TRUE);
    num_components
}

get_pi_mu_var = function(components_data, num_components)
{
    # FixMe: enhance this to generically handle any integer value for num_components.
    if (num_components == 1)
    {
        pi <- c(components_data[1, 9]);
        mu <- c(components_data[1, 7]);
        var <- c(components_data[1, 8]);
    }
    else if (num_components == 2)
    {
        pi <- c(components_data[2, 9], components_data[3, 9]);
        mu <- c(components_data[2, 7], components_data[3, 7]);
        var <- c(components_data[2, 8], components_data[3, 8]);
    }
    else if (num_components == 3)
    {
        pi <- c(components_data[4, 9], components_data[5, 9], components_data[6, 9]);
        mu <- c(components_data[4, 7], components_data[5, 7], components_data[6, 7]);
        var <- c(components_data[4, 8], components_data[5, 8], components_data[6, 8]);
    }
    else if (num_components == 4)
    {
        pi <- c(components_data[7, 9], components_data[8, 9], components_data[9, 9], components_data[10, 9]);
        mu <- c(components_data[7, 7], components_data[8, 7], components_data[9, 7], components_data[10, 7]);
        var <- c(components_data[7, 8], components_data[8, 8], components_data[9, 8], components_data[10, 8]);
    }
    return = c(pi, mu, var)
    return
}

plot_ks<-function(kaks_input, output, pi, mu, var)
{
    # Start PDF device driver to save charts to output.
    pdf(file=output, bg="white")
    # Change bin width
    bin <- 0.05 * seq(0, 40);
    kaks <- read.table(file=kaks_input, header=T);
    kaks <- kaks[kaks$Ks<2,];
    h.kst <- hist(kaks$Ks, breaks=bin, plot=F);
    nc <- h.kst$counts;
    vx <- h.kst$mids;
    ntot <- sum(nc);
    # Set margin for plot bottom, left top, right.
    par(mai=c(0.5, 0.5, 0, 0));
    # Plot dimension in inches.
    par(pin=c(2.5, 2.5));
    g <- calculate_fitted_density(pi, mu, var);
    h <- ntot * 2.5 / sum(g);
    vx <- seq(1, 100) * 0.02;
    ymax <- max(nc) + 5;
    barplot(nc, space=0.25, offset=0, width=0.04, xlim=c(0,2), ylim=c(0, ymax));
    # Add x-axis.
    axis(1);
    color <- c('green', 'blue', 'black', 'red');
    for (i in 1:length(mu))
    {
       lines(vx, g[,i] * h, lwd=2, col=color[i]);
    }
};

calculate_fitted_density <- function(pi, mu, var)
{
    comp <- length(pi);
    var <- var/mu^2;
    mu <- log(mu);
    # Calculate lognormal density.
    vx <- seq(1, 100) * 0.02;
    fx <- matrix(0, 100, comp);
    for (i in 1:100)
    {
        for (j in 1:comp)
        {
           fx[i, j] <- pi[j] * dlnorm(vx[i], meanlog=mu[j], sdlog=(sqrt(var[j])));
        };
     };
    fx;
}

# Read in the components data.
components_data <- read.delim(opt$components_input, header=TRUE);
# Get the number of components.
num_components <- get_num_components(components_data)

# Set pi, mu, var.
items <- get_pi_mu_var(components_data, num_components);
pi <- items[1];
mu <- items[2];
var <- items[3];

# Plot the output.
plot_ks(opt$kaks_input, opt$output, pi, mu, var);
