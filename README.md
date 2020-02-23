# Ship Valuation using Multiple Linear Regression
Used R for valuation of a ship. The estimated price came out to be ~130 million USD as per the model.
Initial data exploration done using correlation analysis. Feature Extraction done to remove multi collinearity. BIC metric used for model validation. R squared ~90%.

# Hypothesis
 
On eyeballing the ship data, we found that some variables had a greater impact on its price while some could be ignored for calculat-ing the ship price.
 
Some initial findings:
1. In general, there was a downward trend of average price as we increased the age, but there were few pockets (Ships aged 18-19, 14-15) that were off. On an average, ships having a sale price equal to or more than 100 million are aged less than 10 years with a few exceptions. 
2. Analyzed the relationship between deadweight ton with the price. We assumed that more DWT (i.e. more capacity valued if they weigh in the range of 170-175 DWT (Ex-hibit B). This might be because of better fuel efficiency of this deadweight class or because of some other variables affecting the price. 

3. Baltic-dry capesize index values in-creased by approximately by 169% in the given time frame. Although we knew that this cannot be the sole criteria determin-ing the ship price, it had to be one of the key factors. We considered two sets of ships to verify the relation of capesize index with ship price keeping other vari-ables like age and DWT almost similar.  Analysis indicated that similar ships were sold for more if the capesize index value was more.


