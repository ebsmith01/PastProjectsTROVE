#' @description create a plot that uses ggthemes and is light  in nature
#' @title ebswhitetheme
#' @inheritParams ggplot2::theme_grey
#' @family themes
#' @importFrom ggplot2 element_line element_rect element_text element_blank rel
#' @details ggtheme that has a light background
#' @examples
#'\dontrun{ ggplot + ebs_white()}
#' @export



ebs_white <- function(base_size = 12, base_family = "") {
  scale_y_continuous(labels = scales::comma)
  scale_x_continuous(labels = scales::comma)
  theme_grey(base_size = base_size, base_family = base_family) %+replace%

    theme(
      axis.line = element_blank(),
      axis.text.x = element_text(size = base_size, color = "#343A3E",
                                 lineheight = 0.9, face = "bold"),
      axis.text.y = element_text(size = base_size, color = "#343A3E",
                                 lineheight = 0.9, face = "bold"),
      axis.ticks = element_line(color = "#343A3E", size  =  0.2),
      axis.title.x = element_text(size = base_size, color = "#343A3E",
                                  margin = margin(0, 10, 0, 0), face = "bold"),
      axis.title.y = element_text(size = base_size, color = "#343A3E",
                                  angle = 90, margin = margin(0, 10, 0, 0),
                                  face = "bold"),
      axis.ticks.length = unit(0.3, "lines"),
      legend.background = element_rect(color = NA, fill = "#fafafa"),
      legend.key = element_rect(color = "#343A3E",  fill = "#fafafa"),
      legend.key.size = unit(1.2, "lines"),
      legend.key.height = NULL,
      legend.key.width = NULL,
      legend.text = element_text(size = base_size, color = "#343A3E",
                                 face = "bold"),
      legend.title = element_text(size = base_size, face = "bold",
                                  hjust = 0, color = "#343A3E"),
      legend.position = "right",
      legend.text.align = NULL,
      legend.title.align = NULL,
      legend.direction = "vertical",
      legend.box = NULL,
      panel.background = element_rect(fill = "#fafafa", color  =  NA),
      panel.border = element_blank(),
      panel.grid.major = element_line(color= '#343A3E'),
      panel.grid.major.y = element_line(color = "#343A3E"),
      panel.grid.major.x = element_blank(),
      panel.grid.minor = element_blank(),      # Specify facetting options
      strip.background = element_rect(fill = "#fafafa", color = "#343A3E"),
      strip.text.x = element_text(size = base_size, color = "#343A3E",
                                  face = "bold"),
      strip.text.y = element_text(size = base_size, color = "#343A3E",angle = -90,
                                  face = "bold"),
      plot.background = element_rect(color = "#fafafa", fill = "#fafafa"),
      plot.title = element_text(size = base_size*2, color = "#343A3E",
                                face = "bold.italic"),
      plot.margin = unit(rep(1, 4), "lines")

    )
  }
