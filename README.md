# élelmiszer MAD
MAD utilizes distinct features from IBM watson using R and Python and display latest trends,statistics from social media accounts

### Few words from Andrew Zimmern a food traveler and critic. 
       
>I think Yelp is neither good nor bad for the food industry. I find it useless. 
>If you're aggregating a lack of expertise, then   when I plug in “best sushi bar in Los Angeles,” Yelp doesn't help me at all.
>So, if you are a huge food geek like me that really believes in quality — not expensive food, just quality.
>Above all other things — quality. If you're into quality, Yelp is not for you.

>Zimmern says that when he’s looking for something good to eat in a city he’s visiting, 
>he checks out the Twitter and Instagram feeds of local food writers and chefs to find out the places and dishes that 
>they’re obsessing over, and he builds his list from there. 
		
>The author/TV host also remarks: “Yelp’s not even good for looking up the restaurant’s phone number because you know on the site, 
>they just want you to read their reviews and look at their ads.

## Problem statement:
As it was mentioned, considering reviews from one source to get information regarding the local delicacies, is not much trustworthy
Most of us who walk in the shoes of Mr. Zimmern try to collect information from as many sources as possible.

## Proposed solution: 
Through this application, we are trying to utilize the data from three different sources YELP , TWITTER and INSTAGRAM analyze the data and gain insights.

## Approaching the problem: 

* Analyze text based on what the user has searched for in the textbox "What food are you in mood for today?".
The text is either fed as a Hashtag/term/user in the twitter. 
Metadata such as  entities, keywords, categories, relations and semantic roles, sentiment and emotion are extracted from the content as they provide insights on tweets posted in the Twitter. 
After verifying whether the posted term is in a tweet and belong to the category "Food",  which is one of the primary categories in IBM Watson's category classifier, we filter and approximate the location , keywords familiar or tag along with the searched term. 

* Similarly gathering the data from Yelp through the API available, gather reviews based on the restaurant. Since not all reviews are equal in favor of the dish , to weigh the true dish value ,and in loss of expertise reviews we consider many other factors and aggregat them. We search for past tweets/reviews from twitter and yelp respectively posted by food critics. Their reviews are assigned a major weight compared to the other reviews.

* Using the endpoints provided by the Watson API , we can gain personality insights and analyze text for yelp data too.

## Conclusion
The end result would be calculating , if the restaurant or location has been mentioned in any tweet , tweet's emotion and sentiment
if any dish mentioned in yelp in a review , it's emotion , sentiment 

## Limitations to the application





