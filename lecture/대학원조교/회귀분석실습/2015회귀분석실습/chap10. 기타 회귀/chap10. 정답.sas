
data magazine;
	infile "D:\���п� �ڷ�\ȸ�ͺм��ǽ�\2015ȸ�ͺм��ǽ�\chap10. ��Ÿ ȸ��\magazine.txt" expandtabs firstobs=2;
	length Magazine $30.;
	input Magazine$ P R;
	id=_N_;
run;
/*�⺻ ���� ����*/
proc reg data=magazine plots=none;
	model R=P;
	output out=magazine_out student=ri p=pred h=hi DFFITS=DFFITS cookd=cookd;;
run;
/*Ư�̰� �� ���� plot Ȯ��*/
proc gplot data=magazine_out;
	plot ri*P;
	plot R*P;
	plot DFFITS*id;
	plot cookd*id;
run;
/*Ư�̰� ����*/
data magazine2;
	set magazine;
	if id=23 then delete;
run;
/*���ŵ� �����Ϳ� ������*/
proc reg data=magazine2 plots=none;
	model R=P;
	output out=magazine2_out student=ri p=pred h=hi DFFITS=DFFITS cookd=cookd;;
quit;
/*Ư�̰� �� ���� �ٽ� Ȯ��*/
proc gplot data=magazine2_out;
	plot ri*P;
	plot R*P;
	plot DFFITS*id / vaxis=-13 to 1 by 1;
	plot cookd*id / vaxis= 0 to 40 by 10;
run;

/*������ �� ���������� ������ȯ*/
data magazine3;
	set magazine2;
	rtR=sqrt(R);
run;
/*��ȯ�� ������ ���� ����*/
proc reg data=magazine3 plots=none;
	model rtR=P;
	output out=magazine3_out student=ri p=pred h=hi DFFITS=DFFITS cookd=cookd;;
quit;
/*����plot�� �� �������� ���� Ȯ��*/
proc gplot data=magazine3_out;
	plot ri*P;
	plot rtR*P;
run;





data gasoline;
	infile "D:\���п� �ڷ�\ȸ�ͺм��ǽ�\2015ȸ�ͺм��ǽ�\chap10. ��Ÿ ȸ��\gasoline.txt" expandtabs firstobs=2;
	input Y X1-X11;
	id=_N_;
run;
/*������*/
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

/*���߰������� �����ϴ� ������ ����*/
proc reg data=gasoline plots=none;
	model y=x1-x3 x7 x8 x10 / vif;
run;

/*PC�� ���� ǥ��ȭ*/
proc standard data=gasoline mean=0 std=1 out=gasoline_stand;
	var y x1-x11;
run;
/*�ּ��км��� ���� pc ����*/
/*ù��° ���и����� 87% ���� ����->eigenvalue*/
proc princomp data=gasoline_stand out=gasoline_pc;
	var x1-x3 x7 x8 x10;
run;
/*�ּ��� ȸ�ͺм�*/
/*�ּ��� ȸ�ͺм� ��� prin1�� �����ϰ� �������� �������� �ʴ�->ù��°���и����� ������ �����ϴٴ� ���� ����*/
proc reg data=gasoline_pc plots=none;
	model y=prin1-prin7;
run;


/*�� �������� ����� ���� ��*/
proc reg data=gasoline plots=none;
	model y=x1-x3 x7 x8 x10/selection=forward;
	model y=x1-x3 x7 x8 x10/selection=backward;
	model y=x1-x3 x7 x8 x10/selection=stepwise;
quit;

/*logistic ����-> ����� ��� �������� ����*/
/*�׳� �غ� ����..*/
proc logistic data=gasoline;
	model X11(event='1')=x1-x10;
run;


