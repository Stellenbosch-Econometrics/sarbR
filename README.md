# sarbR

The goal of sarbR is to provide an easy interface to the monthly release of the South African Reserve Bank Quarterly Bulletin data. Although the SARB has many other datasets, the Quarterly Bulletin makes up the bulk of the statistical release. 

At the time of the publication of this package (April 2019), the SARB still has no easy way of accessing the data through an programmatic interface (API). The maintainer/s `sarbR` package aims to fill this role by curating the data automatically from the SARB, updating a dedicated database and giving access to the data through the simple `sarb_code` function. 

## Disclaimer

Given that no formal API is provided, the maintainers of this package rely on their own infrastructure to collect, curate, clean, maintain an up to date database and give access through a securely built API. 
Although the greatest care is taken to provide good data, the maintainer/s of this package take no responsibility in the service OR data being supplied.  

# Flow of the package

The package is built around the main `sarb_code` function, with two helper functions. The first providing a way to search for an indicator and its meta information: `search_indicator`. The second function is to request an access token for the API: `token_request`.

# Getting a request token

Because the database is maintained on a small server and the maintainer wishes to keep the server protected from malicious conduct (to a certain degree - the security setup isn't fort knox), it was decided to implement requests on a token basis. This ensures some measure of security, a bit of analystics on request and hopefuly allows the small server to handle everyones request in an orderly manner.

Once a token has been registered it is allowed to conduct 200 requests a day with a 1 second sleep between requests. This restriction will likely be lifted once workload is established. 

To request a token from the service follow 2 simple steps:

* Step 1: request a token

``` r

token_request()

Successful token creation
$status
[1] 200

$msg
[1] "Successful token creation"

$info
          address                            token
122.232.34.123 f84sdsfsdce65eege7dbacd93ac3dc073e364

```

* Step 2: add token to environment or options in your `.Rprofile`

```r
options("sarb.token" = "hashhashhash")
Sys.setenv("sarb.token" = "hashhashhash")
```

This way you will not need to send the token along when making a request for data

## Example

This is a basic example which shows you how to solve a common problem:

``` r
## basic example code
```

# Development guidelines

Use of packages:

``` r
library(devtools)
library(usethis)
library(pkgdown)
library(testthat)
```

 Maybe add some nice message colors with
```r
library(crayon)
cat(crayon::red("This is red"), "\n")
#> This is red
cat(crayon::blue("This is blue\n"), "\n")
#> This is blue
#> 

message(crayon::green("This is green"))
#> This is green

warning(crayon::bold("This is bold"))
#> Warning: This is bold
Some text

stop(crayon::italic("This is italic"))
```

For version control I am using `git flow`

```bash
git flow init

git flow feature start [name]
git add .
git commit -m
git flow feature finish  [name]

git flow hotfix start [name]
git add .
git commit -m
git flow hotfix finish  [name]

# Push to master
git flow release start [name]
git add .
git commit -m
git flow release finish [name]

```
