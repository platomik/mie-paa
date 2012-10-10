#!/usr/bin/perl

sub print_list {
  $max = $_[0];
  for ($i=0; $i<$max; $i++)
  {
    print "$i.  $V[$i][0]\t $V[$i][1]\n";
  }
}

@V = ( [10, "Null"], [11, "Null"], [12, "Null" ]);
@S = ( [0, "Null"], [0, "Null"], [0, "Null" ]);
@T = ( [5, "Null"], [6, "Null"], [6, "Null" ]);


#$max = $#V + 1;

print "Initial Values\n";
print_list($max);

print "\n\n";

# Create Some Links
$V[0][1] = 2;
$V[2][1] = 1;

print "Made Links\n";
print_list($max);

print "\n\n";

$next = 0;

#Step through Linked List
print "Traversing list:\n";
while ($next !~ "Null"){
  print "$V[$next][0] \n";
  $next = $V[$next][1];
}

print "\n\n";
