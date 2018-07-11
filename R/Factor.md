# Factor

#### 1. Changing the labels of factor levels

```R
GSS$BaseLaborStatus <- GSS$LaborStatus
levels(GSS$BaseLaborStatus)

## [1] "Keeping house" "No answer" "Other"
## [4] "Retired" "School" "Temp not working"
## [7] "Unempl, laid off" "Working fulltime" "Working parttime"

summary(GSS$BaseLaborStatus)

## Keeping house  No answer  Other  Retired
##      263           2       76      460
## School  Temp not working  Unempl, laid off  Working fulltime
##   90          40                104              1230
## Working parttime  NA's
##       273          2
```

**Direct and robust**

> `recode()`
>
> ```R
> GSS <- GSS %>%
> 	mutate(tidyLaborStatus =
> 		recode(LaborStatus,
> 		`Temp not working` = "Temporarily not working",
> 		`Unempl, laid off` = "Unemployed, laid off",
> 		`Working fulltime` = "Working full time",
> 		`Working parttime ` = "Working part time"))
> summary(GSS$tidyLaborStatus)
> 
> ## Keeping house  No answer  Other
> ##       263          2       76
> ## Retired  School  Temporarily not working
> ##   460      90               40
> ## Unemployed, laid off  Working full time  Working parttime
> ##         104                  1230              273
> ## NA's
> ## 2
> ```

  > `trimws()`
  >
  > ```R
  > gender <- factor(c("male ", "male ", "male ", "male"))
  > levels(gender)
  > 
  > ## [1] "male" "male " "male " "male "
  > 
  > gender <- factor(trimws(gender))
  > levels(gender)
  > 
  > ## [1] "male"
  > ```

#### 2. Reordering factor levels

```R
GSS$BaseOpinionOfIncome <- GSS$OpinionOfIncome
summary(GSS$BaseOpinionOfIncome )

## Above average  Average  Below average  Don't know
##     483         1118         666           21
## Far above average  Far below average  No answer  NA's
##        65                179              6        2
```

> `fct_relevel() `
>
> ```R
> GSS <- GSS %>%
> 	mutate(tidyOpinionOfIncome =
> 		fct_relevel(OpinionOfIncome,
> 		"Far above average",
> 		"Above average",
> 		"Average",
> 		"Below average",
> 		"Far below average"))
> ```
>
> Result:
>
> ```R
> summary(GSS$tidyOpinionOfIncome)
> 
> ## Far above average  Above average  Average  Below average
> ##       65                483        1118        666
> ## Far below average  Don't know  No answer  NA's
> ##      179               21          6       2
> ```

#### 3. Combining several levels into one (both string-like labels and numeric)

##### 3.1 Combining discrete levels

```R
summary(GSS$BaseMarital)

## Divorced  Married  Never married  No answer  Separated
##   411       1158        675          4          81
## Widowed  NA's
##   209      2
```

> `recode()`
>
> ```R
> GSS <- GSS %>%
> 	mutate(tidyMaritalStatus = recode(MaritalStatus,
> 		Divorced = "Not married",
> 		`Never married` = "Not married",
> 		Widowed = "Not married",
> 		Separated = "Not married"))
> summary(GSS$tidyMaritalStatus)
> 
> ## Not married  Married  No answer  NA's
> ##    1376        1158       4       2
> ```

##### 3.2 Combining numeric-type levels

![Imgur](https://i.imgur.com/bRbPCl6.png)

> `parse_number()` `if_else()`
>
> ```R
> library(readr)
> GSS <- GSS %>%
> 	mutate(tidyAge = parse_number(Age)) %>%
> 	mutate(tidyAge = if_else(tidyAge < 65, "18-65", "65 and up"),
> 		   tidyAge = factor(tidyAge))
> summary(GSS$tidyAge)
> 
> ## 18-65  65 and up  NA's
> ## 2011      518      11
> ```


#### 4. Making derived factor variables

![Imgur](https://i.imgur.com/2rUQh13.png)

Make one value missing before wrangling.(dataset has no NA, to ensure the code is correct)

```R
data(HELPmiss)
HELPsmall <- HELPmiss %>%
	mutate(i1 = ifelse(id == 1, NA, i1)) %>% # make one value missing
	select(sex, i1, i2, age)
head(HELPsmall, 2)

##    sex i1 i2 age
## 1 male NA 26 37
## 2 male 56 62 37
```

> `case_when()`
>
> ```R
> HELPsmall <- HELPsmall %>%
> 	mutate(drink_stat = case_when(
> 		i1 == 0 ~ "abstinent",
> 		i1 <= 1 & i2 <= 3 & sex == 'female' ~ "moderate",
> 		i1 <= 1 & i2 <= 3 & sex == 'male' & age >= 65 ~ "moderate",
> 		i1 <= 2 & i2 <= 4 & sex == 'male' ~ "moderate",
> 		is.na(i1) ~ "missing", # can't put NA in place of "missing"
> 		TRUE ~ "highrisk"
> ))
> HELPsmall %>%
> 	group_by(drink_stat) %>%
> 	dplyr::count()
> ## # A tibble: 4 x 2
> ## # Groups: drink_stat [4]
> ## drink_stat n
> ## <chr> <int>
> ## 1 abstinent 69
> ## 2 highrisk 372
> ## 3 missing 1
> ## 4 moderate 28
> ```

#### [ 5. Defensive coding ]

Check if the code works as we expected.

> * Check there are exactly three levels
>
>   ```R
>   library(assertthat)
>   levels(drinkstat)
>   
>   ## [1] "abstinent" "highrisk" "moderate"
>   
>   assert_that(length(levels(drinkstat)) == 3)
>   
>   ## [1] TRUE
>   ```
>
> * Ensure the factor labels are exactly what we were expecting, and are in the same order
>
>   ```R
>   library(testthat)
>   levels(GSS$Sex)
>   
>   ## [1] "Female" "Male"
>   
>   expect_equivalent(levels(GSS$Sex), c("Female", "Male"))
>   ```
>
> *  checking without relying on order
>
>   ```R
>   expect_setequal(levels(GSS$Sex), c("Male", "Female"))
>   ```