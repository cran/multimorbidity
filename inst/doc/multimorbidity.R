## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include = FALSE---------------------------------------------------

devtools::load_all(".")
library(tidyverse)


## ---- include = FALSE---------------------------------------------------------
claims <- i9_i10_comb

## ---- echo = FALSE------------------------------------------------------------
head(claims, 10)

## ---- include = FALSE---------------------------------------------------------
id <- multimorbidity::id

## ---- echo = FALSE------------------------------------------------------------
head(id, 5)

## -----------------------------------------------------------------------------
prepared_data <- prepare_data(dat = claims,
                              id = patient_id,
                              style = "wide",
                              prefix_dx = "dx",
                              hcpcs = "yes",
                              prefix_hcpcs = "hcpcs", 
                              version_var = icd_version,
                              type_name = visit_type,
                              date = date_of_serv)


## ---- echo = FALSE------------------------------------------------------------
head(prepared_data, 10)

## -----------------------------------------------------------------------------
limit_data <- comorbidity_window(id_dat = id, dat = prepared_data, id = patient_id, 
                                 id_date = date_of_interest9, claims_date = claim_date,
                                 time_pre = 60)

## ---- echo = FALSE------------------------------------------------------------
head(limit_data, 10)

## -----------------------------------------------------------------------------
elix_data <- elixhauser(dat = limit_data, id = patient_id, dx = dx, version = 19, version_var = version, outpatient_two = "yes")

## ---- echo = FALSE------------------------------------------------------------
head(elix_data, 5)

## -----------------------------------------------------------------------------
charlson_data <- charlson(dat = limit_data, id = patient_id, dx = dx, version = 19, version_var = version, outpatient_two = "yes")

## ---- echo = FALSE------------------------------------------------------------
head(charlson_data, 5)

## -----------------------------------------------------------------------------
cfi_data <- cfi(dat = limit_data, id = patient_id, dx = dx, version = 19, version_var = version)

## ---- echo = FALSE------------------------------------------------------------
head(cfi_data, 5)

## -----------------------------------------------------------------------------
mwi_data <- mwi(dat = limit_data, id = patient_id, dx = dx, version = 9, version_var = version)

## ---- echo = FALSE------------------------------------------------------------
head(mwi_data, 5)

## -----------------------------------------------------------------------------
nf_data <- nicholsonfortin(dat = limit_data, id = patient_id, dx = dx, version = 19, version_var = version, outpatient_two = "yes")

## ---- echo = FALSE------------------------------------------------------------
head(nf_data, 5)

