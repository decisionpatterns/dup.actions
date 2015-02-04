#' @param na.rm whether to remove \code{NA} values, default: \code{TRUE} 
#'  
#' @rdname dup.action 
#' @aliases dup.max
#' @export 

dup.max <- function( object, na.rm=TRUE ) { 

  if( haskey(object) )
    object[ by=key(object), , lapply(.SD, max, na.rm=TRUE )] else 
    object  
  
}


#'  
#' @rdname dup.action 
#' @aliases dup.max
#' @export 

dup.min <- function( object, na.rm=TRUE ) { 

  if( is.data.table( object ) && haskey(object) )
    object[ by=key(object), , lapply(.SD, min, na.rm=na.rm )] else 
    object  
  
}

