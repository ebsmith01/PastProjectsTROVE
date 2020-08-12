
#' @title table_dark
#' @description dark table for rmd html
#' @param data is a data frame
#' @return The table formatted for the dark HTML theme
#' @examples
#' \dontrun{
#' data(iris, package = "datasets")
#' table_dark(iris)}
#' @export




table_dark <- function(data){
  kable(data) %>%
    kable_styling(position = "center", font_size = 20, row_label_position = 'c',
                  stripe_color = "#F1F8E9", bootstrap_options = c("striped", "scale_down")) %>%
    row_spec(1:length(data),bold = T, color = "#8BC34A", background = "#grey") %>%
    column_spec(2:length(data),bold = T, color = "#8BC34A") %>%
    row_spec(0, angle = -45, color = "white", italic= T) %>%
    column_spec(1, color= "white", italic = T)
  }

