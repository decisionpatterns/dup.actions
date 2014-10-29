#' Remove duplicate elements/records
#' 
#' Remove duplicate elements or records according to a \code{dup.action}, 
#' preserving attributes if they exist.  
#'  
#' @param x object from which to remove duplicates.
#' 
#' @param dup.action function used to remove duplicates. 
#' The \code{dup.action} is taken from the \code{dup.action} attribute of 
#' \code{x} if it exists or the global option (\code{getOption('dup.action')}) 
#' if that exists.  Otherwise the \code{dup.action} must be specified.
#' 
#' @param ... additional arguments passed to \code{dup.action}
#' 
#' \code{dedup} is an S3 generic. It is designed to be a smart version of the
#' \code{dup.*} that select actions based on context. 
#' 
#' Since \code{dedup} is supposed to remove any duplicate records, it issues an
#' error if \code{dup.action} has left any duplicate records.
#' 
#' @return a subset of \code{x} with duplicate records removed
#' 
#' @author Christopher Brown
#' @examples
#'   x <- c( 1,1,2,2,2,3,3)
#'   # edup(x)                              # error 
#'   x <- data.frame( a=rep(1:2,5), b=1 )
#'   dedup( x, dup.action=dup.first )
#'   
#'   \dontrun{ 
#'     setDT(x)
#'     dedup( x, dup.action = dup.first )
#'   }
#' @export

dedup <- function(
    x
  , dup.action 
  , ... 
) UseMethod( 'dedup' )


dedup.default <- function( x
  , dup.action = 
      if( ! is.null( attr(x, "dup.action" ) ) ) attr(x, "dup.action" ) else 
      if( ! is.null( getOption('dup.action' ) ) ) getOption('dup.action') else         
      stop( 'No `dup.action` has been specifed has been specifiied.' )
  , ...
) dup.action(x, ...)


#' @rdname dedup
#' @method dedup data.frame
#' @export

dedup.data.frame <- function( x, dup.action, ... ) {
  
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

