

###### R script to read in the IDs from the BMX and accel data and produce sample indicator #########


setwd("~/Bristol Uni/AHDS/Week 3/formative_assessment/data/derived")

# read in BMX IDs
bmx_id <- read.csv("BMX_ID.csv",
                   header = TRUE)

# check format
bmx_id %>% head()

# Read in accel IDs
accel_id <- read.csv("accel_list.csv", header = FALSE)

# Rename the column to coincide with BMX
accel_id <- accel_id %>% rename(SEQN = V1) 


# assign BMX flag for BMX group
bmx_id <- bmx_id %>% mutate(bmx_flag = 1)

# assign accel flag for other group
accel_id <- accel_id %>% mutate(accel_flag = 1)

head(bmx_id)
head(accel_id)

# produce union of two lists, by ID:
combined_list <- 
  full_join(x = accel_id,
            y = bmx_id,
            by = "SEQN")

# search for IDs with both flags and create a sample flag
combined_list <- combined_list %>%
  mutate(sample_flag = ifelse((bmx_flag == 1 & accel_flag == 1), 1, 0)) %>% 
  dplyr::select(SEQN, sample_flag)


combined_list %>% head()

# output the sample list:
write.csv(combined_list, file = "~/Bristol Uni/AHDS/Week 3/formative_assessment/data/derived/sample_IDs.csv")

