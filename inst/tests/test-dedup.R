library(testthat)

x <- data.frame( a=rep(1:2,5), b=1 )

# THESE dup.actions REMOVE DUPLICATE
  for( fn in c( dup.first, dup.last, dup.omit ) ) 
    expect_false( any( duplicated( dedup(x, fn ) ) ) )

# THESE dup.actions DO NOT REMOVE DUPLICATE. SO dedup SHOULD PRODUCE AN ERROR
  for( fn in c( dup.pass ) ) 
    expect_error( any( duplicated( dedup(x, fn ) ) ) )
