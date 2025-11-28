# SPIr: Segment Pivotality Index for Hierarchical Electoral Data

**SPIr** provides tools to compute and analyse the **Segment Pivotality Index (SPI)** for hierarchical electoral systems, such as Assembly Constituencies (ACs) nested within Parliamentary Constituencies (PCs).
SPI measures how pivotal each sub-unit is to determining the final outcome when only meso-level data are available.

Although motivated by the Indian electoral context, SPIr is fully generalisable to any hierarchical dataset (e.g., branches within firms, districts within regions).

---

## Installation

You can install the development version of **SPIr** from GitHub with:

```r
install.packages("remotes")
remotes::install_github("PawasPratikshit/SPIr")
library(SPIr)
```

---

## Getting Help

On some systems, package-level help does **not** appear via `?SPIr`.

The **correct and reliable** way to see all documentation is:

```r
help(package = "SPIr")
```

Function-level help works normally:

```r
?compute_spi
?add_spi
?summary_spi
?plot_spi_distribution
```

---

## Core Functions

* **compute_spi()** – Compute SPI at the segment (AC) level
* **add_spi()** – Merge SPI values back into your original dataset
* **summary_spi()** – Summarise SPI distribution patterns
* **plot_spi_distribution()** – Visualise SPI values
* **spi_help()** – Quick workflow guide

---

## Example

Here is a minimal working example:

```r
library(SPIr)
library(dplyr)

df <- tibble(
  pc    = c(1,1,1,1),
  ac    = c(1,1,2,2),
  cand  = c("A","B","A","B"),
  votes = c(60,40,55,45)
)

spi_df <- compute_spi(
  df,
  pc_id     = pc,
  ac_id     = ac,
  candidate = cand,
  votes     = votes
)

spi_df
```

---

## Recommended Workflow

```r
help(package = "SPIr")        # browse documentation
spi_help()                    # quick overview

spi_df  <- compute_spi(...)
full_df <- add_spi(...)
summary_spi(spi_df)
plot_spi_distribution(spi_df)
```

---

## Citation

If you use SPIr in your research, please cite:

**Pratikshit, Pawas. (2025). *SPIr: Tools for Computing the Segment Pivotality Index*.**

---

## Contributing

Issues, feature requests, and pull requests are welcome:

[https://github.com/PawasPratikshit/SPIr/issues](https://github.com/PawasPratikshit/SPIr/issues)

---

### End of README

---
