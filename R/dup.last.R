#' @examples 
#' # dup.last
#'   x <- c( 1,1,2,2,2,3 )
#'   names(x) <- letters[1:6]
#'   dup.last( x )             # b e f
#'                             # 1 2 3
#' 
#' ## data.frame
#' 
#'   data(iris)
#'   nrow(iris)               # 150 
#'   nrow( dup.last(iris) )   # 149   
#'   
#' ## data.table   
#'   if( require(data.table) ) {    
#'     setDT(iris)
#'     nrow(iris)             # 150
#'     nrow( dup.last(iris) ) # 149
#'     
#'     setkey(iris, Species)
#'     nrow( dup.last(iris) ) # 3
#'   }
#'   
#' @rdname dup.action
#' @aliases dup.first
#' @export 

dup.last <- function( object, ...)  UseMethod( 'dup.last' )
  
dup.last.default <- function( object, ... ) 
  object[ ! duplicated( object, fromLast=TRUE ) ]


dup.last.data.frame <- function( object, ...)  
    object[ ! duplicated(object, fromLast=TRUE ),  ]


dup.last.data.table <- function( object, ...)  { 
   
   if( is.null( key(object) ) ) { 
     object[ ! duplicated( object, fromLast=TRUE ),  ]
   } else { 
     object[ ! duplicated( object[, key(object), with=FALSE], fromLast=TRUE ), ]
   }
}