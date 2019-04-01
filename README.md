# sarbR

The goal of sarbR is to ...

# Getting auth token

get_token()

token restrictions to 100 calls an hour (until server load can be determined)

* remember to set environment the token:

``` r
Sys.setenv(sarbR_token = "hashhashhash")
```

* regulate access by adding token to mysql DB everytime a call is made timestamp + IP
- key token and IP combinations 

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
