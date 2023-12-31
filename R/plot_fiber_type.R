#' @title Plot fiber area by fiber type and group
#'
#' @param x a `data.frame` with columns \code{"response"}, \code{"type"},
#'   \code{"group"}, \code{"muscle"}, \code{"age"}, \code{"sex"}, and the column
#'   given by \code{response}.
#' @param response character; name of a column in \code{x}. Used to plot
#'   individual data points.
#' @param conf a \code{data.frame} with columns "muscle", "age", "sex", "group",
#'   "response_mean", "lower.CL", and "upper.CL".
#' @param stats \code{data.frame} with columns "muscle", "type", "age", "sex",
#'   "contrast", "type", "p.value", and "signif".
#' @param muscle character; skeletal muscle to plot. Either "LG", "MG", "PL", or
#'   "SOL" (lateral gastrocnemius, medial gastrocnemius, plantaris, or soleus).
#' @param sex character; sex of rats to plot. Either "Female" or "Male".
#' @param age character; age of rats to plot. Either "6M" or "18M".
#' @inheritParams ggpubr::stat_pvalue_manual
#'
#' @importFrom ggplot2 ggplot aes geom_point facet_grid labs coord_cartesian
#'   theme_bw theme element_text element_line element_rect element_blank
#'   layer_scales annotation_custom
#' @importFrom grid unit linesGrob grid.draw gpar
#' @importFrom dplyr %>% filter select mutate group_by left_join
#' @importFrom rlang !! sym
#' @importFrom ggbeeswarm position_beeswarm
#' @importFrom ggpubr stat_pvalue_manual
#' @importFrom rstatix t_test adjust_pvalue add_xy_position add_significance
#'
#' @export plot_fiber_type

plot_fiber_type <- function(x,
                            response,
                            conf,
                            stats,
                            muscle = "MG",
                            sex = "Female",
                            age = "6M",
                            bracket.nudge.y = 0) {

  x <- x %>%
    filter(muscle == !!muscle, age == !!age, sex == !!sex) %>%
    dplyr::rename(response = !!sym(response)) %>%
    filter(!is.na(response)) %>%
    droplevels.data.frame()

  # Add confidence intervals
  conf <- conf %>%
    filter(muscle == !!muscle, age == !!age, sex == !!sex) %>%
    droplevels.data.frame()

  # workaround to avoid warning messages
  cart <- coord_cartesian(clip = "off")
  cart$default <- TRUE

  p <- ggplot(x, aes(x = group, y = response)) +
    geom_crossbar(data = conf, aes(x = group, y = response_mean,
                                   ymin = lower.CL, ymax = upper.CL),
                  fatten = 1, linewidth = 0.4,
                  color = ifelse(sex == "Female", "#ff6eff", "#5555ff")) +
    geom_point(shape = 16, size = 0.4, na.rm = TRUE,
               position = position_beeswarm(cex = 7.5)) +
    facet_grid(~ type, switch = "x") +
    labs(x = NULL) +
    cart +
    theme_bw(base_size = 7) +
    theme(text = element_text(size = 7, color = "black"),
          line = element_line(linewidth = 0.3, color = "black"),
          axis.ticks = element_line(linewidth = 0.3, color = "black"),
          panel.grid = element_blank(),
          panel.border = element_blank(),
          axis.ticks.x = element_blank(),
          axis.text = element_text(size = 7, color = "black"),
          axis.text.x = element_text(size = 7, angle = 90, hjust = 1,
                                     vjust = 0.5),
          axis.title = element_text(size = 7, margin = margin(),
                                    color = "black"),
          axis.line = element_line(color = "black", linewidth = 0.3),
          strip.background = element_blank(),
          strip.text = element_text(size = 7, color = "black",
                                    margin = margin(b = 0, t = 2)),
          panel.spacing = unit(2, "pt"),
          plot.title = element_text(size = 7, color = "black"),
          plot.subtitle = element_text(size = 7, color = "black"),
          legend.position = "none",
          strip.placement = "outside"
    )

  ## Add horizontal lines above the fiber types.
  p <- p +
    annotation_custom(grob = linesGrob(x = c(0, 1),
                                       y = unit(-20, "pt"),
                                       gp = gpar(lwd = 0.9)),
                      xmin = -Inf, xmax = Inf,
                      ymin = -Inf, ymax = Inf)

  ## Add statistics to plot
  stats <- stats %>%
    filter(muscle == !!muscle, type %in% x$type,
           age == !!age, sex == !!sex) %>%
    # Drop levels before filtering to significant comparisons
    droplevels.data.frame() %>%
    filter(signif)

  if (nrow(stats) > 0) {
    # Y-axis limits
    limits <- layer_scales(p)$y$range$range

    stats <- stats %>%
      mutate(group1 = sub(".* ", "", contrast),
             group2 = sub(" .*", "", contrast)) %>%
      dplyr::select(type, group1, group2, p.adj, signif)

    stat_test <- x %>%
      mutate(y = response) %>%
      group_by(type) %>%
      t_test(y ~ group, paired = TRUE) %>%
      adjust_pvalue(method = "holm") %>%
      add_significance("p.adj") %>%
      dplyr::select(-p.adj) %>%
      left_join(stats, by = c("group1", "group2", "type")) %>%
      add_xy_position(x = "group", scales = "free",
                      step.increase = 0.05, dodge = 0,
                      group = "type")

    p <- p +
      stat_pvalue_manual(stat_test,
                         label = NULL,
                         hide.ns = "p.adj",
                         size = 0,
                         bracket.nudge.y = bracket.nudge.y,
                         bracket.size = 0.3,
                         step.group.by = "type")
  }

  return(p)
}

