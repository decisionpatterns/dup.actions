# dup.last

context( "dup.last" )
  x <- c( 1,1,2,2,2,3 )
  names(x) <- letters[1:6]

  ret <- dup.last( x )       # b e f
                             # 1 2 3
  
  expect_equivalent( ret, c( 1,2,3) )
  expect_identical( names(ret), c( 'b','e','f') )

## data.frame

  data(iris)
  expect_equal( nrow(iris), 150 )  
  expect_equal( nrow( dup.last(iris) ), 149 )   
  expect_equal( dup.last(iris), iris[-102,] )  # row 102 - 143 are equal
  
## data.table   
  if( require(data.table) ) {    
    setDT(iris)
    expect_equal( nrow(iris), 150 )             # 150
    expect_equal( nrow(dup.last(iris)), 149 )   # 149
    
    expect_equal( dup.last(iris), iris[-102,])
    
    setkey(iris, Species)
    expect_equal( nrow(dup.last(iris)), 3 )  # 3
  
    expect_equal( dup.last(iris), iris[c(50,100,150),] )
  
  }
