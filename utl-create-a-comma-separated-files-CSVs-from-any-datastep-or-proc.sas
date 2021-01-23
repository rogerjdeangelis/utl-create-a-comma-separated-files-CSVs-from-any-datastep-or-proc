%let pgm=utl-create-a-comma-separated-files-csvs-from-any-datastep-or-proc;

Create comma separated files CSVs from any datastep or proc

    Solutions

       a. Using tagset Simplecsv
          download csvtags.tpl
          https://support.sas.com/rnd/base/ods/odsmarkup

       b. Dosubl solution

       c. ds2csv SAS macro
          https://tinyurl.com/y5xnhfbz

       d. Without quotes ( nice example of vnext )
          by datanull_
          datanull@GMAIL.COM

       e. CSVALL by
          Jeff Kroll
          jmkroll@gmail.com

       f. dexport
          dm "dexport sashelp.classfit 'd:/csv/classfit.csv'";

github
https://tinyurl.com/upcxoyq
https://github.com/rogerjdeangelis/utl-create-a-comma-separated-files-CSVs-from-any-datastep-or-proc

SAS doc on ds2csv macro
https://tinyurl.com/y5xnhfbz
https://documentation.sas.com/?docsetId=lebaseutilref&docsetTarget=n0yo3bszlrh0byn1j4fxh4ndei8u.htm&docsetVersion=9.4&locale=en

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

data class;
   set sashelp.classfit(keep=name sex age);
run;quit;

Up to 40 obs WORK.CLASS total obs=19

Obs    NAME       SEX    AGE

  1    Joyce       F      11
  2    Louise      F      12
  3    Alice       F      13
  4    James       M      12
 ...

*             _               _
   ___  _   _| |_ _ __  _   _| |_
  / _ \| | | | __| '_ \| | | | __|
 | (_) | |_| | |_| |_) | |_| | |_
  \___/ \__,_|\__| .__/ \__,_|\__|
                 |_|
;

"SEX","Frequency"," Percent"
"F","9","47.37"
"M","10","52.63"

*
 _ __  _ __ ___   ___ ___  ___ ___
| '_ \| '__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
           _                       _
  __ _    | |_ __ _  __ _ ___  ___| |_
 / _` |   | __/ _` |/ _` / __|/ _ \ __|
| (_| |_  | || (_| | (_| \__ \  __/ |_
 \__,_(_)  \__\__,_|\__, |___/\___|\__|
                    |___/
;

/* download csv tagset and copy to your autocall library; */

%inc "c:/oto/csvtags.tpl";  * compile tagset;

data class;
   set sashelp.classfit(keep=name sex age);
run;quit;


ods Tagsets.Simplecsv file='d:/csv/tagsets.csv';

proc freq data=class;
        table sex / norow nocum;
run;quit;

ods Tagsets.Simplecsv close;


*_            _                 _     _
| |__      __| | ___  ___ _   _| |__ | |
| '_ \    / _` |/ _ \/ __| | | | '_ \| |
| |_) |  | (_| | (_) \__ \ |_| | |_) | |
|_.__(_)  \__,_|\___/|___/\__,_|_.__/|_|

;

data class;
   set sashelp.classfit(keep=name sex age);
run;quit;

data _null_;
  if _n_=0 then do; %let rc=%sysfunc(dosubl('
      proc freq data=class;
        table sex / out=tab;
      run;quit;
      '));
      %let hdr=%utl_varlist(tab,qstyle=DOUBLE,od=%str(,));
   end;

   file "d:/csv/dosubcsv.csv";

   * temp[1] vars not part of _character_ _numeric_;
   array temp[1] $4096 _temporary_;
   temp[1]=resolve('&hdr');
   put temp[1];

   do until (dne);
      set tab end=dne;
      put (_character_) ($quote. ',') "," (_numeric_) (best. ',');
   end;

   stop;
run;quit;

*    _     ____
  __| |___|___ \ ___ _____   __  _ __ ___   __ _  ___ _ __ ___
 / _` / __| __) / __/ __\ \ / / | '_ ` _ \ / _` |/ __| '__/ _ \
| (_| \__ \/ __/ (__\__ \\ V /  | | | | | | (_| | (__| | | (_) |
 \__,_|___/_____\___|___/ \_/   |_| |_| |_|\__,_|\___|_|  \___/

;

%ds2csv(data=work.tab,RUNMODE=B,csvfILE=d:/csv/tabds2csv.csv,labels=N);

*         _ _   _                 _                       _
__      _(_) |_| |__   ___  _   _| |_    __ _ _   _  ___ | |_ ___  ___
\ \ /\ / / | __| '_ \ / _ \| | | | __|  / _` | | | |/ _ \| __/ _ \/ __|
 \ V  V /| | |_| | | | (_) | |_| | |_  | (_| | |_| | (_) | ||  __/\__ \
  \_/\_/ |_|\__|_| |_|\___/ \__,_|\__|  \__, |\__,_|\___/ \__\___||___/
                                           |_|
;

* Recent nice example but does not quote char vars and;
* may not handle quotes or commas within quotes;

* nice example of vnext;

* by datanull_;
* datanull@GMAIL.COM;

filename FT66F001 'file-name.csv' lrecl=100000;
data _null_;
   set sashelp.class;
   file FT66F001 dsd;
   if _n_ eq 1 then link names;
   put (_all_)(:);
   return;
 names:
   length _name_ $32;
   do while(1);
      call vnext(_name_);
      if upcase(_name_) eq '_NAME_' then leave;
      put _name_ : @;
      end;
   put;
   return;
run;

OUTPUT
=====

NAME,SEX,AGE,HEIGHT,WEIGHT
Alfred,M,14,69,112.5
Alice,F,13,56.5,84
Barbara,F,13,65.3,98
Carol,F,14,62.8,102.5

*                             _ _
  ___      ___ _____   ____ _| | |
 / _ \    / __/ __\ \ / / _` | | |
|  __/_  | (__\__ \\ V / (_| | | |
 \___(_)  \___|___/ \_/ \__,_|_|_|

;

ODS CSVALL FILE="d:/csv/classv.csv";

 PROC PRINT DATA=sashelp.class;;
 RUN;

ODS CSVALL CLOSE;

"Obs","NAME","SEX","AGE","HEIGHT","WEIGHT"
"1","Alfred","M",14,69.0,112.5
"2","Alice","F",13,56.5,84.0
"3","Barbara","F",13,65.3,98.0
"4","Carol","F",14,62.8,102.5



* __        _                            _
 / _|    __| | _____  ___ __   ___  _ __| |_
| |_    / _` |/ _ \ \/ / '_ \ / _ \| '__| __|
|  _|  | (_| |  __/>  <| |_) | (_) | |  | |_
|_|(_)  \__,_|\___/_/\_\ .__/ \___/|_|   \__|
                       |_|
;

dm "dexport sashelp.classfit 'd:/csv/classfit.csv'";

NAME,SEX,AGE,HEIGHT,WEIGHT,PREDICT,LOWERMEAN,UPPERMEAN,LOWER,UPPER
Joyce,F,11,51.3,50.5,56.993334349,43.804363464,70.182305235,29.883498439,84.103170259
Louise,F,12,56.3,77,76.488485693,67.960050237,85.016921149,51.314521735,101.66244965
Alice,F,13,56.5,84,77.268291747,68.906553333,85.630030161,52.150311745,102.38627175
James,M,12,57.3,83,80.387515962,72.667088548,88.107943376,55.475686453,105.29934547
Thomas,M,11,57.5,85,81.167322016,73.600043341,88.73460069,56.3025285,106.03211553
John,M,12,59,99.5,87.015867419,80.4792515,93.552483338,62.445120631,111.58661421
Jane,F,12,59.8,84.5,90.135091634,84.039505624,96.230677643,65.677977764,114.5922055
Janet,F,15,62.5,112.5,100.66247336,95.225785487,106.09916123,76.361201272,124.96374545
Jeffrey,M,13,62.5,84,100.66247336,95.225785487,106.09916123,76.361201272,124.96374545
Carol,F,14,62.8,102.5,101.83218244,96.375045159,107.28931972,77.526327233,126.13803765
Henry,M,14,63.5,102.5,104.56150363,98.9820695,110.14093776,80.227898568,128.89510869
Judy,F,14,64.3,90,107.68072784,101.84160205,113.51985364,83.286268634,132.07518705
Robert,M,12,64.8,128,109.63024298,103.57059279,115.68989317,85.182060827,134.07842513
Barbara,F,13,65.3,98,111.57975811,105.26025322,117.89926301,87.06587649,136.09363973
Mary,F,15,66.5,112,116.25859443,109.18221905,123.33496982,91.538777715,140.97841115
William,M,15,66.5,112,116.25859443,109.18221905,123.33496982,91.538777715,140.97841115
Ronald,M,15,67,133,118.20810957,110.77121311,125.64500603,93.382685523,143.03353361
Alfred,M,14,69,112.5,126.00617011,116.94168423,135.07065599,100.64558742,151.36675279
Philip,M,16,72,150,137.70326091,125.8611556,149.54536623,111.2225187,164.18400313

