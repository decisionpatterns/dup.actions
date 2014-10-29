#' @rdname dup.action 
#' @aliases dup.omit
#' @export 

dup.omit <- function( object, ...)  UseMethod( 'dup.omit' )

# applies to linear objects
dup.omit.default <- function( object, ... ) 
  object[ ! ( duplicated(object) | duplicated( object, fromLast=TRUE ) ) ]  
          
# also data.tables, e.g.
dup.omit.data.frame <- function( object, ... )
  object[ ! ( duplicated(object) | duplicated( object, fromLast=TRUE ) ), ] 
