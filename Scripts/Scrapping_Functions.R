## Scraps the TITLE section
title_scrap <- function(webpage) {
  title_data <- webpage %>%
    html_nodes('.storylink') %>%
    #html_node('') %>%
    html_text()
  title_data <- trimws(gsub('Show HN:','',title_data))
  
  cat(red((paste(length(which(is.na(title_data) == TRUE)),'  MISSING VALUES IN TITLES'))),sep="\n")
  
  return(title_data)
}


## Scraps the POINTS section
point_scrap <- function(webpage) {
  point_data <- webpage %>%
    html_nodes('.score') %>%
    #html_node('.lister-item-header a') %>%
    html_text()
  
  point_data<- as.numeric(gsub('point|points','',point_data))
  cat(blue((paste(length(which(is.na(point_data) == TRUE)),'  MISSING VALUES IN POINTS'))),sep="\n")
  
  return(point_data)
}



## Scraps the COMMENTS section
comment_scrap <- function(webpage) {
  comment_data <- webpage %>%
    html_nodes('.age~ a') %>%
    html_text()
  
  comment_data <- gsub('comment|comments|discuss|','',comment_data)
  comment_data[comment_data == ""] <- 0
  cat(green((paste(length(which(is.na(comment_data) == TRUE)),'  MISSING VALUES IN COMMENTS'))),sep="\n")
  
  return(comment_data)
}


## Scraps the LINK section
link_scrap <- function(webpage) {
  link_data <- webpage %>%
    html_nodes('.storylink') %>%
    html_attr('href')
  
 newurl <- paste('https://news.ycombinator.com/',link_data[grep(pattern = 'item?id',x = link_data, fixed = TRUE)],sep = "")
 
 if (length(newurl) == 1) {
 newwebsite <- read_html(newurl)
 reallink_data <- newwebsite %>%
   html_nodes('tr:nth-child(4) td+ td') %>%
   html_nodes('p a') %>%
   html_text()
  
 link_data[grep(pattern = 'item?id',x = link_data, fixed = TRUE)] <- str_c(reallink_data,collapse = ' ; ')
 } else {
   
   for (e in seq(1,length(newurl),by = 1 )) {
     newwebsite <- read_html(newurl[e])
     reallink_data <- newwebsite %>%
       html_nodes('tr:nth-child(4) td+ td') %>%
       html_nodes('p a') %>%
       html_text()
     
     link_data[grep(pattern = gsub('https://news.ycombinator.com/',"",newurl[e]) ,x = link_data, fixed = TRUE)] <- str_c(reallink_data,collapse = ' ; ')
     
   }
   
 }
 
 cat(yellow((paste(length(which(is.na(link_data) == TRUE)),'  MISSING VALUES IN LINK'))),sep="\n")
  
  return(link_data)
}


