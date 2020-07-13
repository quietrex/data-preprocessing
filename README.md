# Loan Prediction System With SAS

The rising popularity of social lending has garnered attention from the business and research world. Social lending has changed the usual ways that individuals can obtain financial assistance by having no collateral. In doing so, it removes the need for common financial auditing to determine individuals’ eligibility for a loan. It also became a rising competition for many financial institutions. Other than that, social lending also provides an attractive investment alternative for investors who would like to diversity their portfolio. Particularly, the interest rate of social lending platforms can often go much higher than most traditional investment options can offer. Nonetheless, the high return of social lending is also associated with high risk as well. Without any regulating bodies, private lenders are not protected from losses should borrowers’ default. Numerous studies have been conducted to enhance the prediction of default through better credit scoring. As most studies have used real-world data that contains large amount of noise and inconsistencies, proper methods in data cleaning is important. The present project cleansed, transformed, and analysed the data set from Lending Club. Several patterns were discovered and discussed.
[Dataset](https://1drv.ms/u/s!AsL_Eh3YhT_QgmukPjClntCwdj96?e=SIpW4u) &nbsp; 

## Steps involved are:
1. Data preprocessing - treatement of missing values, detecting outlier and check for normality issues for each of the variables.
2. Feature Engineering - Discretization of qualititatve values, Merging spare qualitative data.
3. Discussion - Data exploration, visualization.

# How to use the dataset
```
This dataset comprised on 3 main portions.
1. original dataset - dataset/original dataset
	1. LoanStats3a-Upd - selected column for doing preprocessing, outlier detection and transformation

2. pre-processed dataset - dataset/pre-processed dataset - that has been categoried as numerical and categorical datasets
	1. A56_TRANSQUALITATIVE   -  qualitative data after transformed.
	2. A55_TRANSQUANTITATIVE  - quantitative data after transformed.
	3. A44_TRANS(Transformed Dataset) - both qualitative data after transformed.

3. model dataset - dataset/model dataset
	1. Training, testing and predictors dataset to perform logistic regression model

```
