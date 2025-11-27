#' Compute the Segment Pivotality Index (SPI)
#'
#' @description
#' General-purpose SPI computation for hierarchical election data, where
#' candidates compete in sub-units (e.g., ACs) nested in larger units (e.g., PCs).
#'
#' SPI for an AC is:
#'   SPI = (W_ac - R_ac) / | PC_margin - (W_ac - R_ac) |
#'
#' @param data A data.frame or tibble with candidate-level results.
#' @param pc_id Column identifying the larger constituency (e.g., PC).
#' @param ac_id Column identifying the sub-constituency (e.g., AC).
#' @param candidate Column identifying candidates (or parties, if unique per PC).
#' @param votes Column with vote totals.
#' @param ... Optional additional grouping variables (e.g., state, year) that
#'   define separate election contexts. PCs are defined within these groups.
#'
#' @return A tibble with one row per group–PC–AC combination, including:
#'   winner/runner IDs, AC- and PC-level margins, and SPI.
#'
#' @import dplyr
#' @import rlang
#' @export
compute_spi <- function(data,
                        pc_id,
                        ac_id,
                        candidate,
                        votes,
                        ...) {

  pc_id_sym     <- rlang::ensym(pc_id)
  ac_id_sym     <- rlang::ensym(ac_id)
  candidate_sym <- rlang::ensym(candidate)
  votes_sym     <- rlang::ensym(votes)
  group_syms    <- rlang::ensyms(...)

  group_names <- vapply(group_syms, rlang::as_name, character(1))
  pc_col      <- rlang::as_name(pc_id_sym)
  ac_col      <- rlang::as_name(ac_id_sym)

  df <- dplyr::as_tibble(data)

  # 1. PC-level totals per candidate, within groups ------------------------
  pc_totals <- df %>%
    dplyr::group_by(!!!group_syms, !!pc_id_sym, !!candidate_sym) %>%
    dplyr::summarise(
      pc_votes = sum(!!votes_sym, na.rm = TRUE),
      .groups  = "drop"
    )

  # 2. Top two in each group–PC -------------------------------------------
  pc_top2 <- pc_totals %>%
    dplyr::group_by(!!!group_syms, !!pc_id_sym) %>%
    dplyr::arrange(dplyr::desc(pc_votes), .by_group = TRUE) %>%
    dplyr::slice_head(n = 2) %>%
    dplyr::mutate(rank = dplyr::row_number()) %>%
    dplyr::ungroup()

  pc_winner <- pc_top2 %>%
    dplyr::filter(rank == 1) %>%
    dplyr::transmute(
      !!!group_syms,
      !!pc_id_sym,
      winner_candidate = !!candidate_sym,
      winner_pc_votes  = pc_votes
    )

  pc_runner <- pc_top2 %>%
    dplyr::filter(rank == 2) %>%
    dplyr::transmute(
      !!!group_syms,
      !!pc_id_sym,
      runner_candidate = !!candidate_sym,
      runner_pc_votes  = pc_votes
    )

  pc_pairs <- pc_winner %>%
    dplyr::left_join(
      pc_runner,
      by = c(group_names, pc_col)
    ) %>%
    dplyr::mutate(pc_margin = winner_pc_votes - runner_pc_votes)

  # 3. Attach winner/runner to all candidate rows --------------------------
  df_wr <- df %>%
    dplyr::left_join(
      pc_pairs,
      by = c(group_names, pc_col)
    )

  # 4. Winner's AC-level votes ---------------------------------------------
  w_ac <- df_wr %>%
    dplyr::filter((!!candidate_sym) == winner_candidate) %>%
    dplyr::group_by(!!!group_syms, !!pc_id_sym, !!ac_id_sym) %>%
    dplyr::summarise(
      w_ac_votes       = sum(!!votes_sym, na.rm = TRUE),
      winner_candidate = dplyr::first(winner_candidate),
      pc_margin        = dplyr::first(pc_margin),
      .groups          = "drop"
    )

  # 5. Runner-up's AC-level votes ------------------------------------------
  r_ac <- df_wr %>%
    dplyr::filter((!!candidate_sym) == runner_candidate) %>%
    dplyr::group_by(!!!group_syms, !!pc_id_sym, !!ac_id_sym) %>%
    dplyr::summarise(
      r_ac_votes       = sum(!!votes_sym, na.rm = TRUE),
      runner_candidate = dplyr::first(runner_candidate),
      .groups          = "drop"
    )

  # 6. Combine and compute SPI ---------------------------------------------
  ac_spi <- w_ac %>%
    dplyr::full_join(
      r_ac,
      by = c(group_names, pc_col, ac_col)
    ) %>%
    dplyr::mutate(
      ac_margin      = w_ac_votes - r_ac_votes,
      margin_excl_ac = pc_margin - ac_margin,
      spi = dplyr::if_else(
        margin_excl_ac == 0,
        NA_real_,
        ac_margin / abs(margin_excl_ac)
      )
    )

  ac_spi
}
