#' Remove duplicate records
#' 
#' Remove duplicate records according to a \code{dup.action}, preserving 
#' attributes if they exist.  
#'  
#' @param x object from which to remove duplicates
#' @param dup.action function used to remove duplicates
#' @param ... additional arguments passed to \code{dup.action}
#' 
#' \code{dedup} is an S3 generic. It is designed to be a smart version of the
#' \code{dup.*} that select actions based on context. 
#' 
#' \code{dedup} for data objects searches for a \code{dup.action} as an 
#' attribute to \code{x} or in \code{options()} if not specified.
#' 
#' Since \code{dedup} is supposed to remove any duplicate records, it issues an
#' error if \code{dup.action} has left any duplicate records.
#' 
#' @return a subset of \code{x} with duplicate records removed
#' 
#' @author Christopher Brown
#' @examples
#'   x <- data.frame( a=rep(1:2,5), b=1 )
#'   dedup.data.frame(x)
#'   dedup( x, dup.action=dup.first )
#' @export

dedup <- function(x, dup.action, ... ) UseMethod( 'dedup' )


#' @rdname dedup
#' @method dedup data.frame
#' @export

dedup.data.frame <- function( 
    x
  , dup.action = 
       if( ! is.null( attr(x, 'dup.action' ) ) ) attr(x, 'dup.action' ) else   # stored in x
       if( ! is.null( getOption('dup.action' ) ) ) options('dup.action') else    # global   
       stop( 'No dup.action was found or specified for deduping the data frame.' )
  , ...
 ) {
  
  
  
  # DUP.ACTION
  
  if( any( duplicated(x) ) )
    if( ! is.null( dup.action ) ) { 
      x <- dup.action(x, ...)      
    } else {
      stop( "Duplicates detected in x with no dup.action" )
    }
 
  # CHECK FOR DUPLICATES
  #   Since dedup is not supposed to leave any duplicates we will raise an error
  #   if any exist.
  if( any( duplicated(x)) )
    stop( "dup.action did not eliminate all the duplicates" )
  
  return(x)
  
}


# ifnullelse <- function( yes, no )
#  if( is.null(yes) ) yes else 
  