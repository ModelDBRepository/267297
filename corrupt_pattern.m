function [corrupted_input]=corrupt_pattern(pattern)
% corrompe un pattern selezionato, ponendo il 30% dei suoi pixel a 0.

index=find(pattern==1);
corrupted_input=pattern;
Conta=sum(pattern); %numero di pixel a 1 pre-corruzione.
rng('shuffle')
while sum(corrupted_input)>0.7*Conta
    n=randi(length(index),1,1);
    pos=index(n);
    corrupted_input(pos)=0;
end

end

