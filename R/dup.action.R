#' dup.action(s0)
#'
#' Actions to apply to duplicate records.
#' 
#' @param object data;
#' @param ... addditional arguments passed to
#'
#' \code{dup.action} is a family of functions similar to \code{na.action} that 
#' provide behaviors for data objects when duplicate records are encountered. 
#' Unlike \code{na.action}, \code{dup.action} generally refers to a record 
#' containing multiple columns, rather than a single vector.
#' 
#' \strong{dup.action}, the default is an alias for \code{identity} and does
#' nothing similar to na.pass
#' 
#' \strong{dup.first} removes all duplicates \strong{but the first}.  
#' \strong{dup.omit} is a synonym for dup.first.
#' 
#' \strong{dup.last} removes all duplicates \strong{but the last}.
#' 
#' 
#' @return a object with the same class as \code{object} with the associated 
#' dup.action
#' 
#' Since a common scheme is to have an attribute \code{dup.action} associated
#' with data, these are copied into the resulting data if they exist 
#' 
#' @seealso \code{\link[base]{duplicated}}
#'
#' @examples   
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
#' @aliases dup.pass
#' @export 

dup.pass <- function( object, ... ) object


#' @rdname dup.action
#' @aliases dup.first
#' @export 

dup.first <- function( object, ...)  { 
  
  ret <- object[ ! duplicated(object, ...), ]
  
  if( ! is.null( attr(object,"dup.action") ) ) 
    attr( ret, "dup.action" ) <- attr( object, "dup.actions")
  
  return(ret)
  
}  


#' @rdname dup.action 
#' @aliases dup.omit
#' @export 

dup.omit <- function( object, ... ) dup.first( object, ... )



  
  
  



#' @rdname dup.action
#' @aliases dup.first
#' @export 

dup.last <- function( object, ...)  {
  
  if( ! is.data.table(object) && is.data.frame(object) ) 
    ret <- object[ ! duplicated(object, fromLast=TRUE ),  ]
  
  if( is.data.table(object) ) {
    revd <- object[ nrow(object):1, ] 
    setkeyv( revd, key(object) )
    revd <- revd[ ! duplicated( revd, fromLast=TRUE ) ]
    ret <- revd[ 1:nrow(revd), ]
  }

  if( ! is.null( attr(object,"dup.action") ) ) 
    attr( ret, "dup.action" ) <- attr( object, "dup.action")
 
  return(ret)

}  


