LIBNAME data2 '/home/u43404064/data2';

data data2.us_companies;
infile  '/home/u43404064/data2/us_companies.sas7bdat';
run;

proc means data= data2.us_companies;
run;

*1B: Revenue, Rev_Growth, Employees, Founded
It does not include all variables, such as 'name';

*1C: I would not include the founded variable, since it's a date;

proc means data = data2.us_companies min median max maxdec=3;
var Revenue Rev_growth employees;
run;


proc means data = data2.us_companies min median max n maxdec=3;
var Revenue Rev_growth employees;
class industry;
run;

*Median revenue for technology companies is 102301.00 with 9 companies forming this group;

proc freq data = data2.us_companies;
run;

*2A: 8 tables, yes;

data companies;
set data2.us_companies;
year = year(founded);
run;

proc format;
value employeesfmt
0-<50000 = 'Less than 50,000'
50000-100000 = '50,000-100,000'
>100000 = 'More than 100,000';

value yearfmt 
1900-1929 = '1900-1929'
1930-1959 = '1930-1959'
1960-1989='1960-1989'
1990-2019='1990-2019'
2020-2023='2020-2023';


proc freq data = companies;
format employees employeesfmt.
year yearfmt.;
tables year employees;
run;

*Year has 18 missing and employees has none missing;

proc freq data = companies;
tables year*employees;
format employees employeesfmt.
year yearfmt.;
run;

proc tabulate data = companies;
class year employees;
var revenue;
format year yearfmt.
employees employeesfmt.;
table year employees*revenue*mean;

proc tabulate data = companies;
class year employees;
var revenue;
table year, employees;

*year, employees, mean;

proc tabulate data = companies;
class year employees;
format year yearfmt.
employees employeesfmt.;
var revenue;
table year all, employees*revenue*mean all*revenue*mean;
run;

ods listing file = '/home/u43404064/usco_list.lst';
proc report data = companies;
column industry revenue employees;
where rev_growth >=0.05;
format year yearfmt.
employees employeesfmt.;
define revenue / format = comma10. 'Revenue in millions of USD';
ods listing close;

ods listing file = '/home/u43404064/usco_summary.lst';
proc report data = companies headskip headline;
title 'Revenue Analysis';
column industry revenue employees;
where rev_growth >=0.05;
format year yearfmt.
employees employeesfmt.;
options ls=90 pageno=2;
define revenue / group width=5 analysis mean format = comma10. 'Average Revenue in millions of USD';
define industry / 'Industry';
define employees / width=5 'Number of Employees';
break after revenue / summarize ol;
rbreak after / summarize dol;
ods listing close;








