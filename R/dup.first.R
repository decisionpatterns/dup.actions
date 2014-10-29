#' @examples 
#' # dup.first
#'   x <- c( 1,1,2,2,2,3 )
#'   names(x) <- letters[1:6]
#'   dup.first( x )             # b e f
#'                              # 1 2 3
#' 
#' ## data.frame
#'   data(iris)
#'   nrow(iris)                # 150 
#'   nrow( dup.first(iris) )   # 149   
#'   
#' ## data.table
#'   if( require(data.table) ) {    
#'     setDT(iris)
#'     nrow(iris)              # 150
#'     nrow( dup.first(iris) ) # 149
#'     
#'     setkey(iris, Species)
#'     nrow( dup.first(iris) ) # 3
#'   }
#'   
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