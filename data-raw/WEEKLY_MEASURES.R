library(MotrpacRatTrainingPhysiologyData)
library(dplyr)
library(tidyr)

PHYSIO <- get0("PHYSIO",
               envir = asNamespace("MotrpacRatTrainingPhysiologyData"))

WEEKLY_MEASURES <- PHYSIO %>%
  dplyr::select(pid, iowa_id, omics_analysis,
                sex, group, age, starts_with("day")) %>%
  # For the 4W training group only, week 4 will be the day 20 lactate (end of
  # week 4)
  mutate(day16_posttrainlact = ifelse(group == "4W", day20_posttrainlact,
                                     day16_posttrainlact)) %>%
  pivot_longer(cols = starts_with("day"),
               names_to = c("day", ".value"),
               names_pattern = "day(\\d+)_(.*)") %>%
  dplyr::rename(lactate = posttrainlact) %>%
  mutate(day = as.numeric(day),
         week = ceiling(day / 5),
         week_time = ifelse(day %% 5 == 1, "start", "end"),
         week_time = factor(week_time, levels = c("start", "end"))) %>%
  relocate(week, week_time, .after = day) %>%
  filter(!(is.na(body_mass) & is.na(lactate))) %>%
  arrange(age, sex, group, day, pid)

usethis::use_data(WEEKLY_MEASURES, internal = FALSE, overwrite = TRUE,
                  compress = "bzip2", version = 3)
