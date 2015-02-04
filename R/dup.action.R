#' dup.action(s0)
#'
#' Actions to apply to duplicate records.
#' 
#' @param object data;
#' @param ... addditional arguments passed to
#'
#' \code{dup.action} is a family of functions similar to \code{na.action} that 
#' provide behaviors for data objects when duplicate records are encountered. 
#' Unlike \code{na.action}, \code{dup.action} can refer to a multiple columns 
#' in a table, rather than a single vector.
#' 
#' \strong{dup.pass} does nothing and passes \code{object} untouched
#' 
#' \strong{dup.first} removes all duplicates \strong{but the first}.
#' 
#' \strong{dup.last} removes all duplicates \strong{but the last}.
#'   
#' \strong{dup.omit} removes \strong{all} records that have duplicates, i.e. only unique 
#' records remain.
#' 
#' The \code{dup.action} family of methods does not preserve attributes. To 
#' preserve attributes during subset, see \code{\link{dedup}}.
#' 
#' @return 
#'   an object with the same class as \code{object} with the associated 
#'   dup.action applied.
#' 
#'   Since a common scheme is to have an attribute \code{dup.action} associated
#'   with data, these are copied into the resulting data if they exist 
#' 
#' @seealso 
#'   \code{\link[base]{duplicated}}, \cr
#'   \code{\link{dup.pivot}}
#'
#' @examples   
#'   x <- data.frame( a=letters[ sort(rep(1:4,2)) ], b=1 )
#'   
#'   dup.pass(x)
#'   dup.first(x)
#'   dup.last(x)
#' 
#'   \dontrun{ 
#'     setDT(x)
#'     x[ , b := 1:2 ]
#'     setkey(x,a)
#'     dup.action(x)
#'     dup.first(x)
#'     dup.last(x)
#'   }
#'        
#' @rdname dup.action
#' @name dup.action
#' @import data.table

NULL




