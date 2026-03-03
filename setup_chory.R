setup_chory <- function(set_wd = TRUE) {
  # Call Necessary Libraries ----------------------------------------------
  pkgs = c("data.table", "dplyr", "R.utils", "reshape", "reshape2", "jsonlite","tidyr", 
           "tidyverse", "cowplot", "scales", 
           "stringr","chron", "zoo","RSQLite", "dplyr", "ggplot2", "rstudioapi", "data.table", 
           "stringr", "chron", "zoo", "sendmailR", "cowplot", "RCurl", "tidyr", "lubridate", "collapse",
           "readr", "scales", "cowplot", "googlesheets4", "DBI","RPostgres", "odbc", "DBI", "dplyr", "tidyr", "patchwork")
  
  
  message("--- chory-setup ---")
  
  missing <- pkgs[!(pkgs %in% installed.packages()[, "Package"])]
  if (length(missing)) {
    message("Installing missing packages: ", paste(missing, collapse = ", "))
    install.packages(missing)
  } else {
    message("All ", length(pkgs), " already installed.")
  }
  
  message("Loading packages...")
  for (pkg in pkgs) {
    suppressPackageStartupMessages(library(pkg, character.only = TRUE))
  }
  message("Loaded ", length(pkgs), " packages.")
  
  options(warn = -1)
  message("Warnings suppressed.")
  
  if (set_wd && interactive() && requireNamespace("rstudioapi", quietly = TRUE)) {
    doc_path <- tryCatch(
      rstudioapi::getActiveDocumentContext()$path,
      error = function(e) ""
    )
    if (nzchar(doc_path)) {
      setwd(dirname(doc_path))
      message("Working dir set to: ", getwd())
    } else {
      message("No active document -- keeping wd: ", getwd())
    }
  } else if (!set_wd) {
    message("Keeping current wd: ", getwd())
  }
  
  message("--- ready ---")
}
