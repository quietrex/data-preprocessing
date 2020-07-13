Data loanstat3a;
set LoanSetA1;
run;

proc print data=a1(obs=20);
var purpose;
where purpose is missing;
run;

data A1;
   set work.loanstat3a;
   keep annual_inc delinq_2yrs dti earliest_cr_line emp_length funded_amnt grade home_ownership
   inq_last_6mths installment int_rate loan_status loan_amnt mths_since_last_delinq open_acc purpose pub_rec
   pub_rec_bankruptcies revol_bal revol_util verification_status sub_grade term total_acc;
   
run;

data A2;
set work.A1;
run;

/* Removing earliest_cr_line with zero */
data A2;
   set work.LoanSetA1;
   keep annual_inc delinq_2yrs dti earliest_cr_line emp_length funded_amnt grade home_ownership
   inq_last_6mths installment int_rate loan_status loan_amnt mths_since_last_delinq open_acc purpose pub_rec
   pub_rec_bankruptcies revol_bal revol_util revol_util verification_status sub_grade term total_acc;
   where earliest_cr_line is not missing;
   run;

/* 1. revol utilization*/
data work.A3;
set work.A2;
   temp_revol_util = input(compress(revol_util, '%'), 8.);
run;

data WORK.A4;
set WORK.A3;
if missing(revol_util) and sub_grade = 'A1' then new_revol_util = 19.72;
else if missing(revol_util) and sub_grade = 'A2' then new_revol_util = 22.45;
else if missing(revol_util) and sub_grade = 'A3' then new_revol_util = 26.48;
else if missing(revol_util) and sub_grade = 'A4' then new_revol_util = 33.42;
else if missing(revol_util) and sub_grade = 'A5' then new_revol_util = 36.39;

else if missing(revol_util) and sub_grade = 'B1' then new_revol_util = 41.34;
else if missing(revol_util) and sub_grade = 'B2' then new_revol_util = 42.70;
else if missing(revol_util) and sub_grade = 'B3' then new_revol_util = 46.15;
else if missing(revol_util) and sub_grade = 'B4' then new_revol_util = 47.37;
else if missing(revol_util) and sub_grade = 'B5' then new_revol_util = 51.17;

else if missing(revol_util) and sub_grade = 'C1' then new_revol_util = 54.50;
else if missing(revol_util) and sub_grade = 'C2' then new_revol_util = 55.95;
else if missing(revol_util) and sub_grade = 'C3' then new_revol_util = 54.01;
else if missing(revol_util) and sub_grade = 'C4' then new_revol_util = 57.40;
else if missing(revol_util) and sub_grade = 'C5' then new_revol_util = 58.75;

else if missing(revol_util) and sub_grade = 'D1' then new_revol_util = 62.65;
else if missing(revol_util) and sub_grade = 'D2' then new_revol_util = 61.34;
else if missing(revol_util) and sub_grade = 'D3' then new_revol_util = 61.17;
else if missing(revol_util) and sub_grade = 'D4' then new_revol_util = 62.47;
else if missing(revol_util) and sub_grade = 'D5' then new_revol_util = 62.71;

else if missing(revol_util) and sub_grade = 'E1' then new_revol_util = 64.20;
else if missing(revol_util) and sub_grade = 'E2' then new_revol_util = 66.49;
else if missing(revol_util) and sub_grade = 'E3' then new_revol_util = 67.74;
else if missing(revol_util) and sub_grade = 'E4' then new_revol_util = 67.23;
else if missing(revol_util) and sub_grade = 'E5' then new_revol_util = 68.43;

else if missing(revol_util) and sub_grade = 'F1' then new_revol_util = 66.61;
else if missing(revol_util) and sub_grade = 'F2' then new_revol_util = 70.15;
else if missing(revol_util) and sub_grade = 'F3' then new_revol_util = 69.48;
else if missing(revol_util) and sub_grade = 'F4' then new_revol_util = 70.13;
else if missing(revol_util) and sub_grade = 'F5' then new_revol_util = 71.06;

else if missing(revol_util) and sub_grade = 'G1' then new_revol_util = 68.42;
else if missing(revol_util) and sub_grade = 'G2' then new_revol_util = 72.53;
else if missing(revol_util) and sub_grade = 'G3' then new_revol_util = 75.17;
else if missing(revol_util) and sub_grade = 'G4' then new_revol_util = 72.95;
else if missing(revol_util) and sub_grade = 'G5' then new_revol_util = 69.55;
else new_revol_util = temp_revol_util;
run;

/* 2. Desc*/
data work.A5;
set work.A4;
if not missing(desc) then new_desc = desc;
else new_desc = purpose;
run;

/* 3. pub_rec_bankruptcies*/
data work.A6;
set work.A5;
if missing(pub_rec_bankruptcies) and pub_rec = 0 then new_pub_rec_bankruptcies = 0;
else if missing(pub_rec_bankruptcies) and pub_rec = 1 then new_pub_rec_bankruptcies = 1;
else if missing(pub_rec_bankruptcies) and pub_rec = 2 then new_pub_rec_bankruptcies = 0;
else if missing(pub_rec_bankruptcies) and pub_rec = 3 then new_pub_rec_bankruptcies = 0;
else if missing(pub_rec_bankruptcies) and pub_rec = 4 then new_pub_rec_bankruptcies = 0;
else if missing(pub_rec_bankruptcies) and pub_rec = 5 then new_pub_rec_bankruptcies = 0;
else if pub_rec > 5 then new_pub_rec_bankruptcies = 0;
else new_pub_rec_bankruptcies = pub_rec_bankruptcies;
run;

/* mths_since_last_delinq */
/* not consider mths_since_last_delinq > 60% missing*/

data work.A7;
set work.A6;
keep annual_inc delinq_2yrs dti earliest_cr_line emp_length funded_amnt grade home_ownership
   inq_last_6mths installment int_rate loan_status loan_amnt open_acc purpose pub_rec
   new_pub_rec_bankruptcies revol_bal new_revol_util verification_status sub_grade term total_acc;
run;

data work.A8;
set work.A7;
   new_int_rate = input(compress(int_rate, '%'), 8.);
run;

data work.A9;
set work.A8;
if emp_length = '< 1 year' then temp_emp_length = 0;
else if emp_length = '1 year' then temp_emp_length = 1;
else if emp_length = '2 years' then temp_emp_length = 2;
else if emp_length = '3 years' then temp_emp_length = 3;
else if emp_length = '4 years' then temp_emp_length = 4;
else if emp_length = '5 years' then temp_emp_length = 5;
else if emp_length = '6 years' then temp_emp_length = 6;
else if emp_length = '7 years' then temp_emp_length = 7;
else if emp_length = '8 years' then temp_emp_length = 8;
else if emp_length = '9 years' then temp_emp_length = 9;
else if emp_length = '10+ years' then temp_emp_length = 10;
else if emp_length = 'n/a' or missing(emp_length) then temp_emp_length = '';
run;

data work.A10;
set work.A9;
if missing(temp_emp_length) and (annual_inc >= 1896 and annual_inc <= 39999) then new_emp_length = 4;
else if missing(temp_emp_length) and (annual_inc >= 40000 and annual_inc <= 58979.28) then new_emp_length = 5;
else if missing(temp_emp_length) and (annual_inc >= 59000 and annual_inc <= 82404) then new_emp_length = 5;
else if missing(temp_emp_length) and (annual_inc >= 82420 and annual_inc <= 6000000) then new_emp_length = 6;
else new_emp_length = temp_emp_length;
run;

data work.A11;
set work.A10;
keep annual_inc delinq_2yrs dti earliest_cr_line funded_amnt grade home_ownership
   inq_last_6mths installment new_int_rate loan_status loan_amnt open_acc purpose pub_rec
   new_pub_rec_bankruptcies revol_bal new_revol_util verification_status sub_grade term total_acc new_emp_length;
run;

proc print data=work.a11(obs=10);
var loan_amnt funded_amnt installment annual_inc dti revol_bal total_acc new_revol_util new_int_rate open_acc; 
run;

proc print data=work.a11(obs=10);
var term grade sub_grade home_ownership verification_status loan_status purpose delinq_2yrs earliest_cr_line inq_last_6mths 
pub_rec new_pub_rec_bankruptcies new_emp_length;
run;

data work.A12A;
set work.A11;
keep term grade sub_grade home_ownership verification_status loan_status purpose delinq_2yrs earliest_cr_line inq_last_6mths 
open_acc pub_rec new_pub_rec_bankruptcies new_emp_length;
run;

data work.A12B;
set work.A11;
keep term grade sub_grade home_ownership verification_status loan_status purpose delinq_2yrs earliest_cr_line inq_last_6mths 
open_acc pub_rec new_pub_rec_bankruptcies;
run;

proc print data=work.A12A(obs=10);
title 'Set A';
var loan_amnt funded_amnt installment annual_inc dti revol_bal total_acc new_revol_util new_int_rate new_emp_length; 
run;

proc print data=work.A12B(obs=10);
title 'Set B';
var term grade sub_grade home_ownership verification_status loan_status purpose delinq_2yrs earliest_cr_line inq_last_6mths 
open_acc pub_rec new_pub_rec_bankruptcies;
run;










data work.A12Quantitative;
set work.A11;
keep annual_inc delinq_2yrs dti funded_amnt inq_last_6mths installment new_int_rate loan_amnt 
   open_acc pub_rec new_pub_rec_bankruptcies revol_bal new_revol_util total_acc new_emp_length; 
run;

data work.A13Qualitative;
set work.A11;
keep grade home_ownership earliest_cr_line loan_status purpose verification_status sub_grade term;
run;


/* plot univariate*/
proc UNIVARIATE DATA=WORK.A12QUANTITATIVE;
var annual_inc delinq_2yrs dti funded_amnt inq_last_6mths installment new_int_rate loan_amnt 
   open_acc pub_rec new_pub_rec_bankruptcies revol_bal new_revol_util total_acc new_emp_length;
histogram annual_inc delinq_2yrs dti funded_amnt inq_last_6mths installment new_int_rate loan_amnt 
   open_acc pub_rec new_pub_rec_bankruptcies revol_bal new_revol_util total_acc new_emp_length /NORMAL (MU=est sigma=est);
probplot annual_inc delinq_2yrs dti funded_amnt inq_last_6mths installment new_int_rate loan_amnt 
   open_acc pub_rec new_pub_rec_bankruptcies revol_bal new_revol_util total_acc new_emp_length /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

/* Log transformation - Annual_inc*/
Data Work.A14;
SET work.A12QUANTITATIVE;
LogAnnual_Inc = log(log(annual_inc));
Run;

Proc univariate Data=work.A14;
var LogAnnual_Inc;
histogram LogAnnual_Inc /NORMAL (MU=est sigma=est);
probplot LogAnnual_Inc /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

/** **/
Data Work.A15;
SET work.A12QUANTITATIVE;
SqDti = sqrt(dti);
Run;

Proc univariate Data=work.A15;
var SqDti;
histogram SqDti /NORMAL (MU=est sigma=est);
probplot SqDti /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;





proc means data=work.a9 mean median max min;
var temp_emp_length;
where annual_inc >= 1896 and annual_inc <= 39999;
run;

proc means data=work.a9 mean median max min;
var temp_emp_length;
where annual_inc >= 40000 and annual_inc <= 58979.28;
run;

proc means data=work.a9 mean median max min;
var temp_emp_length;
where annual_inc >= 59000 and annual_inc <= 82404;
run;

proc means data=work.a9 mean median max min;
var temp_emp_length;
where annual_inc >= 82420 and annual_inc <= 6000000;
run;

proc freq data=work.a9;
table annual_inc;
run;


proc format;
 value $missfmt ' '='Missing' other='Not Missing';
 value  missfmt  . ='Missing' other='Not Missing';
run;
 
proc freq data=work.b1; 
format _CHAR_ $missfmt.; /* apply format for the duration of this PROC */
tables _CHAR_ / missing missprint nocum nopercent;
format _NUMERIC_ missfmt.;
tables _NUMERIC_ / missing missprint nocum nopercent;
run;

/* loan_amnt */
Proc Sgplot data=work.a27;
vbox LogRevolBal / datalabel=id;
format id 8.;
Run;

Data work.A28;
set Work.A27;
id = _N_;
Run;

Data Work.A29;
SET work.A28;
SqrtRevolBal = sqrt(sqrt(revol_bal));
Run;

Proc univariate Data=work.A29;
var SqrtRevolBal;
histogram SqrtRevolBal /NORMAL (MU=est sigma=est);
probplot SqrtRevolBal /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;





