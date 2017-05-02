library(sugaR)

################
# metapi test  #
################

test <- sugaR(name = "metapiTest",
              auth_type = "basic",
              endpoint = NULL)

test$authenticate(user="YOUR-USERNAME",password="",SAVE=TRUE)
test$header("accept","vnd.no.met.data.sources-v0+json")
test$verb("GET")
test$info()


##############
# with cache #
##############
test2 <- sugaR(name = "metapiTest",
              auth_type = "basic",
              endpoint = NULL)
test2$header("accept","vnd.no.met.data.sources-v0+json")
test2$authenticate(CACHE=TRUE)
test2$info()

test2$clearCache()
test2$authenticate(CACHE=TRUE)


############
# POST     #
############
test <- sugaR(name = "metapiTest",
              auth_type = "basic",
              endpoint = NULL)

test$authenticate(user="YOUR-USERNAME",password="",SAVE=TRUE)
test$header("accept","vnd.no.met.data.sources-v0+json")
test$verb("POST")
test$body(data.frame(service="metno_senorge",timeResolution="hourly",variable="precipitaion"),"json")
test$info()
