rm(list=ls(all=TRUE))
library(REDCapR)

uri <- "https://bbmc.ouhsc.edu/redcap/api/"
# uri <- "https://bbmc.ouhsc.edu/redcap/redcap_v5.2.3/API/"
# token <- "0B3702D39ED7658B8236797689679DBF" #wbeasley
token <- "C1A2B36F94B518FDD50561D1FD09170D" #UnitTesttPhiFree
certs <- file.path(devtools::inst("REDCapR"), "ssl_certs/mozilla_ca_root.crt")
# certs <- file.path(devtools::inst("REDCapR"), "ssl_cert/v2.crt")
certs <- list(cainfo = system.file("cacert.pem", package = "httr"))

returned <- redcap_read(redcap_uri=uri, token=token)


raw_text <- RCurl::postForm(
  uri = uri
  , token = token
  , content = 'record'
  , format = 'csv'
  , type = 'flat'
#   , .opts = RCurl::curlOptions(cainfo = certs)
  , .opts = RCurl::curlOptions(ssl.verifypeer = FALSE)
)
try(
  dsTry <- read.csv(text=raw_text, stringsAsFactors=FALSE) #Convert the raw text to a dataset.
)
if( ! exists("dsTry") )
  dsTry <- data.frame()


