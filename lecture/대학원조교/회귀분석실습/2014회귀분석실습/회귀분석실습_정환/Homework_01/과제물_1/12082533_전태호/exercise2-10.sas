data table21;
infile "C:\Users\student\Desktop\data2.txt";
input Row H W;
run;
/*a번*/
proc corr;
variable h w;
run;                         /*<--- 결론 ??? */
/*c번 g번*/
proc reg data=table21;
model h=w;
quit;                        /*<--- 결론 ??? */
proc reg data=table21;
model h=;
quit;

/*h번*/                  /*<--- 결론 ??? */

/*j번-NO*/
proc plot;
plot h*w;
quit;

/*K번 - 모르겠음*/
