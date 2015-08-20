library(dplyr)
library(lubridate)

inFiles <- c('balancePayments.csv',
             'durableGoodsSales.csv',
             'durableGoodsInventories.csv',
             'manufacturersInventories.csv',
             'manufacturersNewOrders.csv',
             'manufacturersShipments.csv',
             'nondurableGoodsInventories.csv',
             'nondurableGoodsSales.csv',
             'retailFoodAdvanceSales.csv',
             'retailFoodSales.csv',
             'totalBusinessInventories.csv',
             'totalBusinessSales.csv')

salesinventories <- read.csv(file.path('data-raw', 'raw', inFiles[1])) %>%
    rename(period = Period, balancePayments = Value) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[2])) %>%
            rename(period = Period, durableGoodsSales = Value)
    ) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[3])) %>%
            rename(period = Period, durableGoodsInventories = Value)
    ) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[4])) %>%
            rename(period = Period, manufacturersInventories = Value)
    ) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[5])) %>%
            rename(period = Period, manufacturersNewOrders = Value)
    ) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[6])) %>%
            rename(period = Period, manufacturersShipments = Value)
    ) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[7])) %>%
            rename(period = Period, nondurableGoodsInventories = Value)
    ) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[8])) %>%
            rename(period = Period, nondurableGoodsSales = Value)
    ) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[9])) %>%
            rename(period = Period, retailFoodAdvanceSales = Value)
    ) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[10])) %>%
            rename(period = Period, retailFoodSales = Value)
    ) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[11])) %>%
            rename(period = Period, totalBusinessInventories = Value)
    ) %>%
    left_join(
        read.csv(file.path('data-raw', 'raw', inFiles[12])) %>%
            rename(period = Period, totalBusinessSales = Value)
    )

salesinventories$period <- sub('-', '-1-', salesinventories$period)

salesinventories <- salesinventories %>%
    mutate(period = mdy(period)) %>%
    tbl_df()

save(salesinventories, file = file.path('data', 'salesinventories.rda'))
