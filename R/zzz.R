#' @keywords internal
"_PACKAGE"

#' @keywords internal
.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    paste0(
      "SPIr loaded.\n",
      "  • Compute SPI for your data:  compute_spi(data, pc_id, ac_id, candidate, votes, ...)\n",
      "  • Add SPI back to full data:  add_spi(data, pc_id, ac_id, candidate, votes, ...)\n",
      "  • Quick summary:              summary_spi(spi_data, spi)\n",
      "  • Plot distribution:          plot_spi_distribution(spi_data, spi)\n",
      "Type ?compute_spi for full documentation."
    )
  )
}
