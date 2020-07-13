Data work.A15_Outlier;
set work.A11;
id = _N_;
Run;

/* annual_inc */
Proc Sgplot data=A15_Outlier;
vbox annual_inc / datalabel=id;
format id 8.;
title 'Box plot for annual income';
Run;

Proc univariate Data=work.A15_Outlier;
var annual_inc;
histogram annual_inc /NORMAL (MU=est sigma=est);
probplot annual_inc /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

Data Work.A16_Outlier;
SET work.A15_Outlier;
LogAnnual_Inc = log(annual_inc);
Run;

Proc univariate Data=work.A16_Outlier;
var LogAnnual_Inc;
histogram LogAnnual_Inc /NORMAL (MU=est sigma=est);
probplot LogAnnual_Inc /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

Proc Sgplot data=A16_Outlier;
vbox LogAnnual_Inc / datalabel=id;
format id 8.;
title 'Box plot for LogAnnual_Inc';
Run;

data A17_Outlier;
set A16_Outlier;
if LogAnnual_Inc >= 11.87757 then LogAnnual_Inc = 11.87757;
else LogAnnual_Inc = LogAnnual_Inc;
run;

data A18_Outlier;
set A17_Outlier;
if LogAnnual_Inc <= 10.08581 then LogAnnual_Inc = 10.08581;
else LogAnnual_Inc = LogAnnual_Inc;
run;

Proc Sgplot data=A18_Outlier;
vbox LogAnnual_Inc / datalabel=id;
format id 8.;
title 'Box plot for LogAnnual_Inc - After replaced extreme values';
Run;

/* dti */
Proc Sgplot data=A18_Outlier;
vbox dti / datalabel=id;
format id 8.;
title 'Box plot for dti';
Run;

Proc univariate Data=work.A18_Outlier;
var dti;
histogram dti /NORMAL (MU=est sigma=est);
probplot dti /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

/* funded_amnt*/
Proc Sgplot data=A18_Outlier;
vbox funded_amnt / datalabel=id;
format id 8.;
title 'Box plot for funded_amnt';
Run;

Proc univariate Data=work.A18_Outlier;
var funded_amnt;
histogram funded_amnt /NORMAL (MU=est sigma=est);
probplot funded_amnt /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

Data Work.A19_Outlier;
SET work.A18_Outlier;
LogFunded_Amnt = log(funded_amnt);
Run;

Proc univariate Data=work.A19_Outlier;
var LogFunded_Amnt;
histogram LogFunded_Amnt /NORMAL (MU=est sigma=est);
probplot LogFunded_Amnt /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

Proc Sgplot data=A19_Outlier;
vbox LogFunded_Amnt / datalabel=id;
format id 8.;
title 'Box plot for LogFunded_Amnt - Before replacing';
Run;

data work.A20_Outlier;
set work.A19_Outlier;
if LogFunded_Amnt <= 7.74066 then LogFunded_Amnt = 7.74066;
else LogFunded_Amnt = LogFunded_Amnt;
run;

Proc Sgplot data=A20_Outlier;
vbox LogFunded_Amnt / datalabel=id;
format id 8.;
title 'Box plot for LogFunded_Amnt - After replaced extreme 5% value';
Run;

Proc univariate Data=work.A20_Outlier;
var LogFunded_Amnt;
histogram LogFunded_Amnt /NORMAL (MU=est sigma=est);
probplot LogFunded_Amnt /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

/* installment*/
Proc Sgplot data=A20_Outlier;
vbox installment / datalabel=id;
format id 8.;
title 'Box plot for instalment';
Run;

Proc univariate Data=work.A20_Outlier;
var installment;
histogram installment /NORMAL (MU=est sigma=est);
probplot installment /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

Data Work.A21_Outlier;
SET work.A20_Outlier;
SqrtInstallment = sqrt(installment);
Run;

Proc univariate Data=work.A21_Outlier;
var SqrtInstallment;
histogram SqrtInstallment /NORMAL (MU=est sigma=est);
probplot SqrtInstallment /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

Proc Sgplot data=A21_Outlier;
vbox SqrtInstallment / datalabel=id;
format id 8.;
title 'Box plot for instalment - After squared';
Run;

data A22_Outlier;
set A21_Outlier;
if SqrtInstallment >= 27.60580 then SqrtInstallment = 27.60580;
else SqrtInstallment = SqrtInstallment;
run;

Proc Sgplot data=A22_Outlier;
vbox SqrtInstallment / datalabel=id;
format id 8.;
title 'Box plot for instalment - After squared (after replacing extreme value > 95%)';
Run;

/* new_int_rate*/
Proc Sgplot data=A22_Outlier;
vbox new_int_rate / datalabel=id;
format id 8.;
title 'Box plot for new_int_rate';
Run;

Proc univariate Data=work.A22_Outlier;
var new_int_rate;
histogram new_int_rate /NORMAL (MU=est sigma=est);
probplot new_int_rate /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

data A23_Outlier;
set A22_Outlier;
if new_int_rate >= 18.62 then new_int_rate = 18.62;
else new_int_rate = new_int_rate;
run;

Proc Sgplot data=A23_Outlier;
vbox new_int_rate / datalabel=id;
format id 8.;
title 'Box plot for new_int_rate (After replacing extreme values over 95%)';
Run;

/* loan_amnt */
Proc Sgplot data=A23_Outlier;
vbox loan_amnt / datalabel=id;
format id 8.;
title 'Box plot for loan_amnt';
Run;

Proc univariate Data=work.A23_Outlier;
var loan_amnt;
histogram loan_amnt /NORMAL (MU=est sigma=est);
probplot loan_amnt /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

Data Work.A24_Outlier;
SET work.A23_Outlier;
LogLoan_Amnt = log(loan_amnt);
Run;

Proc univariate Data=work.A24_Outlier;
var LogLoan_Amnt;
histogram LogLoan_Amnt /NORMAL (MU=est sigma=est);
probplot LogLoan_Amnt /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

Proc Sgplot data=A24_Outlier;
vbox LogLoan_Amnt / datalabel=id;
format id 8.;
title 'Box plot for LogLoan_Amnt';
Run;

data A25_Outlier;
set A24_Outlier;
if LogLoan_Amnt <= 7.78322 then LogLoan_Amnt = 7.78322;
else LogLoan_Amnt = LogLoan_Amnt;
run;

Proc Sgplot data=A25_Outlier;
vbox LogLoan_Amnt / datalabel=id;
format id 8.;
title 'Box plot for LogLoan_Amnt (After replacing extreme values ranged less than 5%)';
Run;

/* open_acc*/
Proc Sgplot data=A25_Outlier;
vbox open_acc / datalabel=id;
format id 8.;
title 'Box plot for open_acc';
Run;

Proc univariate Data=work.A25_Outlier;
var open_acc;
histogram open_acc /NORMAL (MU=est sigma=est);
probplot open_acc /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

Data Work.A26_Outlier;
SET work.A25_Outlier;
SqrtOpen_Acc = sqrt(sqrt(open_acc));
Run;

Proc univariate Data=work.A26_Outlier;
var SqrtOpen_Acc;
histogram SqrtOpen_Acc /NORMAL (MU=est sigma=est);
probplot SqrtOpen_Acc /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

Proc Sgplot data=A26_Outlier;
vbox SqrtOpen_Acc / datalabel=id;
format id 8.;
title 'Box plot for SqrtOpen_Acc';
Run;

data A26_Outlier1;
set A26_Outlier;
if SqrtOpen_Acc >= 2.05977 then SqrtOpen_Acc = 2.05977;
else SqrtOpen_Acc = SqrtOpen_Acc;
run;

Proc Sgplot data=A26_Outlier1;
vbox SqrtOpen_Acc / datalabel=id;
format id 8.;
title 'Box plot for SqrtOpen_Acc (After replacing extreme values ranged more than 95%)';
Run;

data A27_Outlier;
set A26_Outlier1;
if SqrtOpen_Acc <= 1.31607 then SqrtOpen_Acc = 1.31607;
else SqrtOpen_Acc = SqrtOpen_Acc;
run;

Proc Sgplot data=A27_Outlier;
vbox SqrtOpen_Acc / datalabel=id;
format id 8.;
title 'Box plot for SqrtOpen_Acc (After replacing extreme values ranged less than 5%)';
Run;

/* Revol balance*/
Proc Sgplot data=A27_Outlier;
vbox revol_bal / datalabel=id;
format id 8.;
title 'Box plot for revol_bal';
Run;

Proc univariate Data=work.A27_Outlier;
var revol_bal;
histogram revol_bal /NORMAL (MU=est sigma=est);
probplot revol_bal /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

Data Work.A28_Outlier;
SET work.A27_Outlier;
Sqrt_revol_bal = sqrt(sqrt(open_acc));
Run;

Proc univariate Data=work.A28_Outlier;
var Sqrt_revol_bal;
histogram Sqrt_revol_bal /NORMAL (MU=est sigma=est);
probplot Sqrt_revol_bal /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

Proc Sgplot data=A28_Outlier;
vbox Sqrt_revol_bal / datalabel=id;
format id 8.;
title 'Box plot for Sqrt_revol_bal';
Run;

data A29_Outlier;
set A28_Outlier;
if Sqrt_revol_bal >= 2.05977 then Sqrt_revol_bal = 2.05977;
else Sqrt_revol_bal = Sqrt_revol_bal;
run;

Proc Sgplot data=A29_Outlier;
vbox Sqrt_revol_bal / datalabel=id;
format id 8.;
title 'Box plot for Sqrt_revol_bal (After replacing extreme values ranged more than 95%)';
Run;

data A30_Outlier;
set A29_Outlier;
if Sqrt_revol_bal <= 1.31607 then Sqrt_revol_bal = 1.31607;
else Sqrt_revol_bal = Sqrt_revol_bal;
run;

Proc Sgplot data=A30_Outlier;
vbox Sqrt_revol_bal / datalabel=id;
format id 8.;
title 'Box plot for Sqrt_revol_bal (After replacing extreme values ranged less than 5%)';
Run;

/* new_revol_util */
Proc Sgplot data=A30_Outlier;
vbox new_revol_util / datalabel=id;
format id 8.;
title 'Box plot for new_revol_util';
Run;

Proc univariate Data=work.A30_Outlier;
var new_revol_util;
histogram new_revol_util /NORMAL (MU=est sigma=est);
probplot new_revol_util /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

/* total_acc*/
Proc Sgplot data=A30_Outlier;
vbox total_acc / datalabel=id;
format id 8.;
title 'Box plot for total_acc';
Run;

Proc univariate Data=work.A30_Outlier;
var total_acc;
histogram total_acc /NORMAL (MU=est sigma=est);
probplot total_acc /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

Data Work.A31_Outlier;
SET work.A30_Outlier;
SqrtTotal_acc = sqrt(total_acc);
Run;

Proc univariate Data=work.A31_Outlier;
var SqrtTotal_acc;
histogram SqrtTotal_acc /NORMAL (MU=est sigma=est);
probplot SqrtTotal_acc /NORMAL (MU=est sigma=est);
INSET skewness kurtosis;
Run;

Proc Sgplot data=A31_Outlier;
vbox SqrtTotal_acc / datalabel=id;
format id 8.;
title 'Box plot for SqrtTotal_acc';
Run;

data A32_Outlier;
set A31_Outlier;
if SqrtTotal_acc >= 6.63325 then SqrtTotal_acc = 6.63325;
else SqrtTotal_acc = SqrtTotal_acc;
run;

Proc Sgplot data=A32_Outlier;
vbox SqrtTotal_acc / datalabel=id;
format id 8.;
title 'Box plot for SqrtTotal_acc (After replacing extreme values ranged more than 95%)';
Run;

proc print data=work.A32_Outlier(obs=10);
var loan_amnt	funded_amnt	term	installment	grade	sub_grade	home_ownership	annual_inc	verification_status	loan_status	purpose	dti	delinq_2yrs	earliest_cr_line	inq_last_6mths;
run;

proc print data=work.A32_OUTLIER(obs=10);
var id open_acc	pub_rec	revol_bal total_acc	new_revol_util	new_pub_rec_bankruptcies new_int_rate	new_emp_length	LogAnnual_Inc	LogFunded_Amnt	SqrtInstallment	LogLoan_Amnt	SqrtOpen_Acc	Sqrt_revol_bal	SqrtTotal_acc;
run;
