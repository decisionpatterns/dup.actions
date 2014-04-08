#' dup.pivot
#' 
#' Remove duplicates by pivoting data from long to wide format, thus reducing 
#' duplications in repeated measure of one or more variables.
#' 
#' @param data
#' @param id.vars character; names(s) of id variables
#' @param varying.vars character; name(s) of variables to be pivoted into the 
#' wide position.
#' @param ... additional arguments passed to \code{melt} or \code{cast}
#' 
#' @seealso \code{\link{dup.action}}
#' 
#' @examples
#' y <- data.table( 
#'      customer = sort( letters[ c(1:4,1:4,1:4) ] )
#'    , time     = 1:3 
#'    , income   = round(rnorm(12,10) * 10) 
#'    , expense  = -round( rnorm(12,10) )
#'    , count    = 1
#' )
#' 
#' y <- rbind(y, y[c(1,1,2),] )
#' y <- y[ -(10:11), ]
#' y[ 8, income := NA]
#' setkey( y, customer, time )
#' 
#' dup.pivot( y, "customer", "time" )
#' 
#' @export

dup.pivot <- function( data, id.vars, varying.vars, ..., fun.aggregate=sum ) {  # na.rm=FALSE, variable.factor=FALSE, fill=NA, 
    
  # if( noneDuplicated(data) ) return(data)
  
  require( reshape2, quietly=TRUE )
  
  # Melt 
  # id.vars : matching columns 
  # measure.vars :
  data.me <- melt( 
      data = data 
    , na.rm = FALSE 
    , id.vars = c(id.vars, varying.vars ), #release_dt, release_wk,  measure_wk, W), 
    , variable.factor = FALSE
    # , measure.vars = measre.vars
  )
    
  #' LHS := key.x_1 + key.x_2 + ...  
  #' RHS := 
  form <- LHS ~ RHS 
  
  lhs( form ) <- 
    parse( text=paste( id.vars, collapse="+" ) )[[1]] 
  
  rhs( form ) <-  
    parse( text=paste( c( 'variable', varying.vars ), collapse="+" ) )[[1]]
    
  
  # DUPLICATES.
  #  DUPLICATES ARE AUTOMATICALLY HANDLED BY THE 
  data. <-  dcast.data.table( data.me, form, fill=NA, fun.aggregate=fun.aggregate ) 
  
  return(data.)
  
}