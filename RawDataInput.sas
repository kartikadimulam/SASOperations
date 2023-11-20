LIBNAME data1 '/home/u43404064/data1';

data data1.insure;
	infile '/home/u43404064/data1/insure.sas7bdat';
	
run;

proc print data = data1.insure label;
var Company Name Policy BalanceDue;
WHERE Company='ACME' or Company='HOMELIFE' or Company='RELIABLE';
label Company='Insurance Company'
	Name = 'Policyholder'
	Policy = 'Policy Number'
	BalanceDue = 'Balance Due';
sum BalanceDue;

data work.soccer;
	input lname $ fname $ school $ age position $;
	cards;
	Gerbet Joran Clemson 22 Mid
	Silva Tommy UCLA 21 Def
	Soto Christian Washington 22 Mid
	Wynne Ronan Denver 23 Def
	Lopez Alex Tulsa 21 Goal
	;
run;
proc print data = work.soccer noobs label N;
var fname lname age school position;
label fname = 'First Name'
lname = 'Last Name'
age = 'Age'
school = 'University'
position = 'Position';
run;

	

	
