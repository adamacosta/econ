library(dplyr)
library(lubridate)

inFiles <- c('nsror.csv',
             'nsrorManufacturing.csv',
             'nsrorMining.csv',
             'nsrorProfServices.csv',
             'nsrorRetail.csv')

nsror <- read.csv(file.path('data-raw', 'raw', inFiles[1])) %>%
    rename(period = Period, total = Value) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[2])) %>%
            rename(period = Period, manufacturing = Value)
    ) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[3])) %>%
            rename(period = Period, mining = Value)
    ) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[4])) %>%
            rename(period = Period, profServices = Value)
    ) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[5])) %>%
            rename(period = Period, retail = Value)
    )

nsror$period <- sub('Q1-', 'Jan-1-', nsror$period)
nsror$period <- sub('Q2-', 'Apr-1-', nsror$period)
nsror$period <- sub('Q3-', 'Jul-1-', nsror$period)
nsror$period <- sub('Q4-', 'Oct-1-', nsror$period)

nsror <- nsror %>%
    mutate(period = mdy(period)) %>%
    tbl_df()

save(nsror, file = file.path('data', 'nsror.rda'))
