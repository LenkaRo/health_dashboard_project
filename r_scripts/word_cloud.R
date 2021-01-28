library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

# The text is loaded using Corpus() function from text mining (tm) package
# Load the text into a so-called corpus, so the tm package can process it
# A corpus is a collection of documents (although in our case we only have one)
text <- Corpus(DirSource("data/word_cloud/"))

# Inspect the content of the document
inspect(text)

# Text transformation
# Transformation is performed using tm_map() function to replace, for example, special characters from the text.
# Replacing “/”, “@” and “|” with space:
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
text <- tm_map(text, toSpace, "/")
text <- tm_map(text, toSpace, "@")
text <- tm_map(text, toSpace, "\\|")

# Cleaning the text - tm_map() function is used to remove unnecessary white space, to convert the text to lower case, to remove common stopwords like ‘the’, “we”
# Convert the text to lower case
text <- tm_map(text, content_transformer(tolower))
# Remove numbers
text <- tm_map(text, removeNumbers)
# Remove english common stopwords
text <- tm_map(text, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
text <- tm_map(text, removeWords, c("fbfs", "blabla")) 
# Remove punctuations
text <- tm_map(text, removePunctuation)
# Eliminate extra white spaces
text <- tm_map(text, stripWhitespace)
# Text stemming
# text <- tm_map(text, stemDocument)

# Build a term-document matrix
# Document matrix is a table containing the frequency of the words
dtm <- TermDocumentMatrix(text)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

# Generate the Word cloud
set.seed(1234)
wordcloud <- wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=100, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))