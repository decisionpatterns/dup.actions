#' @rdname dup.action
#' @aliases dup.first
#' @export 

dup.first <- function( object, ... ) UseMethod( 'dup.first' )

dup.first.default <- function( object, ... )  
  object[ ! duplicated(object)  ]  

dup.first.data.frame <- function( object, ... )
  object[ ! duplicated(object), ]

# dup.first.default <- function( object, ...)  {
#   
#   ret <- object[ ! duplicated(object, ...), ]
#   
#   if( ! is.null( attr(object,"dup.action") ) ) 
#     attr( ret, "dup.action" ) <- attr( object, "dup.actions")
#   
#   return(ret)
#   
# }  