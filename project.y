%{
   
	#include <stdio.h>
	#include <stdlib.h>
	#include <iostream>
	#include <string>
      #include <vector>
      #include <utility>
	using namespace std;
	#include "y.tab.h"
	extern FILE *yyin;
      void yyerror(string s);
	extern int yylex();
	extern int linenum;


      vector< pair<string,int>> path;
      vector< pair<string,string>>who_what;
      vector <int> ps;
     
      vector< pair<string,int> >last_place;
      vector<string>who;
%}

%union
{
char *str;
int number;

}
%token DOT
%token <str> SYMBOL BLOCK MOVE CHECK CAPTURES CM CQS CKS 
%token <number> BLOCKNUM 
%type <str> statement_symbol do_symbol player_n


%%
chess:
      rounds round
      ;
rounds:
      rounds round
      |
      round
      ;
round:
      player_notation_C player_notation_C
      |
      player_notation_C      
      ; 
player_notation_C:
       player_n do_symbol {
           string symbol=$2;
           
           if(symbol=="#"){
              symbol=" Checkmate ";
           }
           if(symbol=="+"){
              symbol=" Check ";
           }
           int i=ps.size()-1;
           string avatar;
           if("K"==who_what[i].first){
              avatar="king";
           }
           if("Q"==who_what[i].first){
              avatar="queen";
           }
           if("R"==who_what[i].first){
              avatar="rook";
           }
           if("B"==who_what[i].first){
              avatar="bishop";
           }
           if("N"==who_what[i].first){
              avatar="knight";
           }
           if("p"==who_what[i].first){
              avatar="pawn";
           }
           string statement;
           if(who_what[i].second=="-"){
              statement=" moves to ";
           }
      
           int a=(i*2);
           if(i%2==0){
              int s=a+1;
              
              if("O-O-O"==who_what[i].first){
                 cout<<"\nThe white is castling to Queen’s side";
              }
              if("O-O"==who_what[i].first){
                 cout<<"\nThe white is castling to King’s side";
              }
              else{
                 if(who_what[i].second=="x"){
                      for(int v=0;v<who.size();v++){
                         if((last_place[v].first==path[s].first)&&(last_place[v].second==path[s].second)){
                                string t(" takes the ");
                                string p=who[v];
                                string o(" on ");
                                statement= t + p + o;
                         }
                       }
                 }
                 
                 cout<<"\nThe white "<<avatar<<" on "<<path[a].first<<path[a].second<< statement << path[s].first << path[s].second << symbol;
                 last_place.push_back(make_pair(path[s].first,path[s].second));
                 who.push_back(avatar);
              }
           }
           if(i%2!=0){
              int s=a+1;
              if("O-O-O"==who_what[i].first){
                 cout<<"\nThe black is castling to Queen’s side"<<"\n";
              }
              if("O-O"==who_what[i].first){
                 cout<<"\nThe black is castling to King’s side"<<"\n";
              }
              else{
                 if(who_what[i].second=="x"){
                      for(int v=0;v<who.size();v++){
                         if((last_place[v].first==path[s].first)&&(last_place[v].second==path[s].second)){
                                string t(" takes the ");
                                string p=who[v];
                                string o(" on ");
                                statement= t + p + o;
                         }
                       }
                 }
                 cout<<"\nThe black "<< avatar <<" on "<<path[a].first<<path[a].second<< statement << path[s].first << path[s].second<< symbol <<"\n";
                 last_place.push_back(make_pair(path[s].first,path[s].second));
                 who.push_back(avatar);
              }
           }
              
    
      }
      |
      player_n {
           int i=ps.size()-1;
           string avatar;
           if("K"==who_what[i].first){
              avatar="king";
           }
           if("Q"==who_what[i].first){
              avatar="queen";
           }
           if("R"==who_what[i].first){
              avatar="rook";
           }
           if("B"==who_what[i].first){
              avatar="bishop";
           }
           if("N"==who_what[i].first){
              avatar="knight";
           }
           if("p"==who_what[i].first){
              avatar="pawn";
           }
           string statement;
           if(who_what[i].second=="-"){
              statement=" moves to ";
           }
    
           int a=(i*2);
           if(i%2==0){
              int s=a+1;
              
              if("O-O-O"==who_what[i].first){
                 cout<<"\nThe white is castling to Queen’s side";
              }
              if("O-O"==who_what[i].first){
                 cout<<"\nThe white is castling to King’s side";
              }
              else{
                 if(who_what[i].second=="x"){
                      for(int v=0;v<who.size();v++){
                         if((last_place[v].first==path[s].first)&&(last_place[v].second==path[s].second)){
                                string t(" takes the ");
                                string p=who[v];
                                string o(" on ");
                                statement= t + p + o;
                         }
                       }
                 }
                 cout<<"\nThe white "<<avatar<<" on "<<path[a].first<<path[a].second<< statement << path[s].first << path[s].second;
                 last_place.push_back(make_pair(path[s].first,path[s].second));
                 who.push_back(avatar);
              }
           }
           if(i%2!=0){
              int s=a+1;
              if("O-O-O"==who_what[i].first){
                 cout<<"\nThe black is castling to Queen’s side"<<"\n";
              }
              if("O-O"==who_what[i].first){
                 cout<<"\nThe black is castling to King’s side"<<"\n";
              }
              else{
                 if(who_what[i].second=="x"){
                      for(int v=0;v<who.size();v++){
                         if((last_place[v].first==path[s].first)&&(last_place[v].second==path[s].second)){
                                string t(" takes the ");
                                string p=who[v];
                                string o(" on ");
                                statement= t + p + o;
                         }
                       }
                 }
                 cout<<"\nThe black "<< avatar <<" on "<<path[a].first<<path[a].second<< statement << path[s].first << path[s].second<<"\n";
                 last_place.push_back(make_pair(path[s].first,path[s].second));
                 who.push_back(avatar);
              }
           }
              
      }
      |
      BLOCKNUM DOT player_n do_symbol {
           string symbol=$4;
           
           if(symbol=="#"){
              symbol=" Checkmate ";
           }
           if(symbol=="+"){
              symbol=" Check ";
           }
           int i=ps.size()-1;
           string avatar;
           if("K"==who_what[i].first){
              avatar="king";
           }
           if("Q"==who_what[i].first){
              avatar="queen";
           }
           if("R"==who_what[i].first){
              avatar="rook";
           }
           if("B"==who_what[i].first){
              avatar="bishop";
           }
           if("N"==who_what[i].first){
              avatar="knight";
           }
           if("p"==who_what[i].first){
              avatar="pawn";
           }
           string statement;
           if(who_what[i].second=="-"){
              statement=" moves to ";
           }
      
           int a=(i*2);
           if(i%2==0){
              int s=a+1;
              
              cout<<"\n MOVE "<< $1 <<"\n";
           
             
              if("O-O-O"==who_what[i].first){
                 cout<<"\nThe white is castling to Queen’s side";
              }
              if("O-O"==who_what[i].first){
                 cout<<"\nThe white is castling to King’s side";
              }
              else{
                 if(who_what[i].second=="x"){
                      for(int v=0;v<who.size();v++){
                         if((last_place[v].first==path[s].first)&&(last_place[v].second==path[s].second)){
                                string t(" takes the ");
                                string p=who[v];
                                string o(" on ");
                                statement= t + p + o;
                         }
                       }
                 }
                 
                 cout<<"\nThe white "<<avatar<<" on "<<path[a].first<<path[a].second<< statement << path[s].first << path[s].second << symbol;
                 last_place.push_back(make_pair(path[s].first,path[s].second));
                 who.push_back(avatar);
              }
           }
           if(i%2!=0){
              int s=a+1;
              if("O-O-O"==who_what[i].first){
                 cout<<"\nThe black is castling to Queen’s side"<<"\n";
              }
              if("O-O"==who_what[i].first){
                 cout<<"\nThe black is castling to King’s side"<<"\n";
              }
              else{
                 if(who_what[i].second=="x"){
                      for(int v=0;v<who.size();v++){
                         if((last_place[v].first==path[s].first)&&(last_place[v].second==path[s].second)){
                                string t(" takes the ");
                                string p=who[v];
                                string o(" on ");
                                statement= t + p + o;
                         }
                       }
                 }
                 cout<<"\nThe black "<< avatar <<" on "<<path[a].first<<path[a].second<< statement << path[s].first << path[s].second<< symbol <<"\n";
                 last_place.push_back(make_pair(path[s].first,path[s].second));
                 who.push_back(avatar);
              }
           }
              
    
      }
      |
      BLOCKNUM DOT player_n {
           int i=ps.size()-1;
           string avatar;
           if("K"==who_what[i].first){
              avatar="king";
           }
           if("Q"==who_what[i].first){
              avatar="queen";
           }
           if("R"==who_what[i].first){
              avatar="rook";
           }
           if("B"==who_what[i].first){
              avatar="bishop";
           }
           if("N"==who_what[i].first){
              avatar="knight";
           }
           if("p"==who_what[i].first){
              avatar="pawn";
           }
           string statement;
           if(who_what[i].second=="-"){
              statement=" moves to ";
           }
    
           int a=(i*2);
           if(i%2==0){
              int s=a+1;
              
              cout<<"\n MOVE "<< $1 <<"\n";
            
              if("O-O-O"==who_what[i].first){
                 cout<<"\nThe white is castling to Queen’s side";
              }
              if("O-O"==who_what[i].first){
                 cout<<"\nThe white is castling to King’s side";
              }
              else{
                 if(who_what[i].second=="x"){
                      for(int v=0;v<who.size();v++){
                         if((last_place[v].first==path[s].first)&&(last_place[v].second==path[s].second)){
                                string t(" takes the ");
                                string p=who[v];
                                string o(" on ");
                                statement= t + p + o;
                         }
                       }
                 }
                 cout<<"\nThe white "<<avatar<<" on "<<path[a].first<<path[a].second<< statement << path[s].first << path[s].second;
                 last_place.push_back(make_pair(path[s].first,path[s].second));
                 who.push_back(avatar);
              }
           }
           if(i%2!=0){
              int s=a+1;
              if("O-O-O"==who_what[i].first){
                 cout<<"\nThe black is castling to Queen’s side"<<"\n";
              }
              if("O-O"==who_what[i].first){
                 cout<<"\nThe black is castling to King’s side"<<"\n";
              }
              else{
                 if(who_what[i].second=="x"){
                      for(int v=0;v<who.size();v++){
                         if((last_place[v].first==path[s].first)&&(last_place[v].second==path[s].second)){
                                string t(" takes the ");
                                string p=who[v];
                                string o(" on ");
                                statement= t + p + o;
                         }
                       }
                 }
                 cout<<"\nThe black "<< avatar <<" on "<<path[a].first<<path[a].second<< statement << path[s].first << path[s].second<<"\n";
                 last_place.push_back(make_pair(path[s].first,path[s].second));
                 who.push_back(avatar);
              }
           }
              
      }
      ;
player_n:
      SYMBOL notation statement_symbol notation{
              
              who_what.push_back(make_pair($1,$3));
              ps.push_back(1);
      }
      |
      notation statement_symbol notation {
             string avatar="p";
             who_what.push_back(make_pair(avatar,$2));
             ps.push_back(1);
      }
      |
      CKS{
           
           string avatar=$1;
           who_what.push_back(make_pair(avatar,avatar));
           path.push_back(make_pair($1,1));
           path.push_back(make_pair($1,1));
           ps.push_back(1);
      }
      |
      CQS{ 
           string avatar=$1;
           who_what.push_back(make_pair(avatar,avatar));
           path.push_back(make_pair($1,1));
           path.push_back(make_pair($1,1));
           ps.push_back(1);
      } 
      ;
notation:
	BLOCK BLOCKNUM{
          
          path.push_back(make_pair($1,$2));
          
          
      } 
      ;
     
statement_symbol:
      CAPTURES{ 
           $$=$1;
      }
      |
      MOVE{ 
           $$=$1;
      }
      ;
do_symbol:
      CM{ 
           $$=$1;
      }
      |
      CHECK{ 
           $$=$1;
      }
      ;


%%
void yyerror(string s){
	cerr<<"Error at line: "<<linenum<<endl;
}

int yywrap(){
	return 1;
}
int main(int argc, char *argv[])
{
    /* Call the lexer, then quit. */
    yyin=fopen(argv[1],"r");
    yyparse();
    fclose(yyin);
    return 0;
}
