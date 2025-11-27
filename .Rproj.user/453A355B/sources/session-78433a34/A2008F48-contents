#' Quick usage guide for SPIr
#'
#' @export
spi_help <- function() {
  cat(
    "SPIr: Segment Pivotality Index

Basic workflow:

1. Compute SPI at the AC level:
   spi_ac <- compute_spi(
     data,
     pc_id     = PC_ID_COLUMN,
     ac_id     = AC_ID_COLUMN,
     candidate = CANDIDATE_COLUMN,
     votes     = VOTES_COLUMN,
     ...       # optional grouping: state, year, etc.
   )

2. Add SPI back to candidate-level data:
   data_with_spi <- add_spi(
     data,
     pc_id     = PC_ID_COLUMN,
     ac_id     = AC_ID_COLUMN,
     candidate = CANDIDATE_COLUMN,
     votes     = VOTES_COLUMN,
     ...
   )

3. Summarise and plot:
   summary_spi(spi_ac, spi)
   plot_spi_distribution(spi_ac, spi, xlim = c(-1, 5), bins = 60)

See ?compute_spi, ?add_spi, ?summary_spi, ?plot_spi_distribution for details.\n"
  )
}
