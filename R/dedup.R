#' Remove duplicate records
#' 
#' Remoce duplicate records preserving attributes if they exist  
#'  
#' @param x object from which to remove duplicates
#' @param dup.action function used to remove duplicates
#' @param ... additional arguments passed to \code{dup.action}
#' 
#' \code{dedup} is an S3 generic. It is designed to be a smart version of the
#' \code{dup.*} that select actions based on context.
#' 
#' 
#' 
#' @return a subset of \code{x} with duplicate records removed
#' 
#' 
#' 
#' @author Christopher Brown
#' @examples
#'   x <- data.frame( a=rep(1:2,5), b=1 )
#'   dedup(x)
#' @export

dedup <- function(x, dup.action, ... ) UseMethod( 'dedup' )


#' @rdname dedup
#' @method dedup data.frame
#' @export

dedup.data.frame <- function( 
    x
  , dup.action = 
       if( ! is.null( attr(x, "dup.action" ) ) ) attr(x, "dup.action" ) else 
       if( ! is.null( options('dup.action' ) ) ) options('dup.action') else 
       NULL
  , ...
 ) {
  
  # DUP.ACTION
  
  if( any( duplicated(x) ) )
    if( ! is.null( dup.action ) ) { 
      x <- dup.action(x, ...)      
    } else {
      stop( "Duplicates detected in x with no dup.action" )
    }
 
  if( any( duplicated(x)) )
    stop( "dup.action did not eliminate all the duplicates" )
  
  return(x)
  
}


# ifnullelse <- function( yes, no )
#  if( is.null(yes) ) yes else 
  