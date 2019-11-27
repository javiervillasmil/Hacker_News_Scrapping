## Create and save the DataFrames
generate_hackernews_df <- function() {
 
  hackernews_df<-data.frame(Title = title, 
                            Points = point,
                            Comments = comment, 
                            Links = link, 
                            stringsAsFactors = FALSE)
   
   #Set then directory to Data folder
   setwd(here::here('Output'))
   
   #creates a list with the hackernews_df and the url_vector
   l <- list("Hackernews_Scrap" = hackernews_df, "Url_Scrap" = as.data.frame(all_urls))
   
   #writes the excel file
   write.xlsx(l, 
              file = str_c(
                c('HackerNews',
                  '_',
                  as.character(date(Sys.time())),
                  '_',as.character(hour(Sys.time())),
                  as.character(minute(Sys.time())),
                  '.xlsx'),
                collapse =''), 
              colNames = TRUE, borders = "columns")
   
   cat(yellow(paste('EXCEL FILE GENERATED IN:', getwd())))
   
   #Save the directory to ROOT
   setwd(here::here())
   
   #return movies df
   return(hackernews_df)
}


      