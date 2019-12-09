# utl-create-a-comma-separated-files-CSVs-from-any-datastep-or-proc
Create comma separated files CSVs from any datastep or proc                                                                          
                                                                                                                                     
    Solutions                                                                                                                        
                                                                                                                                     
       a. Using tagset Simplecsv                                                                                                     
          download csvtags.tpl                                                                                                       
          https://support.sas.com/rnd/base/ods/odsmarkup/                                                                            
                                                                                                                                     
          Solution on SAS-L  by                                                                                                      
          Tom Robinson                                                                                                               
          barefootguru@gmail.com                                                                                                     
                                                                                                                                     
       b. Dosubl solution                                                                                                            
                                                                                                                                     
       c. ds2csv SAS macro                                                                                                           
          https://tinyurl.com/y5xnhfbz                                                                                               
                                                                                                                                     
       d. Without quotes ( nice example of vnext )                                                                                   
          by datanull_                                                                                                               
          datanull@GMAIL.COM                                                                                                         
                                                                                                                                     
       d. CSVALL by                                                                                                                  
          Jeff Kroll                                                                                                                 
          jmkroll@gmail.com                                                                                                          
                                                                                                                                     
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
                                                                                                                                     
*    _                         _ _                                                                                                   
  __| |     ___ _____   ____ _| | |                                                                                                  
 / _` |    / __/ __\ \ / / _` | | |                                                                                                  
| (_| |_  | (__\__ \\ V / (_| | | |                                                                                                  
 \__,_(_)  \___|___/ \_/ \__,_|_|_|                                                                                                  
                                                                                                                                     
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
                                                                                                                                     
                                                                                                                                     
                                                                                             
