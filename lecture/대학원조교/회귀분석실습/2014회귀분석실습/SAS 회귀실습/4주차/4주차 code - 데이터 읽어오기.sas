/*page 2*/

/*가장 기본적인 형태*/
data sample;
	input x y z;
	cards;
8 2 1
5 34 14
41 3 12
;
run;

/*txt 파일로부터의 호출(변수명이 포함되지 않은 경우)*/
data sample;
	infile "C:\Users\Dharma\Desktop\sample.txt";
	input x y z;
run;
data temp.sample;
	infile "C:\Users\Dharma\Desktop\sample.txt";
	input x y z;
run;

/*txt파일로부터의 호출 및 sas 영구파일로 저장*/
Libname temp 'D:\' ;
data temp.sample;
	infile "C:\Users\Dharma\Desktop\sample.txt";
	input x y z;
run;

/* sas 영구파일 읽어오기 */
Libname temp 'D:\' ;
