context( "dup.pivot: data.table" )

dt <- data.table( 
     customer = sort( letters[ c(1:4,1:4,1:4) ] )
   , date     = 1:3
   , income   = round(rnorm(12,10) * 10) 
   , expense  = -round( rnorm(12,10) )
   , count    = 1
)

dt <- rbind(dt, dt[c(1,1,2),] )

dt <- dt[ -(10:11), ]
setDT(dt)

# dt[ 8, income := NA]
setkey( dt, customer, date )

dt. <- dup.pivot( dt, "customer", "date" )


# NAMES
  expect_identical( 
    names(dt.), 
    c("customer", "count_1", "count_2", "count_3", "expense_1", "expense_2", "expense_3", "income_1", "income_2", "income_3") 
  )
