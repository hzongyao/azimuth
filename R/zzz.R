#' @docType package
#'
#' @section Package options:
#'
#' \pkg{Azimuth} uses the following options to control the behavior of the app.
#' Users can provide these as named arguments to \code{\link{AzimuthApp}}
#' through dots (...), specify these in the config file, or configure these with
#' \code{\link[base]{options}}.
#'
#' \subsection{App options}{
#'  The following options control app behavior
#'  \describe{
#'   \item{\code{Azimuth.app.default_adt}}{
#'    ADT to select by default in feature/violin plot
#'   }
#'   \item{\code{Azimuth.app.default_gene}}{
#'    Gene to select by default in feature/violin plot
#'   }
#'   \item{\code{Azimuth.app.demodataset}}{
#'    Path to data file (in any Azimuth-supported format) to automatically load
#'    when the user clicks a button. The button is only available in the UI
#'    if this option is set
#'   }
#'   \item{\code{Azimuth.app.googlesheet}}{
#'    Google Sheet identifier (appropriate for use with
#'    \code{\link[googlesheets4:gs4_get]{googlesheets4:gs4_get}}) to write log
#'    records. Logging is only enabled if this and other \code{google*} options
#'    are set
#'   }
#'   \item{\code{Azimuth.app.googletoken}}{
#'    Path to directory containing Google Authentication token file.
#'    Logging is only enabled if this and other \code{google*} options are set
#'   }
#'   \item{\code{Azimuth.app.googletokenemail}}{
#'    Email address corresponding to the Google Authentication token file.
#'    Logging is only enabled if this and other \code{google*} options are set
#'   }
#'   \item{\code{Azimuth.app.max_cells}}{
#'    Maximum number of cells allowed to upload
#'   }
#'   \item{\code{Azimuth.app.mito}}{
#'    Regular expression pattern indicating mitochondrial features in query
#'    object
#'   }
#'   \item{\code{Azimuth.app.plotseed}}{
#'    Seed to shuffle colors for cell types
#'   }
#'   \item{\code{Azimuth.app.reference}}{
#'    URL or directory path to reference dataset; see
#'    \code{\link{LoadReference}} for more details
#'   }
#'   \item{\code{Azimuth.app.welcomebox}}{
#'    Provide (as a string) the code to render the box on the welcome page
#'    (quotes escaped). Example:
#'    ```
#'    box(
#'      h3(\"Header\"),
#'      \"body text\",
#'      a(\"link\", href=\"www.satijalab.org\", target=\"_blank\"),
#'      width = 12
#'    )
#'    ```
#'   }
#'  }
#' }
#'
#' \subsection{Control options}{
#'  These options control mapping and analysis behavior
#'  \describe{
#'   \item{\code{Azimuth.map.ncells}}{
#'    Minimum number of cells required to accept uploaded file.
#'    Defaults to \code{100}
#'   }
#'   \item{\code{Azimuth.map.ngenes}}{
#'    Minimum number of genes in common with reference to accept uploaded file.
#'    Defaults to \code{250}
#'   }
#'   \item{\code{Azimuth.map.nanchors}}{
#'    \strong{NOT CURRENTLY USED}
#'    Minimum number of anchors that must be found to complete mapping.
#'    Defaults to \code{50}
#'   }
#'   \item{\code{Azimuth.map.ntrees}}{
#'    Annoy (approximate nearest neighbor) n.trees parameter
#'    Defaults to \code{20}
#'   }
#'   \item{\code{Azimuth.map.pbcorthresh}}{
#'    Only proceed to mapping if query dataset meets or exceeds this threshold
#'    in pseudobulk correlation test.
#'   }
#'   \item{\code{Azimuth.de.mincells}}{
#'    Minimum number of cells per cluster for differential expression; defaults
#'    to \code{15}
#'   }
#'   \item{\code{Azimuth.de.digits}}{
#'    Number of digits to round differential expression table to; defaults to
#'    \code{3}
#'   }
#'   \item{\code{Azimuth.sct.ncells}, \code{Azimuth.sct.nfeats}}{
#'    Number of cells and features to use for
#'    \code{\link[Seurat]{SCTransform}}, respectively. Defaults to \code{2000}
#'    for each
#'   }
#'  }
#' }
#'
#' \subsection{External options}{
#'  The following options are used by external dependencies that have an effect
#'  on \pkg{Azimuth}'s behavior. Refer to original package documentation for
#'  more details
#'  \describe{
#'   \item{\code{\link[shiny:shiny-options]{shiny.maxRequestSize}}}{
#'    User-configurable; used for controlling the maximum file size of uploaded
#'    datasets. Defaults to 500 Mb
#'   }
#'   \item{\code{\link[DT:datatable]{DT.options}}}{
#'   User-configurable; used for controlling biomarker table outputs.
#'   Defaults to setting \code{pageLength} to \code{10}
#'   }
#'   \item{\code{\link[future:future.options]{future.globals.maxSize}}}{
#'    \strong{Non-configurable}; used for parallelization. Defaults to
#'    \code{Azimuth.app.max_cells * 320000}
#'   }
#'  }
#' }
#'
#' @md
#'
"_PACKAGE"

default.options <- list(
  Azimuth.app.default_adt = "CD3-1",
  Azimuth.app.default_gene = "GNLY",
  Azimuth.app.max_cells = 50000,
  Azimuth.app.mito = '^MT-',
  Azimuth.app.plotseed = 0,
  Azimuth.app.reference = 'https://seurat.nygenome.org/references/pbmc',
  Azimuth.app.welcomebox = "",
  Azimuth.de.digits = 3L,
  Azimuth.de.mincells = 15L,
  Azimuth.map.ncells = 100L,
  Azimuth.map.ngenes = 250L,
  Azimuth.map.nanchors = 50L,
  Azimuth.map.ntrees = 20L,
  Azimuth.map.pbcorthresh = 0.75,
  Azimuth.sct.ncells = 2000L,
  Azimuth.sct.nfeats = 2000L
)

#' Attach dependent packages
#'
#' Attaches the following packages
#' \itemize{
#'  \item shinyBS
#' }
#'
#' @return Attaches the required packages and returns invisible \code{NULL}
#'
#' @keywords internal
#'
AttachDeps <- function() {
  deps <- c(
    'shinyBS'
  )
  for (d in deps) {
    if (!paste0('package:', d) %in% search()) {
      packageStartupMessage("Attaching ", d)
      attachNamespace(ns = d)
    }
  }
}

#' Returns a dataframe of the frequency or percentage of levels of category.2
#' (column) for object split by each level of category.1 (row)
#'
#' @param object a Seurat object
#' @param category.1 a metadata field in the object
#' @param category.2 another metadata field in the object
#' @param percentage if TRUE, returns percentages; otherwise, counts
#'
#' @importFrom Seurat FetchData
#'
#' @keywords internal
#'
CategoryTable <- function(
  object,
  category.1,
  category.2,
  percentage = FALSE
) {
  data <- FetchData(object = object, vars = c(category.1, category.2))
  data[, category.1] <- droplevels(x = factor(x = data[, category.1]))
  data[, category.1] <- factor(x = data[, category.1], levels = sort(x = levels(x = data[, category.1])))
  data[, category.2] <- droplevels(x = factor(x = data[, category.2]))
  data[, category.2] <- factor(x = data[, category.2], levels = sort(x = levels(x = data[, category.2])))
  tbl <- table(
    data[, category.1],
    data[, category.2],
    useNA = "ifany"
  )
  if (percentage) {
    tbl <- t(x = apply(
      X = tbl,
      MARGIN = 1,
      FUN = function(x) {
        return(round(x = 100 * (x / sum(x)), digits = 1))
      }
    ))
    if (length(levels(data[, category.2])) == 1) {
      tbl <- t(tbl)
      colnames(x = tbl) <- levels(x = data[, category.2])
    }
  }
  return(as.data.frame.matrix(x = tbl))
}

#' Sanitize feature names for \code{\link[shiny]{selectInput}}
#'
#' \code{\link[shiny]{selectInput}} has some limitiations with biological
#' feature names. This function sanitizes feature names according to the
#' following rules:
#' \itemize{
#'  \item Names matching the regular expression \dQuote{\\.\\d+$} are
#'   \strong{removed}
#' }
#'
#' @param features A character vector of feature names
#'
#' @return \code{features}, but sanitized
#'
#' @keywords internal
#'
#' @seealso \code{\link[shiny]{selectInput}}
#'
FilterFeatures <- function(features) {
  return(sort(x = grep(
    pattern = '\\.\\d+$',
    x = features,
    value = TRUE,
    invert = TRUE
  )))
}

#' Return names of metadata columns in a Seurat object that have an
#' appropriate number of levels for plotting when converted to a factor
#'
#' @param object a Seurat object
#' @param min.levels minimum number of levels in a metadata factor to include
#' @param max.levels maximum number of levels in a metadata factor to include
#'
#' @keywords internal
#'
PlottableMetadataNames <- function(
  object,
  min.levels = 2,
  max.levels = 20
) {
  column.status <- sapply(
    X = object[[]],
    FUN = function(column) {
      length(x = levels(x = droplevels(x = as.factor(x = column)))) >= min.levels &&
        length(x = levels(x = droplevels(x = as.factor(x = column)))) <= max.levels
    }
  ) & (colnames(object[[]]) != "mapping.score") &
   (colnames(object[[]]) != "predicted.id")
  return(colnames(object[[]])[column.status])
}

#' Prepare differential expression results for rendering
#'
#' @param diff.exp A dataframe with differential expression results from
#' \code{\link[presto:wilcoxauc]{presto::wilcoxauc}}
#' @param groups.use Names of groups to filter \code{diff.exp} to; groups must
#' be found in \code{diff.exp$group}
#' @param n Number of feature to filter \code{diff.exp} to per group
#' @param logfc.thresh logFC threshold
#'
#' @return \code{diff.exp}, ordered by adjusted p-value, filtered to \code{n}
#' features per group in \code{group.use}
#'
#' @importFrom rlang %||%
#' @importFrom utils head
#'
#' @seealso \code{\link[presto]{wilcoxauc}}
#'
#' @keywords internal
#'
RenderDiffExp <- function(
  diff.exp,
  groups.use = NULL,
  n = 10L,
  logfc.thresh = 0L
) {
  # cols.keep <- c('logFC', 'auc', 'padj', 'pct_in', 'pct_out')
  cols.keep <- c('auc', 'padj', 'pct_in', 'pct_out')
  groups.use <- groups.use %||% unique(x = as.character(x = diff.exp$group))
  diff.exp <- lapply(
    X = groups.use,
    FUN = function(group) {
      group.de <- diff.exp[diff.exp$group == group, , drop = FALSE]
      group.de <- group.de[group.de$logFC > logfc.thresh, , drop = FALSE]
      group.de <- group.de[order(group.de$padj, -group.de$auc), , drop = FALSE]
      return(head(x = group.de, n = n))
    }
  )
  diff.exp <- do.call(what = 'rbind', diff.exp)
  rownames(x = diff.exp) <- make.unique(names = diff.exp$feature)
  diff.exp <- signif(
    x = diff.exp[, cols.keep, drop = FALSE],
    digits = getOption(
      x = "Azimuth.de.digits",
      default = default.options$Azimuth.de.digits
    )
  )
  return(diff.exp)
}

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Load Hooks
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

.onLoad <- function(libname, pkgname) {
  # Attach deps
  AttachDeps()
  op <- options()
  # Set some default options
  toset <- !names(x = default.options) %in% names(x = op)
  if (any(toset)) {
    options(default.options[toset])
  }
}
