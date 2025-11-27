#' Add Segment Pivotality Index (SPI) to candidate-level data
#'
#' @description
#' Computes SPI using \code{compute_spi()} and merges the resulting AC-level
#' SPI back into the original candidate-level dataset. All rows belonging to
#' the same group–PC–AC combination receive the same SPI and associated
#' quantities.
#'
#' @param data A data.frame or tibble with candidate-level election results.
#' @param pc_id Column identifying the larger constituency (e.g., PC).
#' @param ac_id Column identifying the sub-constituency (e.g., AC).
#' @param candidate Column identifying candidates (or parties, if unique per PC).
#' @param votes Column containing vote totals.
#' @param ... Optional additional grouping variables (e.g., state, year) that
#'   define separate election contexts. PCs and ACs are defined within these groups.
#'
#' @return A tibble with the same number of rows as \code{data}, augmented with
#' SPI-related variables (winner/runner IDs, AC- and PC-level margins, SPI).
#'
#' @import dplyr
#' @import rlang
#' @export
add_spi <- function(data,
                    pc_id,
                    ac_id,
                    candidate,
                    votes,
                    ...) {

  pc_id_sym  <- rlang::ensym(pc_id)
  ac_id_sym  <- rlang::ensym(ac_id)
  group_syms <- rlang::ensyms(...)

  group_names <- vapply(group_syms, rlang::as_name, character(1))
  pc_col      <- rlang::as_name(pc_id_sym)
  ac_col      <- rlang::as_name(ac_id_sym)

  df <- dplyr::as_tibble(data)

  # 1. Compute AC-level SPI -----------------------------------------------
  spi_df <- compute_spi(
    data      = df,
    pc_id     = !!pc_id_sym,
    ac_id     = !!ac_id_sym,
    candidate = {{ candidate }},
    votes     = {{ votes }},
    !!!group_syms
  )

  # 2. Join SPI back to original data -------------------------------------
  df_out <- df %>%
    dplyr::left_join(
      spi_df,
      by = c(group_names, pc_col, ac_col)
    )

  df_out
}
