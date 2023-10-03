
data magazine;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap10. 기타 회귀\magazine.txt" expandtabs firstobs=2;
	length Magazine $30.;
	input Magazine$ P R;
	id=_N_;
run;
/*기본 모형 적합*/
proc reg data=magazine plots=none;
	model R=P;
	output out=magazine_out student=ri p=pred h=hi DFFITS=DFFITS cookd=cookd;;
run;
/*특이값 및 잔차 plot 확인*/
proc gplot data=magazine_out;
	plot ri*P;
	plot R*P;
	plot DFFITS*id;
	plot cookd*id;
run;
/*특이값 제거*/
data magazine2;
	set magazine;
	if id=23 then delete;
run;
/*제거된 데이터에 재적합*/
proc reg data=magazine2 plots=none;
	model R=P;
	output out=magazine2_out student=ri p=pred h=hi DFFITS=DFFITS cookd=cookd;;
quit;
/*특이값 및 잔차 다시 확인*/
proc gplot data=magazine2_out;
	plot ri*P;
	plot R*P;
	plot DFFITS*id / vaxis=-13 to 1 by 1;
	plot cookd*id / vaxis= 0 to 40 by 10;
run;

/*모형이 더 좋아지도록 변수변환*/
data magazine3;
	set magazine2;
	rtR=sqrt(R);
run;
/*변환된 변수를 통해 적합*/
proc reg data=magazine3 plots=none;
	model rtR=P;
	output out=magazine3_out student=ri p=pred h=hi DFFITS=DFFITS cookd=cookd;;
quit;
/*잔차plot이 더 좋아지는 것을 확인*/
proc gplot data=magazine3_out;
	plot ri*P;
	plot rtR*P;
run;





data gasoline;
	infile "D:\대학원 자료\회귀분석실습\2015회귀분석실습\chap10. 기타 회귀\gasoline.txt" expandtabs firstobs=2;
	input Y X1-X11;
	id=_N_;
run;
/*산점도*/
proc sgscatter data=gasoline;
	matrix y x1-x11;
run;
/*corr*/
proc corr data=gasoline noprob;
	var y x1-x11;
run;
/*vif*/
proc reg data=gasoline plots=none;
	model y=x1-x11 / vif;
run;

/*다중공선성이 존재하는 변수만 선택*/
proc reg data=gasoline plots=none;
	model y=x1-x3 x7 x8 x10 / vif;
run;

/*PC를 위한 표준화*/
proc standard data=gasoline mean=0 std=1 out=gasoline_stand;
	var y x1-x11;
run;
/*주성분분석을 통해 pc 추출*/
/*첫번째 성분만으로 87% 설명 가능->eigenvalue*/
proc princomp data=gasoline_stand out=gasoline_pc;
	var x1-x3 x7 x8 x10;
run;
/*주성분 회귀분석*/
/*주성분 회귀분석 결과 prin1만 유의하고 나머지는 유의하지 않다->첫번째성분만으로 설명이 가능하다는 것을 반증*/
proc reg data=gasoline_pc plots=none;
	model y=prin1-prin7;
run;


/*각 변수선택 방법에 따른 비교*/
proc reg data=gasoline plots=none;
	model y=x1-x3 x7 x8 x10/selection=forward;
	model y=x1-x3 x7 x8 x10/selection=backward;
	model y=x1-x3 x7 x8 x10/selection=stepwise;
quit;

/*logistic 적합-> 결과는 모두 유의하지 않음*/
/*그냥 해본 것임..*/
proc logistic data=gasoline;
	model X11(event='1')=x1-x10;
run;


