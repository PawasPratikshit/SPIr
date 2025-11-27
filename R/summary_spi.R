#' Summarise Segment Pivotality Index (SPI)
#'
#' @description
#' Provides basic descriptive statistics for SPI, optionally by groups
#' (e.g., by state, year, winner party).
#'
#' @param data A data.frame or tibble containing a SPI column.
#' @param spi Column containing SPI values.
#' @param ... Optional grouping variables (e.g., state, year).
#'
#' @return A tibble with summary statistics for SPI, by group if specified.
#'
#' @import dplyr
#' @import rlang
#' @export
summary_spi <- function(data, spi = spi, ...) {

  spi_sym   <- rlang::ensym(spi)
  group_syms <- rlang::ensyms(...)

  df <- dplyr::as_tibble(data)

  df %>%
    dplyr::group_by(!!!group_syms) %>%
    dplyr::summarise(
      n         = sum(!is.na(!!spi_sym)),
      mean_spi  = mean(!!spi_sym, na.rm = TRUE),
      sd_spi    = stats::sd(!!spi_sym, na.rm = TRUE),
      min_spi   = min(!!spi_sym, na.rm = TRUE),
      q25_spi   = stats::quantile(!!spi_sym, 0.25, na.rm = TRUE),
      median_spi= stats::median(!!spi_sym, na.rm = TRUE),
      q75_spi   = stats::quantile(!!spi_sym, 0.75, na.rm = TRUE),
      max_spi   = max(!!spi_sym, na.rm = TRUE),
      share_spi_gt_1 = mean(!!spi_sym > 1, na.rm = TRUE),
      share_spi_gt_2 = mean(!!spi_sym > 2, na.rm = TRUE),
      share_spi_lt_0 = mean(!!spi_sym < 0, na.rm = TRUE),
      .groups = "drop"
    )
}
