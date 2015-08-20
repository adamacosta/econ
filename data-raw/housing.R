library(dplyr)
library(lubridate)

inFiles <- c('homeOwnershipRate.csv',
             'homeownerVacancy.csv',
             'rentalVacancies.csv')

housing <- read.csv(file.path('data-raw', 'raw', inFiles[1])) %>%
    rename(period = Period, homeownership = Value) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[2])) %>%
            rename(period = Period, ownerVacancy = Value)
    ) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[3])) %>%
            rename(period = Period, rentalVacancy = Value)
    )

housing$period <- sub('Q1-', 'Jan-1-', housing$period)
housing$period <- sub('Q2-', 'Apr-1-', housing$period)
housing$period <- sub('Q3-', 'Jul-1-', housing$period)
housing$period <- sub('Q4-', 'Oct-1-', housing$period)

housing <- housing %>%
    mutate(period = mdy(period))

save(housing, file = file.path('data', 'housing.rda'))
