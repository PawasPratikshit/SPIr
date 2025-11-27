#' Plot the distribution of SPI
#'
#' @description
#' Plots the empirical distribution of the Segment Pivotality Index (SPI)
#' using a histogram and optional kernel density overlay.
#'
#' @param data A data.frame or tibble containing a SPI column.
#' @param spi Column containing SPI values.
#' @param xlim Optional numeric vector of length 2 giving x-axis limits
#'   (e.g., c(-1, 5)). If NULL, full range is used.
#' @param bins Number of bins for the histogram.
#' @param density Logical; if TRUE, adds a kernel density curve.
#'
#' @return A ggplot object.
#'
#' @import ggplot2
#' @import rlang
#' @export
plot_spi_distribution <- function(data,
                                  spi = spi,
                                  xlim = NULL,
                                  bins = 60,
                                  density = TRUE) {

  spi_sym <- rlang::ensym(spi)
  df <- dplyr::as_tibble(data) %>%
    dplyr::filter(!is.na(!!spi_sym))

  p <- ggplot2::ggplot(df, ggplot2::aes(x = !!spi_sym)) +
    ggplot2::geom_histogram(
      bins = bins,
      color = "black",
      fill  = "white"
    )

  if (density) {
    p <- p +
      ggplot2::geom_density(
        linewidth = 0.8
      )
  }

  if (!is.null(xlim)) {
    p <- p +
      ggplot2::scale_x_continuous(limits = xlim)
  }

  p +
    ggplot2::labs(
      x = "Segment Pivotality Index (SPI)",
      y = "Count",
      title = "Distribution of Segment Pivotality Index (SPI)"
    ) +
    ggplot2::theme_bw()
}
