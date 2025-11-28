#' SPIr: Segment Pivotality Index for Hierarchical Electoral Data
#'
#' The SPIr package provides tools to compute and analyse the Segment
#' Pivotality Index (SPI) for elections with hierarchical structures,
#' such as Assembly Constituencies (ACs) nested within Parliamentary
#' Constituencies (PCs).
#'
#' SPI quantifies how pivotal each sub-constituency is to the final
#' outcome of the parent constituency — especially in contexts where
#' only meso-level data are available and precinct-level returns are
#' missing.
#'
#' The package includes functions to:
#' \itemize{
#'   \item \code{\link{compute_spi}} – compute AC-level SPI
#'   \item \code{\link{add_spi}} – merge SPI into candidate-level data
#'   \item \code{\link{summary_spi}} – summarise SPI distributions
#'   \item \code{\link{plot_spi_distribution}} – visualise SPI
#'   \item \code{\link{spi_help}} – print a short usage guide
#' }
#'
#' Although motivated by the Indian electoral context, SPIr is fully
#' generalisable to any hierarchical dataset (e.g., branches within
#' firms, districts within regions, etc.).
#'
#' @docType package
#' @name SPIr
NULL
