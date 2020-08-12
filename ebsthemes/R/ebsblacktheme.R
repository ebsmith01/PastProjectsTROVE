#' @description create a plot that uses ggthemes and is dark in nature
#' @title ebsblacktheme
#' @inheritParams ggplot2::theme_grey
#' @family themes
#' @importFrom ggplot2 element_line element_rect element_text element_blank rel
#' @details ggtheme that has a dark background
#' @examples
#'\dontrun{ ggplot + ebs_black()}
#' @export


ebs_black <-  function(base_size = 12, base_family = "") {
  scale_y_continuous(labels = scales::comma)
  scale_x_continuous(labels = scales::comma)
  theme_grey(base_size = base_size, base_family = base_family) %+replace%

    theme(

      axis.line = element_blank(),
      axis.text.x = element_text(size = base_size, color = "#fafafa",
                                 lineheight = 0.9, face = "bold"),
      axis.text.y = element_text(size = base_size, color = "#fafafa",
                                 lineheight = 0.9, face = "bold"),
      axis.ticks = element_line(color = "#fafafa", size  =  0.2),
      axis.title.x = element_text(size = base_size, color = "#fafafa",
                                  margin = margin(0, 10, 0, 0), face = "bold"),
      axis.title.y = element_text(size = base_size, color = "#fafafa",
                                  angle = 90, margin = margin(0, 10, 0, 0),
                                  face = "bold"),
      axis.ticks.length = unit(0.3, "lines"),
      legend.background = element_rect(color = NA, fill = "#343a3e"),
      legend.key = element_rect(color = "#fafafa",  fill = "#343a3e"),
      legend.key.size = unit(1.2, "lines"),
      legend.key.height = NULL,
      legend.key.width = NULL,
      legend.text = element_text(size = base_size, color = "#fafafa",
                                 face = "bold"),
      legend.title = element_text(size = base_size, face = "bold",
                                  hjust = 0, color = "#fafafa"),
      legend.position = "right",
      legend.text.align = NULL,
      legend.title.align = NULL,
      legend.direction = "vertical",
      legend.box = NULL,
      panel.background = element_rect(fill = "#343a3e", color  =  NA),
      panel.border = element_blank(),
      panel.grid.major = element_line(color= '#fafafa'),
      panel.grid.major.y = element_line(color = "#fafafa"),
      panel.grid.major.x = element_blank(),
      panel.grid.minor = element_blank(),      # Specify facetting options
      strip.background = element_rect(fill = "#343a3e", color = "#fafafa"),
      strip.text.x = element_text(size = base_size, color = "#fafafa",
                                  face = "bold"),
      strip.text.y = element_text(size = base_size, color = "#fafafa",angle = -90,
                                  face = "bold"),
      plot.background = element_rect(color = "#343a3e", fill = "#343a3e"),
      plot.title = element_text(size = base_size*2, color = "#fafafa",
                                face = "bold.italic"),
      plot.margin = unit(rep(1, 4), "lines")

    )
  }

