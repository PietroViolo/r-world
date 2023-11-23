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
library(ggflags)
library(countrycode)
library(ggthemes)

###############################################################################
# Import and data wrangling
###############################################################################

WPP2022 <- read.csv("./Data/WPP2022_Demographic_Indicators_Medium.csv") %>% 
  filter(LocTypeName == "Country/Area") %>% 
  select(Location,
         ISO2_code,
         Time,
         TPopulationMale1July,
         TPopulationFemale1July) %>% 
  mutate(ISO2_code = tolower(ISO2_code),
         r = case_when(TPopulationMale1July>TPopulationFemale1July ~ (TPopulationMale1July/TPopulationFemale1July - 1)*100,
                       TPopulationFemale1July>TPopulationMale1July ~ -(TPopulationFemale1July/TPopulationMale1July - 1) *100),
         flag = ifelse(Time == 2023, ISO2_code, NA))


###############################################################################
# Top, bottom and G12
###############################################################################

# Top 10

top10 <- (WPP2022 %>% filter(Time == 2022,
                             TPopulationMale1July >= 500) %>% 
            arrange(r) %>% pull(Location) %>% unique())[1:10]

top10

# Bot 10

bot10 <- (WPP2022 %>% filter(Time == 2022,
                             TPopulationMale1July >= 500) %>% 
            arrange(desc(r)) %>% pull(Location) %>% unique())[1:10]
         
bot10

# G12 countries

g12 <- c("CA", "FR", "DE", "IT", "JP", "GB", "US", "RU", "BE", "NL", "SE", "CH") %>% 
  tolower(.)


###############################################################################
# Viz
###############################################################################

# Top 10
x1 <- WPP2022 %>% filter(Location %in% top10) %>% 
  ggplot(aes(x = Time, y = r, color = Location, group = Location, country = flag)) +
  geom_line() +
  scale_x_continuous(limits = c(1950, 2023)) +
  scale_y_continuous(limits = c(-35,10))+
  geom_hline(yintercept = 0, "black") +
  geom_flag() +
  theme_fivethirtyeight() +
  scale_color_manual(values = colors3)
  



# Bot 10
x2 <- WPP2022 %>% filter(Location %in% bot10) %>% 
  ggplot(aes(x = Time, y = r, color = Location, group = Location, country = flag)) +
  geom_line() +
  scale_x_continuous(limits = c(1950, 2023)) +
  scale_y_continuous(limits = c(-10,230)) +
  geom_hline(yintercept = 0, "black") +
  geom_flag() +
  theme_fivethirtyeight() +
  scale_color_manual(values = colors3)




# G12
colors3 <- c("#001219", "#005f73", "#0a9396", "#94d2bd", "#5c677d", "#ee9b00",
             "#ca6702", "#bb3e03", "#d00000", "#ae2012", "#9b2226", "#590d22")

x3 <- WPP2022 %>% filter(ISO2_code %in% g12) %>% 
  ggplot(aes(x = Time, y = r, color = Location, group = Location, country = flag)) +
  geom_line() +
  scale_x_continuous(limits = c(1950, 2023))  +
  scale_y_continuous(limits = c(-30, 10)) +
  geom_hline(yintercept = 0, "black") +
  geom_flag() +
  theme_fivethirtyeight() +
  scale_color_manual(values = colors3)




###############################################################################
# Export
###############################################################################

ggsave(plot = x1,
      filename = "./Outputs/x1.png",
      height = 3000, width =2400, units = "px", dpi = 500,
      device = "png",limitsize = FALSE,bg="white")


ggsave(plot = x2,
       filename = "./Outputs/x2.png",
       height = 3000, width =2400, units = "px", dpi = 500,
       device = "png",limitsize = FALSE,bg="white")

ggsave(plot = x3,
       filename = "./Outputs/x3.png",
       height = 3000, width =2400, units = "px", dpi = 500,
       device = "png",limitsize = FALSE,bg="white")


# Validation
# Cool
x <- WPP2022 %>% filter(ISO2_code %in% g12,
                   Time == 2023)


x2 <- WPP2022 %>% filter(Location %in% top10,
                        Time == 2023)

x3 <- WPP2022 %>% filter(Location %in% bot10,
                         Time == 2023)


