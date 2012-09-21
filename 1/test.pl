#!/usr/bin/perl

@C = (1,5,3);;
@V = (5,2,1);;
@sortedIndices = sort{ $V[ $a ] <=> $V[ $b ] } 0 .. $#V;;

@C = @C[ @sortedIndices ];;
@V = @V[ @sortedIndices ];;

print "@C\n@V";;