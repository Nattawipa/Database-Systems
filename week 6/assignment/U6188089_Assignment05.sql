
-- Q1 : What are the news 'topic' that that happens in 'China'?
SELECT News.News_ID, News.News_Topic, Place.News_Country
FROM News
INNER JOIN Place ON Place.News_ID = News.News_ID
WHERE Place.News_Country = 'China' 

-- Q2 : What are the news 'topic', 'description' from 'CNN' agency that happens in 'United States'?
SELECT News.News_ID, Place.News_Country, News.News_Topic, Event.News_Description
FROM News
INNER JOIN Place ON Place.News_ID = News.News_ID
INNER JOIN Event ON Event.News_ID = News.News_ID
WHERE News.News_Agency = 'CNN' AND Place.News_Country = 'United States' 

-- Q3 : What is the news 'agency', 'country' that 'David Carnoy' directed on '2021-02-18'?                                
SELECT News.News_ID, News.News_Agency, Place.News_Country, Evidence.News_Director, Date.News_Date 
FROM News
INNER JOIN Place ON Place.News_ID = News.News_ID
INNER JOIN Date ON Date.News_ID = News.News_ID
INNER JOIN Evidence ON Evidence.News_ID = News.News_ID
WHERE Evidence.News_Director = 'David Carnoy' AND Date.News_Date = '2021-02-18'