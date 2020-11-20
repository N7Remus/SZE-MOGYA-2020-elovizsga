param nRows;
set Rows := 1..nRows;

param cashierCount;
set Cashiers := 1..cashierCount;

param cashierLength;

set ProductGroups;
param space{ProductGroups};

var putProduct{ProductGroups, Rows} binary;
var putCashier{Cashiers, Rows} binary;
var rowLength{Rows} >= 0;
var longestRow >= 0;

s.t. CashiersMustBeSomewhereOnce{c in Cashiers}:
	sum{r in Rows} putCashier[c, r] = 1;

s.t. AllProductGroupsHaveToBePutSomewhereExactlyOnce{p in ProductGroups}:
	sum{r in Rows} putProduct[p, r] = 1;

s.t. CalculateRowLength{r in Rows}:
	rowLength[r] >= sum{p in ProductGroups} putProduct[p, r] * space[p] + sum{c in Cashiers} putCashier[c, r] * cashierLength;

s.t. SetLongestRow{r in Rows}:
	longestRow >= rowLength[r];

minimize LongestRow : longestRow;

solve;

# Kimenet

printf "The longest row: %f", LongestRow;
printf "\n\n";

/* data;
param nRows         :=   3;
param cashierCount  :=   1;
param cashierLength := 2.5;
set ProductGroups :=  Group1 Group2 Group3 Group4 Group5 Group6 Group7 Group8;
param space :=
	Group1	0.04
	Group2	0.62
	Group3	0.13
	Group4	1.28
	Group5	0.56
	Group6	0.21
	Group7	1.39
	Group8	1.47
; */
 
end;
