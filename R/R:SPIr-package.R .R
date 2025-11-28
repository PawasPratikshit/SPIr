#' SPIr: Segment Pivotality Index for Hierarchical Electoral Data
#'
#' The SPIr package provides tools to compute and analyse the Segment
#' Pivotality Index (SPI) for elections with hierarchical structures,
#' such as Assembly Constituencies (ACs) nested within Parliamentary
#' Constituencies (PCs). SPI quantifies how pivotal each sub-constituency
#' is to the final outcome of the parent constituency, especially when
#' only meso-level data are available and precinct-level returns are
#' missing.
#'
#' The package includes functions to compute SPI at the segment level,
#' merge SPI back into candidate-level data, summarise SPI distributions,
#' and visualise them for exploratory analysis. Although motivated by the
#' Indian electoral context, the methods are general and can be applied
#' to any hierarchical dataset (e.g., branches within firms, districts
#' within regions).
#'
#' Main functions:
#' \itemize{
#'   \item \code{\link{compute_spi}} – compute SPI at the segment level.
#'   \item \code{\link{add_spi}} – attach SPI values back to candidate-level data.
#'   \item \code{\link{summary_spi}} – summarise SPI distributions.
#'   \item \code{\link{plot_spi_distribution}} – visualise SPI distributions.
#'   \item \code{\link{spi_help}} – print a short usage guide and workflow.
#' }
#'
#' @details
#' This documentation entry supplements the package title and description
#' defined in the DESCRIPTION file. See the linked functions above for
#' concrete examples and usage.
#'
#' @keywords internal
"_PACKAGE"
