
#' @title colors
#' @details ebs colors
#' @examples
#'\donttest{
#'(ggplot(iris) +geom_point(aes(x = Sepal.Length, y = Sepal.Width, color= Species)) +scale_color_manual(values = pal_ebs) + ebs_black())
#' }
#' @export
#http://www.color-hex.com/color-palette/22646
pal_ebs <- c("#F1F8E9", "#AED581",  "#689F38",	"#33691E")


#' @title colors
#' @details ebs colors
#' @examples
#'\donttest{
#' (ggplot(iris) +geom_point(aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +scale_fill_ebs() + ebs_black())
#'}
#'@export
############# color pieces!
scale_fill_ebs <- function(){

  structure(list(
    scale_fill_manual(values=pal_ebs)
  ))
}


#' @title discrete palette
#' @details ebs colors
#' @examples
#'\donttest{
#' (ggplot(iris) +geom_point(aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +scale_color_discrete_ebs() + ebs_black())
#' }
#' @export
scale_color_discrete_ebs <- function(){

  structure(list(
    scale_color_manual(values=pal_ebs)
  ))
}

#' @title continuous palette
#' @details ebs colors
#' @examples
#'\donttest{
#' (ggplot(iris) +geom_point(aes(x = Sepal.Length, y = Sepal.Width, color = Sepal.Width)) +scale_color_continuous_ebs() + ebs_black())
#' }
#' @export
scale_color_continuous_ebs <- function(){

  structure(list(
    scale_color_gradientn(colours = pal_ebs)
  ))
}

#' @title ebs green
#' @details ebs colors
#' @examples
#'\donttest{
#' (ggplot(iris) +geom_bar(aes(x = Sepal.Length), fill = ebsgreen) + ebs_black())
#'}
#'@export

 ebsgreen <- '#8BC34A'