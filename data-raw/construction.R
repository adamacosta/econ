library(dplyr)
library(lubridate)

inFiles <- c('homesManufactured.csv',
             'housingPermits.csv',
             'housingStarts.csv',
             'newHomeSales.csv')

construction <- read.csv(file.path('data-raw', 'raw', inFiles[1])) %>%
    rename(period = Period, homesManufactured = Value) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[2])) %>%
            rename(period = Period, housingPermits = Value)
    ) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[3])) %>%
            rename(period = Period, housingStarts = Value)
    ) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[4])) %>%
            rename(period = Period, newHomeSales = Value)
    )

construction$period <- sub('-', '-1-', construction$period)

construction <- construction %>%
    mutate(period = mdy(period))

save(construction, file = file.path('data', 'construction.rda'))
