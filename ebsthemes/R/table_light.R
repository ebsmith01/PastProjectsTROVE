#' @description create a table in RMarkdown for the trove light HTML theme
#' @title table_light
#' @param data Data frame used to make table and format in light theme
#' @return The table formatted for the light HTML theme
#' @examples
#' \dontrun{
#' data(iris, package = "datasets")
#' table_light(iris)}
#' @export

table_light <- function(data){
  kable(data) %>%
    kable_styling(position = "center", font_size = 20, row_label_position = 'c',
                  stripe_color = "#F1F8E9", bootstrap_options = c("striped", "scale_down")) %>%
    row_spec(1:length(data),bold = T, color = "#8BC34A", background = "#grey") %>%
    column_spec(2:length(data),bold = T, color = "#8BC34A") %>%
    row_spec(0, angle = -45, color = "black", italic= T) %>%
    column_spec(1, color= "black", italic = T)
  }
