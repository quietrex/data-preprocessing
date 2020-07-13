proc print data=work.A32_Outlier(obs=10);
var loan_amnt	funded_amnt	term	installment	grade	sub_grade	home_ownership	annual_inc	verification_status	loan_status	purpose	dti	delinq_2yrs	earliest_cr_line	inq_last_6mths;
run;

proc print data=work.A32_OUTLIER(obs=10);
var id open_acc	pub_rec	revol_bal total_acc	new_revol_util	new_pub_rec_bankruptcies new_int_rate	new_emp_length	LogAnnual_Inc	LogFunded_Amnt	SqrtInstallment	LogLoan_Amnt	SqrtOpen_Acc	Sqrt_revol_bal	SqrtTotal_acc;
run;

proc print data=work.a44_trans(obs=10);
var loan_amnt	funded_amnt	term	installment	grade	sub_grade	home_ownership	annual_inc	verification_status	loan_status	purpose	dti	delinq_2yrs	earliest_cr_line	inq_last_6mths	open_acc	pub_rec	revol_bal	total_acc	new_revol_util	new_pub_rec_bankruptcies;
run;

proc print data=work.a44_trans(obs=10);
var 	new_int_rate	new_emp_length	id	LogAnnual_Inc	LogFunded_Amnt	SqrtInstallment	LogLoan_Amnt	SqrtOpen_Acc	Sqrt_revol_bal	SqrtTotal_acc	new_term	new_grade	new_sub_grade	new_home_ownership	new_verification_status	new_loan_status	new_purpose	new_delinq_2yrs	new_inq_last_6mths	new_pub_rec	pub_rec_bankruptcies_transformed;
run;

data work.A33_FeatureEngineering;
set work.A32_OUTLIER;
run;

/* transformation of term*/
data work.A34_Trans;
set work.A33_FeatureEngineering;
if term = '36 months' then new_term = 1;
else if term = '60 months' then new_term = 2;
else new_term = 0;
run;

proc print data=work.A34_Trans(obs=20);
var term new_term;
title 'Transformation of term (36/60 months) to 1 and 2';
run;

/* transformation of grade */

data work.A35_Trans;
set work.A34_Trans;
if grade = 'A' then new_grade = 1;
else if grade = 'B' then new_grade = 2;
else if grade = 'C' then new_grade = 3;
else if grade = 'D' then new_grade = 4;
else if grade = 'E' then new_grade = 5;
else if grade = 'F' then new_grade = 6;
else if grade = 'G' then new_grade = 7;
else new_grade = 8;
RUN;

proc print data=work.A35_Trans(obs=20);
var grade new_grade;
title 'Transformation of Grade (A-G) to 1-7';
run;

/* transformation of sub_grade */

data work.A36_Trans;
set work.A35_Trans;
if sub_grade = 'A1' then new_sub_grade = 1;
else if sub_grade = 'A2' then new_sub_grade = 2;
else if sub_grade = 'A3' then new_sub_grade = 3;
else if sub_grade = 'A4' then new_sub_grade = 4;
else if sub_grade = 'A5' then new_sub_grade = 5;

else if sub_grade = 'B1' then new_sub_grade = 6;
else if sub_grade = 'B2' then new_sub_grade = 7;
else if sub_grade = 'B3' then new_sub_grade = 8;
else if sub_grade = 'B4' then new_sub_grade = 9;
else if sub_grade = 'B5' then new_sub_grade = 10;

else if sub_grade = 'C1' then new_sub_grade = 11;
else if sub_grade = 'C2' then new_sub_grade = 12;
else if sub_grade = 'C3' then new_sub_grade = 13;
else if sub_grade = 'C4' then new_sub_grade = 14;
else if sub_grade = 'C5' then new_sub_grade = 15;

else if sub_grade = 'D1' then new_sub_grade = 16;
else if sub_grade = 'D2' then new_sub_grade = 17;
else if sub_grade = 'D3' then new_sub_grade = 18;
else if sub_grade = 'D4' then new_sub_grade = 19;
else if sub_grade = 'D5' then new_sub_grade = 20;

else if sub_grade = 'E1' then new_sub_grade = 21;
else if sub_grade = 'E2' then new_sub_grade = 22;
else if sub_grade = 'E3' then new_sub_grade = 23;
else if sub_grade = 'E4' then new_sub_grade = 24;
else if sub_grade = 'E5' then new_sub_grade = 25;

else if sub_grade = 'F1' then new_sub_grade = 26;
else if sub_grade = 'F2' then new_sub_grade = 27;
else if sub_grade = 'F3' then new_sub_grade = 28;
else if sub_grade = 'F4' then new_sub_grade = 29;
else if sub_grade = 'F5' then new_sub_grade = 30;

else if sub_grade = 'G1' then new_sub_grade = 31;
else if sub_grade = 'G2' then new_sub_grade = 32;
else if sub_grade = 'G3' then new_sub_grade = 33;
else if sub_grade = 'G4' then new_sub_grade = 34;
else if sub_grade = 'G5' then new_sub_grade = 35;
else new_sub_grade = 36;
run;

proc print data=work.A36_Trans(obs=20);
var sub_grade new_sub_grade;
title 'Transformation of each sub_grade (A1-G5) to (1-35) ';
run;

/* transformation of home_ownership */
data work.A37_Trans;
set work.A36_Trans;
if home_ownership = 'MORTGAGE' then new_home_ownership = 1;
else if home_ownership = 'NONE' then new_home_ownership = 2;
else if home_ownership = 'OTHER' then new_home_ownership = 3;
else if home_ownership = 'OWN' then new_home_ownership = 4;
else if home_ownership = 'RENT' then new_home_ownership = 5;
else new_home_ownership = 6;
run;

proc print data=work.A37_Trans(obs=20);
var home_ownership new_home_ownership;
title 'Transformation of home_ownership to (1-5)';
run;

/* verification status*/
data work.A38_Trans;
set work.A37_Trans;
if verification_status = 'Not Verified' then new_verification_status = 1;
else if verification_status = 'Source Verified' then new_verification_status = 2;
else if verification_status = 'Verified' then new_verification_status = 3;
else new_verification_status = 4;
run;

proc print data=work.A38_Trans(obs=20);
var verification_status new_verification_status;
title 'Transformation of verification_status to (1-3)';
run;

/* Transformation of loan status*/
data work.A39_Trans;
set work.A38_Trans;
if loan_status = 'Charged Off' then new_loan_status = 1;
else if loan_status = 'Fully Paid' then new_loan_status = 2;
else new_loan_status = 3;
run;

proc print data=work.A39_Trans(obs=20);
var loan_status new_loan_status;
title 'Transformation of loan_status (1-3)';
run;

/* Transformation of purpose*/
data work.A40_Trans;
set work.A39_Trans;
if purpose = 'car' then new_purpose = 1;
else if purpose = 'credit_card' then new_purpose = 2;
else if purpose = 'debt_consolidation' then new_purpose = 3;
else if purpose = 'educational' then new_purpose = 4;
else if purpose = 'home_improvement' then new_purpose = 5;
else if purpose = 'house' then new_purpose = 6;
else if purpose = 'major_purchase' then new_purpose = 7;
else if purpose = 'medical' then new_purpose = 8;
else if purpose = 'moving' then new_purpose = 9;
else if purpose = 'other' then new_purpose = 10;
else if purpose = 'renewable_energy' then new_purpose = 11;
else if purpose = 'small_business' then new_purpose = 12;
else if purpose = 'vacation' then new_purpose = 13;
else if purpose = 'wedding' then new_purpose = 14;
else new_purpose = 15;
run;

proc print data=work.A40_Trans(obs=20);
var purpose new_purpose;
title 'Transformation of purpose to (1-14)';
run;

/* Transformation of Delinq_2yrs */
data work.A41_Trans;
set work.A40_Trans;
if delinq_2yrs = 0 then new_delinq_2yrs = 'Not Delinquent';
else if delinq_2yrs > 0 and delinq_2yrs <= 13 then new_delinq_2yrs = 'Delinquent';
else new_delinq_2yrs = 'n';
run;

proc print data=work.A41_Trans(obs=20);
var delinq_2yrs new_delinq_2yrs;
title 'Transformation of delinq_2yrs';
run;

/* Transformation of Inq_Last_6mths */
data work.A42_Trans;
set work.A41_Trans;
if inq_last_6mths = 0 then new_inq_last_6mths = 'No Inquiries';
else if inq_last_6mths > 0 and inq_last_6mths <= 3 then new_inq_last_6mths = 'Low';
else if inq_last_6mths > 3 and inq_last_6mths <= 33 then new_inq_last_6mths = 'High';
run;

proc print data=work.A42_Trans(obs=20);
var inq_last_6mths new_inq_last_6mths;
title 'Transformation of inq_last_6mths to (No Inquiries, Low, High)';
run;

/* Transformation of pub_rec */
data work.A43_Trans;
set work.A42_Trans;
if pub_rec = 3 then new_pub_rec = 'very bad';
else if pub_rec = 4 then new_pub_rec = 'very bad';
else if pub_rec = 5 then new_pub_rec = 'very bad';
else if pub_rec = 1 then new_pub_rec = 'moderate';
else if pub_rec = 0 then new_pub_rec = 'good';
else if pub_rec = 2 then new_pub_rec = 'bad';
else new_pub_rec = '6';
run;

proc print data=work.A43_Trans(obs=120);
var pub_rec new_pub_rec;
title 'Transformation of pub_rec (Good, Moderate, Bad, Very Bad)';
run;

/* Transformation of pub_rec_bankruptcies_transformed */

data work.A44_Trans;
set work.A43_Trans;
if new_pub_rec_bankruptcies = 1 then pub_rec_bankruptcies_transformed = 'Medium';
else if new_pub_rec_bankruptcies = 2 then pub_rec_bankruptcies_transformed = 'High';
else if new_pub_rec_bankruptcies = 0 then pub_rec_bankruptcies_transformed = 'Low';
else pub_rec_bankruptcies_transformed = 'NA';
run;

proc print data=work.A44_Trans(obs=120);
var new_pub_rec_bankruptcies pub_rec_bankruptcies_transformed;
title 'Transformation of pub_rec_bankruptcies to (High, Medium, Low)';
run;

/* Transformed of new_emp_length */
proc print data=work.A10(obs=20);
var emp_length new_emp_length;
title 'Transformation of emp_length to (0-10)';
run;


data work.A55_TransQuantitative;
set work.A44_TRANS;
keep id loan_amnt funded_amnt installment annual_inc dti delinq_2yrs inq_last_6mths open_acc pub_rec
	revol_bal total_acc new_revol_util new_pub_rec_bankruptcies LogAnnual_Inc LogFunded_Amnt SqrtInstallment LogLoan_Amnt SqrtOpen_Acc SqrtTotal_acc
		new_term new_grade new_sub_grade new_home_ownership new_verification_status new_loan_status new_purpose new_emp_length new_int_rate;
run;

data work.A56_TransQualitative;
set work.A44_TRANS;
keep term grade sub_grade home_ownership verification_status loan_status earliest_cr_line new_delinq_2yrs new_inq_last_6mths new_pub_rec pub_rec_bankruptc;
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

