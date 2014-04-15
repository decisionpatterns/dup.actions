#' @rdname dup.action 
#' @aliases dup.omit
#' @export 

dup.omit <- function( object, ... ) 
  object[ ! ( duplicated( object ) | duplicated( object, fromLast=TRUE ) ) , ]  
                     