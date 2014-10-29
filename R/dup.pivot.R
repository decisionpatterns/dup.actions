#' dup.pivot
#' 
#' Remove duplicates by pivoting data from long to wide format, thus reducing 
#' duplications in repeated measure of one or more variables.
#' 
#' @param object usually a data.table or data frame to pivot from 
#'   wide-to-long format
#' @param id.vars character; names(s) of id variables
#' @param vary character; name(s) of 'varying' variables, i.e. those to be 
#' pivoted into the wide position.
#' @param ... additional arguments passed to \code{melt} or \code{cast}
#' @param fun.aggregate function used to aggregate duplicate cell (default=sum)
#' 
#' @seealso \code{\link{dup.action}}
#' 
#' @examples
#' 
#'   require(data.table)
#'   y <- data.table( 
#'        customer = sort( letters[ c(1:4,1:4,1:4) ] )
#'      , date     = 1:3
#'      , income   = round(rnorm(12,10) * 10) 
#'      , expense  = -round( rnorm(12,10) )
#'      , count    = 1
#'   )
#' 
#'   y <- rbind(y, y[c(1,1,2),] )
#'   y <- y[ -(10:11), ]
#'   y[ 8, income := NA]
#'   setkey( y, customer, date )
#' 
#'   dup.pivot( y, "customer", "date" )
#' 
#' @import formula.tools reshape2
#' @export

dup.pivot <- function( object, id.vars, vary, ..., fun.aggregate=sum ) {  # na.rm=FALSE, variable.factor=FALSE, fill=NA, 
    
  # if( noneDuplicated(object) ) return(object)  # performance enhancement
  
#   require( reshape2, quietly=TRUE )
#   require( formula.tools, quietly = TRUE )
  # Melt 
  # id.vars : matching columns 
  # measure.vars :
  object.me <- melt( 
      data = object 
    , na.rm = FALSE 
    , id.vars = c(id.vars, vary ), #release_dt, release_wk,  measure_wk, W), 
    , variable.factor = FALSE
    # , measure.vars = measre.vars
  )
    
  #' LHS := key.x_1 + key.x_2 + ...  
  #' RHS := 
  form <- LHS ~ RHS 
  
  lhs( form ) <- 
    parse( text=paste( id.vars, collapse="+" ) )[[1]] 
  
  rhs( form ) <-  
    parse( text=paste( c( 'variable', vary ), collapse="+" ) )[[1]]
    
  
  # DUPLICATES.
  #  DUPLICATES ARE AUTOMATICALLY HANDLED BY THE 
  object. <-  dcast.data.table( object.me, form, fun.aggregate=fun.aggregate ) 
  
  return(object.)
  
}
