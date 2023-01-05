#!/usr/bin/env nextflow

params.cutoff = 10

process filterFasta {
input:
path fastaFile
val cutoff
output:
path "output.txt"
script:
"""
#!/usr/bin/env python3
from Bio import SeqIO
with open("$fastaFile") as inF:
	with open("output.txt", "w") as outF:
		for record in SeqIO.parse(inF, "fasta"):
			if len(record.seq) > $cutoff:				
				outF.write(">"+str(record.description+"\\n"))
				outF.write(str(record.seq)+"\\n")
"""
}

workflow {
	fastaFile = Channel.fromPath(params.inputFile)
	filterFasta(fastaFile, params.cutoff)	
}	
