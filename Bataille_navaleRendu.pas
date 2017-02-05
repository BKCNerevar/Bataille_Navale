
program Bataille_navale;

uses crt;

CONST
	MAX = 10 ;					
	BateauMax = 5 ;				
	TAILLEMAX = 6 ;				

//BEGIN type
Type
	cellule = record
		ligne : INTEGER ;
		colonne : INTEGER ;
	END ;
	
Type
	Bateau = record
		n : cellule ;
		taille : INTEGER ;
		nom : STRING ;
	END ;
	
Type
	flotte = record
		n1 : Bateau ;
	END ;
	
Type	
	marge = record
		x : INTEGER ;
		y : INTEGER ;
	END ;

Type
	TabCellule = array [1..100] of cellule ;
	TabBateau = array[1..100] of Bateau ;
	TabFlotte = array[1..BateauMax,1..100] of flotte ;
	TabNom = array[1..8] of STRING ;
	Tab = array[1..20] of INTEGER ;

PROCEDURE IniTabCellule(VAR PosCellule,CelluleTOuche:TabCellule);

VAR
	i : INTEGER ;
	
BEGIN
	FOR i := 1 TO MAX DO
	BEGIN
		PosCellule[i].colonne := 0 ;
		PosCellule[i].ligne := 0 ;
		CelluleTOuche[i].colonne := 0 ;
		CelluleTOuche[i].ligne := 0 ;
	END;
END;

PROCEDURE IniTabFlotte(VAR Bateau:TabBateau; VAR Ensemble:TabFlotte);
VAR
	i : INTEGER ;
	j : INTEGER ;
BEGIN
	FOR i:=1 TO MAX DO
	BEGIN
		Bateau[i].n.colonne:=0;
		Bateau[i].n.ligne:=0;
		FOR j:=1 TO BateauMax DO
		BEGIN
			Ensemble[j,i].n1.n.colonne:=0;
			Ensemble[j,i].n1.n.ligne:=0;
		END;
	END;
END;

PROCEDURE AfficheMap();
VAR
	cpt,i,j:INTEGER;

BEGIN
		cpt:=7;
	FOR i:=1 TO MAX DO		
	BEGIN
		GoTOXY(cpt,5);
		WRITE(i);
		cpt:=cpt+4;
	END;
	
	
	cpt:=8;
	FOR i:=1 TO MAX DO		
	BEGIN
		FOR j:=1 TO MAX*3 DO
		BEGIN
			GoTOXY(3,cpt);
			WRITE(Chr(i+64));
		END;
		cpt:=cpt+3;
	END;
		
END;

PROCEDURE Clrtxt2();
VAR
	i,j:INTEGER;
BEGIN

	FOR i:=13 TO 29 DO
	BEGIN
		FOR j:=49 TO 71 DO
		BEGIN
			GoTOXY(j,i);
			WRITE(' ');
		END;
	END;

END;

PROCEDURE Clrtxt3();
VAR
	i,j:INTEGER;
BEGIN

	FOR i:=34 TO 35 DO
	BEGIN
		FOR j:=49 TO 85 DO
		BEGIN
			GoTOXY(j,i);
			WRITE(' ');
		END;
	END;

END;

FUNCTION TestCaseLigne(Bateau:TabBateau;PosCellule:TabCellule;x,y,i:INTEGER):BOOLEAN;
VAR
	j:INTEGER;
	test,test2:BOOLEAN;
BEGIN
	test:=false;
	test2:=true;
	FOR j:=1 TO Bateau[i].taille DO
	BEGIN
		IF (Bateau[j].n.colonne<>PosCellule[y].colonne) AND (Bateau[j].n.ligne<>PosCellule[(x+(j-1))].ligne) THEN
		BEGIN
			test:=true;	
		END;
		
		IF test=false THEN
		BEGIN
			test2:=false;
		END;
	END;
	
	IF test2=false THEN
	BEGIN
		test:=false;
	END;
	
		TestCaseLigne:=test;

END;

FUNCTION TestCaseColonne(Bateau:TabBateau;PosCellule:TabCellule;x,y,i:INTEGER):BOOLEAN;
VAR
	j:INTEGER;
	test,test2:BOOLEAN;
BEGIN

	test:=false;	
	FOR j:=1 TO Bateau[i].taille DO
	BEGIN
		IF (Bateau[j].n.colonne<>PosCellule[(y+(j-1))].colonne) AND (Bateau[j].n.ligne<>PosCellule[x].ligne) THEN
		BEGIN
			test:=true;	
		END;
		
		IF test=false THEN
		BEGIN
			test2:=false;
		END;
	END;
	
	IF test2=false THEN
	BEGIN
		test:=false;
	END;

	TestCaseColonne:=test;

END;

FUNCTION TestCase(Bateau:TabBateau; Ensemble:TabFlotte):BOOLEAN;
VAR
	i,j,l,k:INTEGER;
	test:BOOLEAN;
BEGIN
	test:=true;
	
	FOR i:=1 TO BateauMax DO
	BEGIN
		FOR j:=1 TO BateauMax DO
		BEGIN
			FOR k:=1 TO Bateau[i].taille DO
			BEGIN
				FOR l:=1 TO Bateau[i].taille DO
				BEGIN
					IF (Ensemble[i,k].n1.n.ligne=Ensemble[j,l].n1.n.ligne) AND (Ensemble[i,k].n1.n.colonne=Ensemble[j,l].n1.n.colonne) AND (j<>i) THEN
					BEGIN
						test:=false;
					END;
				END;
			END;
		END;
	END;
	TestCase:=test;
END;

FUNCTION one1(car:STRING):INTEGER;
BEGIN
		IF length(car)=1 THEN
		BEGIN
			IF(ord(car[1])>=48) AND (ord(car[1])<=57) THEN
			BEGIN
				one1:=ord(car[1])-48
			END
				ELSE
					BEGIN
					one1:=0;
					END;
		END
		ELSE
			IF length(car)=2 THEN
			BEGIN
				
				IF (ord(car[1])=49) AND (ord(car[2])=48)THEN
				BEGIN
					one1:=10
				END
					ELSE
					BEGIN
						one1:=0;
					END;
			END;
			
			
END;

FUNCTION a1(car:CHAR):INTEGER;
BEGIN
	IF(ord(car)>=97) AND (ord(car)<97+MAX) THEN
	BEGIN	
		a1:=ord(car)-96
	END
		ELSE
			a1:=11;
END;

FUNCTION trouver(Ensemble:TabFlotte;Bateau:TabBateau;PosCellule:TabCellule;x,y:INTEGER;VAR nbr:INTEGER):BOOLEAN;
VAR
	i,j:INTEGER;
	test:BOOLEAN;
BEGIN
	test:=false;
	FOR i:=1 TO BateauMax DO
	BEGIN
		FOR j:=1 TO Bateau[i].taille DO
		BEGIN
			IF (Ensemble[i,j].n1.n.colonne=PosCellule[y].colonne) AND (Ensemble[i,j].n1.n.ligne=PosCellule[x].ligne) THEN
			BEGIN
				test:=true;
				nbr:=i;			
			END;
		END;
	END;
	trouver:=test;
END;

FUNCTION ENDal(Nb:Tab):BOOLEAN;
VAR
	i,cpt:INTEGER;
	test:BOOLEAN;
BEGIN
	test:=false;
	cpt:=0;
	FOR i:=1 TO BateauMax DO
	BEGIN
		IF Nb[i]<1 THEN
		BEGIN
			cpt:=cpt+1;
			IF cpt=BateauMax THEN
			BEGIN
				test:=true;
			END;
		END;
	END;
	
	ENDal:=test;

END;

PROCEDURE CreateCellule(VAR PosCellule:TabCellule);
VAR
	cpt,i:INTEGER;
BEGIN	
	
	cpt:=7;
	FOR i:=1 TO MAX DO	
	BEGIN
		PosCellule[i].ligne:=cpt;
		cpt:=cpt+4;
	END;

	cpt:=8;
	FOR i:=1 TO MAX DO	
	BEGIN
		PosCellule[i].colonne:=cpt;
		cpt:=cpt+3;
	END;


END;

PROCEDURE CreateBateau (PosCellule:TabCellule;VAR Bateau:TabBateau;i:INTEGER);
VAR
	j,x,y,randdirection:INTEGER;
	test:BOOLEAN;
BEGIN

	REPEAT
	BEGIN
	RanDOmize;
	
	
		RandDirection:=Random(2)+1;
	
		case RandDirection of
			1:BEGIN		
					REPEAT
					BEGIN
						x:=Random(MAX)+1;
						y:=Random(MAX)+1;
					END;
					UNTIL (y<=MAX-Bateau[i].taille);
					
					test:=TestCaseColonne(Bateau,PosCellule,x,y,i);	
					IF test=true THEN
					BEGIN
						
						FOR j:=1 TO Bateau[i].taille DO
						BEGIN
							Bateau[j].n.colonne:=PosCellule[(y+j)-1].colonne;
							Bateau[j].n.ligne:=PosCellule[x].ligne;
						END;
					END;
					
				END;
			
			2:BEGIN
					REPEAT
					BEGIN
						x:=RanDOm(MAX)+1;
						y:=RanDOm(MAX)+1;
					END;
					UNTIL (x<=MAX-Bateau[i].taille);
					
					test:=TestCaseLigne(Bateau,PosCellule,x,y,i);	
					IF test=true THEN
					BEGIN
						
						FOR j:=1 TO Bateau[i].taille DO
						BEGIN
							Bateau[j].n.colonne:=PosCellule[y].colonne;
							Bateau[j].n.ligne:=PosCellule[(x+j)-1].ligne;
						END;
					END;
				
				END;
		END;

	END;
	UNTIL (test=true);

END;

PROCEDURE TailleBateau(VAR Bateau:TabBateau;VAR tailleB:Tab);
VAR
	i,nbr:INTEGER;
BEGIN
	
	RanDOmize;
	
	FOR i:=1 TO BateauMax DO
	BEGIN
		REPEAT
			nbr:=RanDOm(TAILLEMAX)+1;
		UNTIL nbr>1;
		
		Bateau[i].taille:=nbr;
		tailleB[i]:=Bateau[i].taille;
	END;

END;

PROCEDURE CreateFlotte (Bateau:TabBateau; PosCellule:TabCellule; VAR Ensemble:TabFlotte);
VAR
	i,j:INTEGER;
	test:BOOLEAN;
BEGIN

	REPEAT
	BEGIN
		IniTabFlotte(Bateau,Ensemble);
		
		FOR i:=1 TO BateauMax DO
		BEGIN

			CreateBateau(PosCellule,Bateau,i);
			

			FOR j:=1 TO Bateau[i].taille DO
			BEGIN	
					Ensemble[i,j].n1.n.ligne:=Bateau[j].n.ligne;
					Ensemble[i,j].n1.n.colonne:=Bateau[j].n.colonne;
			END;

		END;

		test:=TestCase(Bateau,Ensemble);
		
	END;
	UNTIL (test=true);

END;
	//Debut programme principal
VAR
	
	PosCellule,CelluleTOuche:TabCellule;
	bateau:TabBateau;
	Nom:TabNom;
	tailleB:Tab;
	margin:marge;
	Ensemble:TabFlotte;
	x1,y1,i,k,j,nbr:INTEGER;
	y:CHAR;
	x,pseuDO:STRING;
	test:BOOLEAN;
	
	
BEGIN
	clrscr;
	
	IniTabCellule(PosCellule,CelluleTOuche);

	AfficheMap();	
	
	CreateCellule(PosCellule);

	TailleBateau(Bateau,tailleB);
	
	CreateFlotte(Bateau,PosCellule,Ensemble);
	
	REPEAT
	BEGIN

			REPEAT
			BEGIN
				
				GoTOXY(margin.x,margin.y+13);
				WRITE('Coordonne x ? 1-10');
				GoTOXY(margin.x,margin.y+14);
				WRITE('.');
				READLN(x);
				x1:=one1(x);
				IF (x1=0) THEN
				BEGIN
					FOR i:=margin.x TO margin.x+10 DO
					BEGIN
						GoTOXY(i,margin.y+14);
						WRITE(' ');
					END;
				END;
			END;
			UNTIL (x1<>0) AND (x<>'');;
			
			clrtxt3;
			
			REPEAT
			BEGIN
				GoTOXY(margin.x,margin.y+15);
				WRITE('Coordonne y ? a-j');
				GoTOXY(margin.x,margin.y+16);
				WRITE('.');
				READLN(y);
				y:=LowerCase(y);
				y1:=a1(y);
				IF (y1=11) THEN
				BEGIN
					FOR i:=margin.x TO margin.x+10 DO
					BEGIN
						GoTOXY(i,margin.y+16);
						WRITE(' ');
					END;
				END;
			END;
			UNTIL (y1<>11);
			
		test:=trouver(Ensemble,Bateau,PosCellule,x1,y1,nbr);
		
		IF test=true THEN
		BEGIN
			
			IF (CelluleTOuche[nbr].ligne<>PosCellule[x1].ligne) OR (CelluleTOuche[nbr].colonne<>PosCellule[y1].colonne) THEN
			BEGIN
				
				IF (tailleB[nbr]>0) THEN
				BEGIN
				CelluleTOuche[nbr].ligne:=PosCellule[x1].ligne;
				CelluleTOuche[nbr].colonne:=PosCellule[y1].colonne;
			
				GoTOXY(PosCellule[x1].ligne,PosCellule[y1].colonne);
				WRITE('X');
				GoTOXY(margin.x,margin.y+24);
				WRITE(Nom[nbr],' toucher !');
				tailleB[nbr]:=tailleB[nbr]-1;
				END;
				
				IF tailleB[nbr]<=0 THEN
				BEGIN
					GoTOXY(margin.x,margin.y+25);
					WRITE('vous avez coule un Bateau !');
					FOR i:=1 TO Bateau[nbr].taille DO
					BEGIN
						GoTOXY(Ensemble[nbr,i].n1.n.ligne,Ensemble[nbr,i].n1.n.colonne);
						WRITE('C');
					END;
					tailleB[nbr]:=-1;
				END;
			END
		END
		ELSE
		BEGIN
			GoTOXY(PosCellule[x1].ligne,PosCellule[y1].colonne);
			WRITE('0');
		END;
		
		clrtxt2;

			
		test:=ENDal(tailleB);
	END;
	UNTIL test=true;
	delay(2000);
	
	clrtxt3;
	
	GoTOXY(margin.x,margin.y+24);
	WRITE('FIN');

	
	READLN;
END.