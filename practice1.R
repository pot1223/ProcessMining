install.packages('bupaR')
install.packages('edeaR')
install.packages('processmapR')
install.packages('eventdataR')
install.packages('readr')
install.packages('tidyverse')
install.packages('DiagrammeR')
install.packages('stringr')
install.packages('lubridate')


library(bupaR)
library(edeaR)
library(processmapR)
library(eventdataR)
library(readr)
library(tidyverse)
library(DiagrammeR)
library(stringr)
library(lubridate)

data = readr::read_csv('data/processtest.csv')

sample_events = data %>% dplyr::rename(start = Time) %>% 
  convert_timestamps(columns =c("start"), format = ymd_hm) %>%
  activitylog(case_id = "TicketNum",
              activity_id = "Status",
              resource_id = "TicketNum",
              timestamps = c("start"))


sample_events %>%
  filter_activity_frequency(percentage = 1.0) %>% # 가장 빈번한 Activity를 보여줌 (ex - 0.9 : 전체의 90% Activity를 표시)
  filter_trace_frequency(percentage = .9) %>% # 가장 빈번한 Variants를 보여줌 (ex - 0.9 : 전체의 90%의 Variants를 표시)
  process_map(frequency("relative-consequent")) # 방법


sample_events %>%   
  trace_explorer(n_traces = 6, abbreviate = FALSE) # 전체 Variants중 상위 3개만 확인
