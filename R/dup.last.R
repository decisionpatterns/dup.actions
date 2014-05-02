#' @rdname dup.action
#' @aliases dup.first
#' @export 

dup.last <- function( object, ...)  UseMethod( 'dup.last' )
  
dup.last.default <- function( object, ... ) 
  object[ ! duplicated( object, fromLast=TRUE ) ]

#' @export  
dup.last.data.frame <- function( object, ...)  
    object[ ! duplicated(object, fromLast=TRUE ),  ]


#' This can be defined with data.table-1.9.3 when duplicated gets the fromLast
#' argument
# dup.last.data.table <- function( object, ...)  
#  object[ ! duplicated(object, fromLast=TRUE ),  ]

#' @export
dup.last.data.table <- function( object, ...)  {
   object[ 
     ! duplicated( object[ , key(object), with=FALSE ], fromLast=TRUE  ) 
    ]
}

