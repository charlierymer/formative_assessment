



############## Week 5 formative R script #############


##### Section 1 - Load demographics data

# set wd:
setwd(this.dir())

# load NHANES data:
demog_raw <- read_xpt("data/original/DEMO_D.XPT")

demog <- demog_raw %>%
  janitor::clean_names() %>%
  select(seqn, riagendr, ridageyr, ridreth1)


##### Section 2 - Merge demographics data

# read in bmx data:
BMX_raw <- read.csv("data/original/BMX_D.csv")

BMX <- BMX_raw %>%
  janitor::clean_names() %>% 
  select(-x)

# merge bmx with demog data, keeping demog info at the start
demog_bmx <- left_join(BMX,
                       demog,
                       by = 'seqn') %>%
  relocate(riagendr:ridreth1,
           .after = seqn)


##### # Section 3 - Merge sample information

# read in sample data:
sample_raw <- read.csv("data/derived/sample_IDs.csv")

sample <- sample_raw %>%
  janitor::clean_names() %>%
  select(-x)

sample_demog <- left_join(demog_bmx,
                          sample,
                          by = 'seqn') %>%
  rename(in_sample = sample_flag) %>%
  relocate(in_sample, .after = 'seqn') %>%
  mutate(in_sample = ifelse(is.na(in_sample), 0, 1))


##### # Section 4 - Create obesity variable
sample_demog <- sample_demog %>%
  mutate(obesity = ifelse(bmxbmi < 30, 0, 1))


##### # Section 5 - Summarise the data


# obese patients with AMD:

obese_amd <- sample_demog %>% 
  filter(!is.na(obesity)) %>%
  group_by(obesity, in_sample) %>%
  summarise(count = n()) %>%
  ungroup(in_sample) %>%
  reframe(in_sample = in_sample, 
          percent = count / sum(count) * 100)


paste0("Within obese patients in the body measurement sample, ", 
       round(obese_amd$percent[4], 2), 
       "% have activity monitor data, and ",
       round(obese_amd$percent[3], 2),
       "% do not.")

paste0("Within non-obese patients in the body measurement sample, ", 
       round(obese_amd$percent[2], 2), 
       "% have activity monitor data, and ",
       round(obese_amd$percent[1], 2),
       "% do not.")




# % of males have AMD

AMD_dat <- sample_demog %>%
  group_by(riagendr, in_sample) %>%
  summarise(count = n()) %>%
  ungroup(in_sample) %>%
  reframe(in_sample = in_sample, 
          percent = count / sum(count) * 100)

paste("Within male patients, ",
      round(AMD_dat[AMD_dat$riagendr==1 & AMD_dat$in_sample==1, ]$percent, 2),
      "% had activity monitor data, compared to ",
      round(AMD_dat[AMD_dat$riagendr==2 & AMD_dat$in_sample==1, ]$percent, 2),
      "% of femaleS")
      

# max height in cm of child under 16 in sample:
max_height <- sample_demog %>% 
  filter(ridageyr < 16) %>% 
  arrange(desc(bmxht)) %>%
  head(1) %>%
  pull(bmxht)

paste0("The maximum height in cm for a child under 16 is: ", max_height, "cm")


##### # Section 6 - Export the data

# save combined data to body_measurements.csv
write_csv(sample_demog, 
          file = "data/derived/body_measurements.csv")












