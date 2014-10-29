
context( "dedup: vector")

   x <- c( 1,1,2,2,2,3,4,4 )
   names(x) <- letters[ 1:length(x) ]
   expect_error( dedup(x) )   # error

  # THESE dup.actions REMOVE DUPLICATE
  for( fn in c( dup.first, dup.last, dup.omit ) ) 
    expect_false( any( duplicated( dedup(x, fn ) ) ) )
  
  # THESE dup.actions DO NOT REMOVE DUPLICATE. SO dedup SHOULD PRODUCE AN ERROR
  for( fn in c( dup.pass ) ) 
    expect_true( any( duplicated( dedup(x, fn ) ) ) )

 
context( "dedup: data.frame")

  x <- data.frame( a=rep(1:2,5), b=1 )

  # THESE dup.actions REMOVE DUPLICATE
  for( fn in c( dup.first, dup.last, dup.omit ) ) 
    expect_false( any( duplicated( dedup(x, fn ) ) ) )

  # THESE dup.actions DO NOT REMOVE DUPLICATE. SO dedup SHOULD PRODUCE AN ERROR
  for( fn in c( dup.pass ) ) 
    expect_error( any( duplicated( dedup(x, fn ) ) ) )


context( "dedup: data.table" )

  if( require(data.table) ) { 
    setDT(x)
  
    # THESE dup.actions REMOVE DUPLICATE
    for( fn in c( dup.first, dup.last, dup.omit ) ) 
      expect_false( any( duplicated( dedup(x, fn ) ) ) )
    
    # THESE dup.actions DO NOT REMOVE DUPLICATE. SO dedup SHOULD PRODUCE AN ERROR
    for( fn in c( dup.pass ) ) 
      expect_error( any( duplicated( dedup(x, fn ) ) ) )
    
  }
    