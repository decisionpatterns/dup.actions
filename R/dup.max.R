#' @param data a data object 
#' @param ...
#' 
#'  
#' @rdname dup.action 
#' @aliases dup.max
#' @export 

dup.max <- function( data, na.rm=TRUE ) { 

  if( haskey(data) )
    data[ by=key(data), , lapply(.SD, max, na.rm=TRUE )] else 
    data  
  
}


#' @param data a data object 
#' @param ...
#' 
#'  
#' @rdname dup.action 
#' @aliases dup.max
#' @export 

dup.min <- function( data, na.rm=TRUE ) { 

  if( is.data.table( data ) && haskey(data) )
    data[ by=key(data), , lapply(.SD, min, na.rm=na.rm )] else 
    data  
  
}

