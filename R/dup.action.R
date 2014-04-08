#' dup.action(s0)
#'
#' Actions to apply to duplicate records.
#' 
#' @param x data;
#' @param ... addditional arguments passed to
#'
#' \code{dup.action} is a family of functions similar to \code{na.action} that 
#' provide behaviors for data objects when duplicate records are encountered. 
#' Unlike \code{na.action}, \code{dup.action} generally refers to a record 
#' containing multiple columns, rather than a single vector.
#' 
#' \strong{dup.action}, the default is an alias for \code{identity} and does
#' nothing
#' 
#' \strong{dup.first} removes all duplicates \strong{but the first}.
#' 
#' \strong{dup.last} removes all duplicates \strong{but the last}.
#' 
#' 
#' @return a object with the same class as \code{x} with the associated 
#' dup.action
#' 
#' Since a common scheme is to have an attribute \code{dup.action} associated
#' with data, these are copied into the resulting data if they exist 
#' 
#' @seealso \code{\link[base]{duplicated}}
#'
#' @examples
#'   data(mtcars)
#'   
#'   x <- data.frame( a=letters[ sort(rep(1:4,2)) ], b=1 )
#'   
#'   dup.action(x)
#'   dup.first(x)
#'   dup.last(x)
#' 
#'   if( require(data.table) ) { 
#'    x <- data.frame( a=letters[ sort(rep(1:4,2)) ], b=c('FIRST','LAST') )
#'    setDT(x)
#'    setkey(x,a)
#'    dup.action(x)
#'    dup.first(x)
#'    dup.last(x)
#'  }
#'        
#' @rdname dup.action
#' @aliases dup.action
#' @export 

dup.action <- identity


#' @rdname dup.action
#' @aliases dup.first
#' @export 

dup.first <- function(x, ...) { 
  
  ret <- x[ ! duplicated(x, ...), ]
  
  if( ! is.null( attr(x,"dup.action") ) ) 
    attr( ret, "dup.action" ) <- attr( x, "dup.actions")
  
  return(ret)
  
}  
  

#' @rdname dup.action
#' @aliases dup.first
#' @export 

dup.last <- function(x, ...) {
  
  if( ! is.data.table(x) && is.data.frame(x) ) 
    ret <- x[ ! duplicated(x, fromLast=TRUE ) ]
  
  if( is.data.table(x) ) {
    revx <- x[ nrow(x):1 ] 
    setkeyv( revx, key(x) )
    revx <- revx[ ! duplicated( revx, fromLast=TRUE ) ]
    ret <- revx[ 1:nrow(revx) ]
  }

  if( ! is.null( attr(x,"dup.action") ) ) 
    attr( ret, "dup.action" ) <- attr( x, "dup.action")
 
  return(ret)

}  