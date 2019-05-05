
## Looking at the input data 
Here is a summary of input data.

    ID                  11500 non-null int64
    Label               11500 non-null int64
    House               11500 non-null int64
    Year                11500 non-null int64
    Month               11500 non-null int64
    Temperature         11500 non-null float64
    Daylight            11500 non-null float64
    EnergyProduction    11500 non-null int64

All the columns have filled with data, it is good.  
Month, Temperature, Daylight have good distribution and it looks good to use as input data.

## Analysys

I have tried SVR and RandomForestRegressor, ElasticNet, XGBRegressor to see which model returns best mape score and also run GridSearchCV to find out best hyper parameters.  
Originally Month is an integer data but I made dummy columns each month to see if I see improvement with it since January and December are next each other but 12 differeces as a number.

## Conclusion 

best mapi score and Regressor
0.133916
 
SVR(C=100, cache_size=200, coef0=0.0, degree=3, epsilon=0.1, gamma=100,
    kernel='rbf', max_iter=-1, shrinking=True, tol=0.001, verbose=False)

Dummy month columns worked and imporoved the score.  


