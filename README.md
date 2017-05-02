# sugaR

[![Travis-CI Build Status](https://travis-ci.org/jeanmarielepioufle/timeManip.svg?branch=master)](https://travis-ci.org/jeanmarielepioufle/sugaR)

sugaR helps you in settling handle of request for remote services (thredds, ... etc).

Output handle is ready as input into any packages such as puddingR, curl, ... etc.

## Installation

```R
# install.packages("devtools")
devtools::install_github("jeanmarielepioufle/sugaR")
```

## Usage

```R
library(sugaR)

h <- sugaR(name = "test",auth_type = "none", endpoint = NULL)

h$authenticate()
h$verb("POST")
h$header("accept","json")
h$body(list(x="A simple text string"),"json")
h$info()

```

I am working on making a vignette.

## Questions and remarks
Don't hesitate to contact me for more details and suggestions.
