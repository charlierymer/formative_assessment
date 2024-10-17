



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
  janitor::clean_names()

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

# obesity groups
sample_demog %>%
  group_by(obesity) %>%
  summarise(count = n(),
            prop = count/nrow(sample_demog))

# those who are obese with activity monitor data:
sample_demog %>%
  group_by(obesity, in_sample) %>%
  summarise(count = n(),
            prop = count/nrow(sample_demog))


# % of males have AMD
sample_demog %>% 
  filter(riagendr == 2) %>%
  group_by(in_sample) %>%
  summarise(n = n())

sample_demog %>% 
  filter(riagendr == 1) %>%
  group_by(in_sample) %>%
  summarise(n = n(),
            percent = (n/nrow()) * 100)

##### # Section 6 - Export the data














