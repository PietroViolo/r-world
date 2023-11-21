#---------------------------------------------------------------------------#
# Nom : world-r.R                                                           #
# Description : Plots r value for various countries over time               #
# Auteur : Pietro Violo                                                     #
# Date : Nov 21 2023                                                        #
# Modifications :                                                           #
#---------------------------------------------------------------------------#
options(scipen=999)
rm(list = ls())

# Library
library(tidyverse)

###############################################################################
# Import and data wrangling
###############################################################################



         
#ggsave(plot = combined_plot,
#       filename = "./Outputs/distribution_combined.png",
#       height = 2600, width =3000, units = "px", dpi = 500,
#       device = "png",limitsize = FALSE,bg="white")
