# sarbR <img src="logo.png" align="right" alt="" width="120" />

[![](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

The goal of sarbR is to provide an easy interface to the monthly release of the South African Reserve Bank Quarterly Bulletin data. Although the SARB has many other datasets, the Quarterly Bulletin makes up the bulk of the statistical release. 

At the time of the publication of this package (April 2019), the SARB still has no easy way of accessing the data through an programmatic interface (API). The maintainer/s `sarbR` package aims to fill this role by curating the data automatically from the SARB, updating a dedicated database and giving access to the data through the simple `sarb_code` function. 

## Disclaimer

Given that no formal API is provided, the maintainers of this package rely on their own infrastructure to collect, curate, clean, maintain an up to date database and give access through a securely built API. 
Although the greatest care is taken to provide good data, the maintainer/s of this package take no responsibility in the service OR data being supplied.  

# Flow of the package

The package is built around the main `sarb_code` function, with two helper functions. The first providing a way to search for an indicator and its meta information: `search_indicator`. The second function is to request an access token for the API: `token_request`.

### Installation


### Getting a request token

Because the database is maintained on a small server and the maintainer wishes to keep the server protected from malicious conduct (to a certain degree - the security setup isn't fort knox), it was decided to implement requests on a token basis. This ensures some measure of security, a bit of analystics on request and hopefuly allows the small server to handle everyones request in an orderly manner.

Once a token has been registered it is allowed to conduct 200 requests a day with a 1 second sleep between requests. This restriction will likely be lifted once workload is established. 

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

* Step 2: add token to environment or options in your `.Rprofile`

```r
options("sarb.token" = "f84sdsfsdce65eege7dbacd93ac3dc073e364")
Sys.setenv("sarb.token" = "f84sdsfsdce65eege7dbacd93ac3dc073e364")
```

This way you will not need to send the token along when making a request for data

### Looking for the correct indicator code

The SARB provides various series with specific codes linked to a series: KBPXXXX. It can be difficult to know which series you are looking. 

To help you find a specific frequency of a series (Monthly, Quarterly, Yearly) or just look in general for a series on say, GDP, we can use the `search_indicator` function. This function is a convenient wrapper around the `indicator_codes` dataset

``` r
## Using the description

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

## Using the code

search_indicator(time_series_code = "KBP1000")

#> # A tibble: 2 x 7
#>   time_series description_and_version        series version_descript… frequency unit_of_measure code  
#>   <chr>       <S3: glue>                     <chr>  <chr>             <chr>     <chr>           <S3: >
#> 1 KBP1000     South African Reserve Bank li… J      NA                J1        RMILL           KBP10…
#> 2 KBP1000     South African Reserve Bank li… M      NA                M1        RMILL           KBP10…
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
