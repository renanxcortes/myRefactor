#' Calculate total price with Discount by currency
#'
#' \code{total_price} This function calculates total price with Discount by currency.
#'
#' @param .data A data.frame/tibble of orders.
#' @param .currency A character string that depicts the desired currency.
#'
#' @export
#'
total_price <- function(.data, .currency = "EUR"){
  
  if(!is.character(.currency)) { stop("'.currency' should be character.") }
  if(length(.currency) != 1) { stop("'.currency' should be of length 1.") }
  
  currency_options <- c("EUR", "USD")
  if(!(.currency %in% currency_options)) { stop(paste0("'.currency' should be in ", paste0(currency_options, collapse = ', '))) }
  
  df_class <- class(.data)
  if(!('data.frame' %in% df_class)) { stop("'.data' should be either data.frame or tibble") }
  
  colname_required <- paste0('price_', .currency)
  
  if(!(colname_required %in% colnames(.data))) { stop(paste0(colname_required, " not present in input .data.")) }
  
  is_discount_day <- Sys.Date() == as.Date("2020-11-27")
  if(is_discount_day)   { discount <- 0.5 } else {
    
    if(.currency == "EUR") { discount <- 0.2  }
    if(.currency == "USD") { discount <- 0.25 }
    
  }
  
  total_raw <- .data %>% 
    dplyr::select(colname_required) %>% 
    dplyr::pull() %>%
    base::sum(na.rm = T)
  
  total_discounted <- total_raw * (1 - discount)  
  
  return(total_discounted)
  
}