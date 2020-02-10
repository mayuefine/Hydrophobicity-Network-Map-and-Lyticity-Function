# Hydrophobicity-Network-Map-and-Lyticity-Function
This is rewrite code of Loren D. Walensky`s work.
They already provide online severs at: https://walenskylab.org/HNM/HNM_LI/

The publish research at here: https://www.nature.com/articles/s41587-019-0222-z

If you find this analysis works for you, please cite their work.

"Mourtada, Rida, et al. "Design of stapled antimicrobial peptides that are stable, nontoxic and kill antibiotic-resistant bacteria in mice." Nature biotechnology 37.10 (2019): 1186-1197."

Here are the example from them publiation:
![image](https://github.com/mayuefine/Hydrophobicity-Network-Map-and-Lyticity-Function/blob/master/picture/01.png)

My code will generate a series sequences like this.

Using a fasta format sequence data as input data to the script named LI.pl, and this script will do this work:

1. Generate series sequences, that each sequence have two position AA repalced by letter "X";

2. Calculated Lyticity index for eache generated sequences;

3. Plot a Hydrophobicity-Network-Map as described in Articles, like this:

![image](https://github.com/mayuefine/Hydrophobicity-Network-Map-and-Lyticity-Function/blob/master/picture/02.png)

Notice! 
1. Input sequences length between 5 and 40 amino acids long;
2. Please make sure the AMP peptide is an alpha-helix；
3. The insert S5 stapling amino acids, "X", at i,i+4 positions within sequence, and if you need other kind of modifier, youmay need to change the perl script.
