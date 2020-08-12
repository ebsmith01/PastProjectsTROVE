#' @description create a table in RMarkdown for the trove pdf
#' @title table_pdf
#' @param data Data frame used to make table and format in pdf
#' @return The table formatted for the pdf
#' @examples
#' \dontrun{
#' data(iris, package = "datasets")
#' table_dark(iris)}
#' @export


table_pdf <- function(data){
  knitr::kable(data) %>%
    kable_styling(position = "center", font_size = 20, row_label_position = 'c',
                  stripe_color = "#F1F8E9", latex_options = c("striped", "scale_down")) %>%
    row_spec(1:length(data), color = "black") %>%
    column_spec(2:length(data), color = "#8BC34A") %>%
    row_spec(0, angle = -45, color = "black", italic= T, bold = T) %>%
    column_spec(1, bold= T)
  }


