library(testthat)

y <- data.table( 
     customer = sort( letters[ c(1:4,1:4,1:4) ] )
   , date     = 1:3
   , income   = round(rnorm(12,10) * 10) 
   , expense  = -round( rnorm(12,10) )
   , count    = 1
)

y <- rbind(y, y[c(1,1,2),] )
y <- y[ -(10:11), ]
y[ 8, income := NA]
setkey( y, customer, date )

y. <- dup.pivot( y, "customer", "date" )

expect_identical( 
  names(y.), 
  c("customer", "count_1", "count_2", "count_3", "expense_1", "expense_2", "expense_3", "income_1", "income_2", "income_3") 
)
