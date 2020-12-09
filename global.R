library(tidyverse)


# factors
levelstreatment =  c('standard.yoked' , 'standard.trained' ,
                     'conflict.yoked' ,  'conflict.trained' )
levelstreatmentlegend = c('standard yoked' , 'standard trained' ,
                          'conflict yoked' ,  'conflict trained' )
levelstraining = c("yoked", "trained")
levelssubfield = c("DG", "CA3", "CA1")


# colors
treatmentcolors <- c( "standard.yoked" = "#404040", 
                      "standard.trained" = "#ca0020",
                      "conflict.yoked" = "#969696",
                      "conflict.trained" = "#f4a582")

colorvalsubfield <- c("DG" = "#d95f02", 
                      "CA3" = "#1b9e77", 
                      "CA1" = "#7570b3")

trainingcolors <-  c("trained" = "darkred", 
                     "yoked" = "black")

allcolors <- c(treatmentcolors, 
               colorvalsubfield, 
               trainingcolors,
               "NS" = "#d9d9d9")


# table 1
table1 <- read_csv("www/table-1.csv")

# supp table 1
sup1 <- read_csv(file = "www/suppltable-1.csv") %>%
  mutate(treatment = factor(treatment, levels = levelstreatment)) 
# supp table 2
sup2 <- read_csv(file = "www/suppltable-2.csv")

# supp table 3
sup3 <- read_csv("www/suppltable-3.csv") %>%
  left_join(sup1) %>%
  filter(trial == "Retention") %>%
  mutate(treatment = factor(treatment, levelstreatment),
         treatment2 = fct_collapse(treatment,
                                   "trained" = c("conflict.trained",
                                                 "standard.trained"),
                                   "yoked" = c("conflict.yoked",
                                               "standard.yoked")))
  

# input variables for behavioral estimates
behaviors <- sup1 %>%
  select(TotalPath:ShockPerEntrance) %>%
  select(MaxTimeAvoid, everything()) %>%
  select(MaxTimeAvoid:ShockPerEntrance)  