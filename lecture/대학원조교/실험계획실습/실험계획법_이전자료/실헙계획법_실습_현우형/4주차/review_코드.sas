data review;
input x $ y;
cards;
A 4.3
A 5.8
A 5.1
A 5.5
A 4.5
B 6.4
B 6.6
B 5.9
B 6.0
B 6.1
;run;

/* ���Լ� ���� check */
proc univariate data=review normal;
by x;
var y;
run;

/* �׷��� ��� on */
ods graphics on;

proc ttest data=review alpha=0.05 plots(only)=QQ ;
class x;
var y;
run;

ods graphics off;
/* �׷��� ��� off */
