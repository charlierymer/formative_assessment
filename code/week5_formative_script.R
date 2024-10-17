

####### AHDS Week 5 Formative Assessment ############

# libraries
library(this.path)
library(tidyverse)
library(haven)

# set directory
setwd(this.dir())


# read data
demo_raw <- read_xpt("DEMO_D.XPT")


#### Section 1 #########

demog <- tibble(demo_raw) %>%
  select(SEQN,
         RIAGENDR,
         RIDAGEYR,
         RIDRETH1) %>%
  janitor::clean_names()

# ethnicity: 
# 1: mexican american
# 2: hispanice
# 3: non-hispanic white
# 4: non-hispanic black
# 5: non-hispanic multicultural

# part ID, gender, age, ethnicity


####### Section 2 ############

# read in BMX data:
setwd(this.dir())
setwd('..')

BMX_raw <- read.csv("data/original/BMX_D.csv")

setwd(this.dir())

# data formatting
BMX <- BMX_raw %>% 
  janitor::clean_names() %>%
  dplyr::select(-x)

BMX %>% head()


# merge with demog data
# keep rows from BMX data:
merged <- left_join(BMX, 
                    demog,
                    by = 'seqn')

merged %>% head()


# move demographics to LHS, right of ID:
merged <- merged %>% 
  relocate(riagendr:ridreth1, .after = seqn)



### Section 3: Merge sample information #########

# read in sample records:
sample_raw <- read.csv("~/Bristol Uni/AHDS/Week 3/formative_assessment/data/derived/sample_IDs.csv")

# data formatting
sample <- sample_raw %>% 
  janitor::clean_names() %>%
  dplyr::select(-x)

# merge with data frame, keeping sample flag to the right of ID:

sample_data <- left_join(merged, 
                         sample,
                         by = 'seqn') %>%
  relocate(sample_flag,
           .after = seqn) %>%
  rename(in_sample = sample_flag) %>%
  mutate(in_sample = if_else(is.na(in_sample), 0, in_sample))

# 9950 rows


####### Section 4 ##########

# Create an obesity variable

sample_data <- sample_data %>% 
  # if BMI < 30 then obesity = 0, else obestiy = 1
  mutate(obesity = ifelse(bmxbmi < 30, 0 , 1))


######## Section 5 ###############

# % of people in BMX sample who are obese & have acitivty monitor data?
# compare this to those not obese

# % of males who have act. monitor data? 
# compare this to females

# max reported heigh in cm of child under 16 in sample:








############ Section 6 #################

# Export the data:














