⚠️ [2024-11-01] DEPRECATED IN FAVOUR OF [berdata](https://github.com/Bureau-for-Economic-Research/berdata) 

# sarbR <img src="logo.png" align="right" alt="" width="120" />

[![](https://img.shields.io/badge/lifecycle-stable-green.svg)](https://www.tidyverse.org/lifecycle/#stable)
[![](https://img.shields.io/github/last-commit/Stellenbosch-Econometrics/sarbR.svg)](https://github.com/Stellenbosch-Econometrics/sarbR/commits/master)
[![CRAN Status](https://www.r-pkg.org/badges/version/sarbR)](https://cran.r-project.org/package=sarbR)
[![Coverage Status](https://img.shields.io/codecov/c/github/Stellenbosch-Econometrics/sarbR/master.svg)](https://codecov.io/github/Stellenbosch-Econometrics/sarbR?branch=master)
[![](https://img.shields.io/badge/devel%20version-0.1.3-blue.svg)](https://github.com/Stellenbosch-Econometrics/sarbR)

The goal of sarbR is to provide an easy interface to the monthly release of the South African Reserve Bank Quarterly Bulletin data. Although the SARB has many other datasets, the Quarterly Bulletin makes up the bulk of the statistical release. 

At the time of the publication of this package (April 2019), the SARB still has no easy way of accessing the data through an programmatic interface (API). The maintainer/s `sarbR` package aim to fill this role by curating the data automatically from the SARB, updating a dedicated database and giving access to the data through the simple `sarb_code` function. 

*Please be aware:* the data is updated in an automated fashion as soon as a new release is published on the SARB's website.

## Disclaimer

* This package is in no way endorsed or associated with the South African Reserve Bank (SARB).

* Given that no formal API is provided, the maintainers of this package rely on their own infrastructure to collect, curate, clean, maintain an up to date database and give access through a securely built API. 

* Although the greatest care is taken to provide good data, the maintainer/s of this package take no responsibility in the service OR data being supplied.  

# Flow of the package

The package is built around the main `sarb_code` function, with two helper functions. The first providing a way to search for an indicator and its meta information: `search_indicator`. The second function is to request an access token for the API: `token_request`.

### Installation

To install the package

```r
# Install development version from GitHub

remotes::install_github("Stellenbosch-Econometrics/sarbR")
library(sarbR)
```

### Getting a request token

Because the database is maintained on a small server and the maintainer wishes to keep the server protected from malicious conduct, it was decided to implement requests on a token basis. This ensures some measure of security, a bit of analytics on request and hopefuly allows the small server to handle everyones request in an orderly manner.
 
To request a token from the service follow 2 simple steps:

* Step 1: request a token

``` r
token_request()

#> Successful token creation
#> $status
#> [1] 200
#> 
#> $msg
#> [1] "Successful token creation"
#> 
#> $info
#>           address                            token
#> 122.232.34.123 f84sdsfsdce65eege7dbacd93ac3dc073e364
```

* Step 2: add token to environment or options, `usethis::edit_r_environ()`, or set it in your current session using:

```r
options("sarb.token" = "f84sdsfsdce65eege7dbacd93ac3dc073e364")
Sys.setenv("sarb.token" = "f84sdsfsdce65eege7dbacd93ac3dc073e364")
```

### Latest data on database

```r
release_info()
#> [1] "Latest release info: 2020-12-15"
```

### Latest data on database

```r
all_codes()
#># A tibble: 4,316 x 1
#>   code    
#>   <chr>   
#> 1 KBP1000J
#> 2 KBP1000M
#> 3 KBP1005J
#> 4 KBP1005M
#> 5 KBP1006J
#> 6 KBP1006M
#> 7 KBP1007J
#> 8 KBP1007M
#> 9 KBP1008J
#>10 KBP1008M
#># … with 4,306 more rows
```

This way you will not need to send the token along when making a request for data

### sarb_code

The `sarb_code` function is the main function of the package. This functions interacts with a `plumber` API that has access to a MySQL database with the latest quarterly data.

To use request the data, the whole code needs to be provided. As an example, if you would like to reques __Expenditure on gross domestic product__ at __Current prices__ at a __yearly__ frequency, you need to request *KBP6045J*

```r
sarb_code(code = "KBP6045J")
```
Or if the the token is not set as in the above mentioned manner (in the `.Renviron`), then it can be passed along to the function
```r
sarb_code(code = "KBP6045J", token = "f84sdsfsdce65eege7dbacd93ac3dc073e364")
```

### Looking up indicator codes

The SARB provides various series with specific codes linked to a series: KBPXXXX. It can be difficult to know which series you are looking. 

To help you find a specific frequency of a series (Monthly, Quarterly, Yearly) or just look in general for a series on say, GDP, we can use the `search_indicator` function. This function is a convenience wrapper around the `indicator_codes` dataset

Using the description to look for specific series:

``` r
search_indicator(description = "Expenditure")
#> # A tibble: 6 x 7
#>   time_series description_and_vers… series version_description      frequency unit_of_measure code  
#>   <chr>       <S3: glue>            <chr>  <chr>                    <chr>     <chr>           <S3: >
#> 1 KBP6045     Expenditure on gross… C      Constant 2010 prices     K1        RMILL           KBP60…
#> 2 KBP6045     Expenditure on gross… D      Constant 2010 prices. S… K1        RMILL           KBP60…
#> 3 KBP6045     Expenditure on gross… J      Current prices           J1        RMILL           KBP60…
#> 4 KBP6045     Expenditure on gross… K      Current prices           K1        RMILL           KBP60…
#> 5 KBP6045     Expenditure on gross… L      Current prices. Seasona… K1        RMILL           KBP60…
#> 6 KBP6045     Expenditure on gross… Y      Constant 2010 prices     J1        RMILL           KBP60…
```

Look up the time series:

``` r
search_indicator(time_series = "KBP1000")

#> # A tibble: 2 x 7
#>   time_series description_and_version        series version_descript… frequency unit_of_measure code  
#>   <chr>       <S3: glue>                     <chr>  <chr>             <chr>     <chr>           <S3: >
#> 1 KBP1000     South African Reserve Bank li… J      NA                J1        RMILL           KBP10…
#> 2 KBP1000     South African Reserve Bank li… M      NA                M1        RMILL           KBP10…
```

You can also look up a specific series if you know the exact code:

```r
search_indicator(code = "KBP1000J")

#> # A tibble: 2 x 7
#>   time_series description_and_version        series version_descript… frequency unit_of_measure code  
#>   <chr>       <S3: glue>                     <chr>  <chr>             <chr>     <chr>           <S3: >
#> 1 KBP1000     South African Reserve Bank li… J      NA                J1        RMILL           KBP10…
```

The package also includes data that helps you understand the frequency column used in the `indicator_codes` dataset

```r
sarbR::frequency_description

#>   Description                           Frequency
#> 1          D6          Daily - Monday to Saturday
#> 2          W3              Weekly as on Wednesday
#> 3          W6         Weekly - Monday to Saturday
#> 4          M1                             Monthly
#> 5          K1                           Quarterly
#> 6          J1 Annually - 1 January to 31 December
#> 7          J2      Annually - 1 April to 31 March
```


## Dataset requests

If you want to make a specific dataset available through the package, a request can be made through the issues page:

https://github.com/Stellenbosch-Econometrics/sarbR/issues
