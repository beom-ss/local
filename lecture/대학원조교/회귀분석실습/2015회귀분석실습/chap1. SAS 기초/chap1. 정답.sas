
/*page 23) 예제*/

/*1) list*/
data smoke1;
	input id smoke$ gender$ age height;
	cards;
1 Y m 32 185.52
2 N f 65 177.71
3 Y f 24 177.15
4 Y m 19 180.67
;
run;
/*2) column*/
data smoke2;
	input id 1 smoke$ 3 gender$ 5 age 7-8 height 10-15;
	cards;
1 Y m 32 185.52
2 N f 65 177.71
3 Y f 24 177.15
4 Y m 19 180.67
;
run;
/*3) formatted*/
data smoke3;
	input id 1.  smoke$ 3. gender$ 2. age 3. height 5.2;
	cards;
1 Y m 32 185.52
2 N f 65 177.71
3 Y f 24 177.15
4 Y m 19 180.67
;
run;


/*4) named*/
data smoke4;
	input id= smoke=$ gender=$ age= height=;
	cards;
id=1 smoke=Y gender=m age=32 height=185.52
id=2 smoke=N gender=f age=65 height=177.71
id=3 smoke=Y gender=f age=24 height=177.15
id=4 smoke=Y gender=m age=19 height=180.67
;
run;

/*cf*/
/*formatted input을 혼용해서 사용하는 경우*/
data smoke3;
	input id 2.  smoke$ gender$ age  height 7.2;
	cards;
1 Y m 32 185.52
2 N f 65 177.71
3 Y f 24 177.15
4 Y m 19 180.67
;
run;
