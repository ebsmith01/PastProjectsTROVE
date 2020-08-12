#' @description instal dependent package
#' @title instaldependents
#' @details dependent packages
#' @examples
#'\donttest{
#' needed <- c('dplyr')
#'installIfAbsentAndLoad(needed)
#'}
#' @export




installIfAbsentAndLoad <- function(neededVector) {
  for(thispackage in neededVector) {
    if( ! require(thispackage, character.only = T) )
    { install.packages(thispackage)}
    require(thispackage, character.only = T)
  }
}


